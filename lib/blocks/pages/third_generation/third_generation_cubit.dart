import 'package:breeder/blocks/pages/second_generation/second_generation_cubit.dart';
import 'package:breeder/blocks/pages/third_generation/a_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/init_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/restarted_third_generation_female_values_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/restarted_third_generation_male_values_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/third_generation_female_color_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/third_generation_male_color_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_generation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdGenerationCubit extends Cubit<AThirdGenerationState> {
  SecondGenerationCubit secondGenerationCubit = SecondGenerationCubit();
  ThirdGenerationModel thirdGenerationModel = ThirdGenerationModel();

  ThirdGenerationCubit() : super(InitSecondGenerationFamilyState());

  void getFemaleColors(int listNumber, int value) {
    int parentListIndex = getParentIndex(listNumber);

    if (secondGenerationCubit.secondGenerationModel.isPairFilled(parentListIndex)) {
      Set<int> femaleSet = secondGenerationCubit.secondGenerationModel.secondGenerationIVList[parentListIndex][0].toSet();
      Set<int> maleSet = secondGenerationCubit.secondGenerationModel.secondGenerationIVList[parentListIndex][1].toSet();
      List<int> childList = femaleSet.union(maleSet).toList();
      for (int i = 0; i < 3; i++) {
        thirdGenerationModel.updateValues(thirdGenerationModel.thirdGenerationIVList[listNumber][0], childList[i]);
      }
      emit(ThirdGenerationFemaleColorsState(valuesList: _getColorsList(0)));
    }
    thirdGenerationModel.updateValues(thirdGenerationModel.thirdGenerationIVList[listNumber][0], value);
    emit(ThirdGenerationFemaleColorsState(valuesList: _getColorsList(0)));
  }

  void getMaleColors(int listNumber, int value) {
    thirdGenerationModel.updateValues(thirdGenerationModel.thirdGenerationIVList[listNumber][1], value);
    emit(
      ThirdGenerationMaleColorsState(valuesList: _getColorsList(1)),
    );
  }

  void resetFemaleValues(int listNumber) {
    if (thirdGenerationModel.isSumPositive(thirdGenerationModel.thirdGenerationIVList[listNumber][0])) {
      thirdGenerationModel.restartListValues(thirdGenerationModel.thirdGenerationIVList[listNumber][0]);
    }
    emit(
      RestartedThirdGenerationFemaleValuesState(
        valuesList: _getColorsList(0),
      ),
    );
  }

  void resetThirdMaleValues(int listNumber) {
    if (thirdGenerationModel.isSumPositive(thirdGenerationModel.thirdGenerationIVList[listNumber][1])) {
      thirdGenerationModel.restartListValues(thirdGenerationModel.thirdGenerationIVList[listNumber][1]);
    }
    emit(
      RestartedThirdGenerationMaleValuesState(valuesList: _getColorsList(1)),
    );
  }

  List<Color> getFemaleButtonColors() {
    if (state is ThirdGenerationFemaleColorsState) {
      return (state as ThirdGenerationFemaleColorsState).valuesList;
    } else if (state is RestartedThirdGenerationFemaleValuesState) {
      return (state as RestartedThirdGenerationFemaleValuesState).valuesList;
    }
    return _getColorsList(0);
  }

  List<Color> getMaleButtonColors() {
    if (state is ThirdGenerationMaleColorsState) {
      return (state as ThirdGenerationMaleColorsState).valuesList;
    } else if (state is RestartedThirdGenerationMaleValuesState) {
      return (state as RestartedThirdGenerationMaleValuesState).valuesList;
    }
    return _getColorsList(1);
  }

  bool isFemaleRestartButtonEnabled(int listNumber) {
    return thirdGenerationModel.isSumPositive(thirdGenerationModel.thirdGenerationIVList[listNumber][0]);
  }

  bool isMaleRestartButtonEnabled(int listNumber) {
    return thirdGenerationModel.isSumPositive(thirdGenerationModel.thirdGenerationIVList[listNumber][1]);
  }

  List<bool> isFemaleButtonsEnabled(int listNumber) {
    return _getButtonsState(thirdGenerationModel.thirdGenerationIVList[listNumber][0], thirdGenerationModel.thirdGenerationIVList[listNumber][1]);
  }

  List<bool> isMaleButtonsEnabled(int listNumber) {
    return _getButtonsState(thirdGenerationModel.thirdGenerationIVList[listNumber][1], thirdGenerationModel.thirdGenerationIVList[listNumber][0]);
  }

  List<bool> _getButtonsState(List<int> primaryList, List<int> secondaryList) {
    final List<bool> buttonsList = List<bool>.filled(7, true);

    if (thirdGenerationModel.isSumPositive(primaryList)) {
      int primaryZeroCount = primaryList.where((int element) => element == 0).length;
      int secondaryZeroCount = secondaryList.where((int element) => element == 0).length;
      int commonValues = thirdGenerationModel.hasCommonValue(primaryList, secondaryList);

      if (primaryZeroCount == 0 && secondaryZeroCount == 3) {
        for (int i = 1; i < 7; i++) {
          buttonsList[i] = primaryList.contains(i);
        }
      } else if (primaryZeroCount == 0) {
        for (int i = 1; i < 7; i++) {
          buttonsList[i] = primaryList.contains(i);
        }
      } else if (secondaryZeroCount <= 1) {
        if ((primaryZeroCount == 2 && commonValues == 0) || (primaryZeroCount == 1 && commonValues == 1)) {
          for (int i = 1; i < 7; i++) {
            buttonsList[i] = primaryList.contains(i) || secondaryList.contains(i);
          }
        } else if (commonValues == 2 && primaryZeroCount == 1) {
          for (int i = 1; i < 7; i++) {
            buttonsList[i] = !secondaryList.contains(i) || primaryList.contains(i);
          }
        }
      }
    }
    return buttonsList;
  }

  Color getFemaleChildColor(int listNumber, int colorIndex){
    int parentListIndex = getParentIndex(listNumber);

    if (secondGenerationCubit.secondGenerationModel.isPairFilled(parentListIndex)) {
      Set<int> femaleSet = secondGenerationCubit.secondGenerationModel.secondGenerationIVList[parentListIndex][0].toSet();
      Set<int> maleSet = secondGenerationCubit.secondGenerationModel.secondGenerationIVList[parentListIndex][1].toSet();
      List<int> childList = femaleSet.union(maleSet).toList();

      for (int i = 0; i < 3; i++) {
        thirdGenerationModel.updateValues(thirdGenerationModel.thirdGenerationIVList[listNumber][0], childList[i]);
      }
      return IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][0][colorIndex]).color;
    }
    return const Color(0xFFD9D9D9);
  }

  int getParentIndex(int listNumber){
    int parentListIndex = 0;
    if (listNumber != 0) {
      parentListIndex = listNumber % 2;
    }
    return parentListIndex;
  }



  List<Color> _getColorsList(int index) {
    return <Color>[
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[0][index][0]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[0][index][1]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[0][index][2]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[1][index][0]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[1][index][1]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[1][index][2]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[2][index][0]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[2][index][1]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[2][index][2]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[3][index][0]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[3][index][1]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[3][index][2]).color,
    ];
  }
}
