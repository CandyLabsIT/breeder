import 'dart:ui';

import 'package:breeder/blocks/pages/second_generation/a_second_generation_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/default_female_colors_restored_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/default_male_colors_restored_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/init_second_generation_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/iv_changed_female_colors_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/iv_changed_male_colors_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_generation/second_generation_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenerationCubit extends Cubit<ASecondGenerationState> {
  SecondGenerationModel secondGenerationModel = SecondGenerationModel();

  SecondGenerationCubit() : super(InitSecondGenerationState());

  void getFemaleColors(int listNumber, int femaleValue) {
    secondGenerationModel.updateValues(secondGenerationModel.secondGenerationIVList[listNumber][0], femaleValue);
    getChildrenIVColors(listNumber);
    emit(
      IVChangedFemaleColorsState(
        valuesList: _getColorsList(0),
      ),
    );
  }

  void getMaleColors(int listNumber, int maleValue) {
    secondGenerationModel.updateValues(secondGenerationModel.secondGenerationIVList[listNumber][1], maleValue);
    getChildrenIVColors(listNumber);
    emit(
      IVChangedMaleColorsState(valuesList: _getColorsList(1)),
    );
  }

  void resetFemaleValues(int listNumber) {
    if (secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationIVList[listNumber][0])) {
      secondGenerationModel.restartListValues(secondGenerationModel.secondGenerationIVList[listNumber][0]);
      getChildrenIVColors(listNumber);
    }
    emit(
      DefaultFemaleColorsRestoredState(valuesList: _getColorsList(0)),
    );
  }

  void resetMaleValues(int listNumber) {
    if (secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationIVList[listNumber][1])) {
      secondGenerationModel.restartListValues(secondGenerationModel.secondGenerationIVList[listNumber][1]);
      getChildrenIVColors(listNumber);
    }
    emit(
      DefaultMaleColorsRestoredState(valuesList: _getColorsList(1)),
    );
  }

  void resetValues() {
    secondGenerationModel.restartAll();
    emit(
      DefaultFemaleColorsRestoredState(valuesList: _getColorsList(0)),
    );
    emit(
      DefaultMaleColorsRestoredState(valuesList: _getColorsList(1)),
    );
  }

  List<Color> getFemaleButtonColors() {
    if (state is IVChangedFemaleColorsState) {
      return (state as IVChangedFemaleColorsState).valuesList;
    } else if (state is DefaultFemaleColorsRestoredState) {
      return (state as DefaultFemaleColorsRestoredState).valuesList;
    }
    return _getColorsList(0);
  }

  List<Color> getMaleButtonColors() {
    if (state is IVChangedMaleColorsState) {
      return (state as IVChangedMaleColorsState).valuesList;
    } else if (state is DefaultMaleColorsRestoredState) {
      return (state as DefaultMaleColorsRestoredState).valuesList;
    }
    return _getColorsList(1);
  }

  void getChildrenIVColors(int parentIndex) {
    int listIndex = getParentIndex(parentIndex);

    if (secondGenerationModel.isPairFilled(parentIndex)) {
      Set<int> femaleSet = secondGenerationModel.secondGenerationIVList[listIndex][0].toSet();
      Set<int> maleSet = secondGenerationModel.secondGenerationIVList[listIndex][1].toSet();
      List<int> childList = femaleSet.union(maleSet).toList();

      for (int i = 0; i < 3; i++) {
        secondGenerationModel.childrenColorsList[parentIndex][i] = IVColorExtension.fromInt(childList[i]).color;
      }
    } else {
      for (int i = 0; i < 3; i++) {
        secondGenerationModel.childrenColorsList[parentIndex][i] = IVColorExtension.fromInt(0).color;
      }
    }
  }

  int getParentIndex(int listNumber) {
    int parentListIndex = 0;
    if (listNumber != 0) {
      parentListIndex = listNumber % 2;
    }
    return parentListIndex;
  }

  List<bool> isFemaleButtonsEnabled(int listNumber) {
    return _getButtonsState(secondGenerationModel.secondGenerationIVList[listNumber][0], secondGenerationModel.secondGenerationIVList[listNumber][1]);
  }

  List<bool> isMaleButtonsEnabled(int listNumber) {
    return _getButtonsState(secondGenerationModel.secondGenerationIVList[listNumber][1], secondGenerationModel.secondGenerationIVList[listNumber][0]);
  }

  bool isFemaleRestartButtonEnabled(int listNumber) {
    return secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationIVList[listNumber][0]);
  }

  bool isMaleRestartButtonEnabled(int listNumber) {
    return secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationIVList[listNumber][1]);
  }

  List<bool> _getButtonsState(List<int> primaryList, List<int> secondaryList) {
    final List<bool> buttonsList = List<bool>.filled(7, true);

    if (secondGenerationModel.isSumPositive(primaryList)) {
      if (secondGenerationModel.hasCommonValue(primaryList, secondaryList)) {
        if (primaryList[0] != 0 && primaryList[1] != 0) {
          for (int i = 0; i < 7; i++) {
            buttonsList[i] = primaryList[0] == i || primaryList[1] == i;
          }
          return buttonsList;
        }
        if (secondaryList[0] != 0 && secondaryList[1] != 0) {
          int index = 0;
          if (primaryList[0] == secondaryList[0] || primaryList[1] == secondaryList[0]) {
            index = secondaryList[1];
            buttonsList[index] = false;
          } else if (primaryList[0] == secondaryList[1] || primaryList[1] == secondaryList[1]) {
            index = secondaryList[0];
            buttonsList[index] = false;
          }
        }
      } else {
        if (primaryList[0] != 0 && primaryList[1] != 0) {
          for (int i = 1; i < 7; i++) {
            buttonsList[i] = primaryList[0] == i || primaryList[1] == i;
          }
        } else {
          for (int i = 0; i < 7; i++) {
            buttonsList[i] = secondaryList[0] == i || secondaryList[1] == i || primaryList[0] == i || primaryList[1] == i;
          }
        }
      }
    }
    return buttonsList;
  }

  List<Color> _getColorsList(int index) {
    return <Color>[
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[0][index][0]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[0][index][1]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[1][index][0]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[1][index][1]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[2][index][0]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[2][index][1]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[3][index][0]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[3][index][1]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[4][index][0]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[4][index][1]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[5][index][0]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[5][index][1]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[6][index][0]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[6][index][1]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[7][index][0]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationIVList[7][index][1]).color,
    ];
  }
}
