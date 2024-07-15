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

  void getIVFemaleColors(int femaleValue) {
    secondGenerationModel.updateValues(secondGenerationModel.secondGenerationFemaleIVList, femaleValue);
    emit(
      IVChangedFemaleColorsState(valuesList: <Color>[
        IVColorExtension.fromInt(secondGenerationModel.secondGenerationFemaleIVList[0]).color,
        IVColorExtension.fromInt(secondGenerationModel.secondGenerationFemaleIVList[1]).color
      ]),
    );
  }

  void getIVMaleColors(int maleValue) {
    secondGenerationModel.updateValues(secondGenerationModel.secondGenerationMaleIVList, maleValue);
    emit(
      IVChangedMaleColorsState(valuesList: <Color>[
        IVColorExtension.fromInt(secondGenerationModel.secondGenerationMaleIVList[0]).color,
        IVColorExtension.fromInt(secondGenerationModel.secondGenerationMaleIVList[1]).color
      ]),
    );
  }

  void restoreFemaleDefaultColors() {
    if (secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationFemaleIVList)) {
      secondGenerationModel.restartListValues(secondGenerationModel.secondGenerationFemaleIVList);
    }
    emit(
      DefaultFemaleColorsRestoredState(
        valuesList: <Color>[
          IVColorExtension.fromInt(secondGenerationModel.secondGenerationFemaleIVList[0]).color,
          IVColorExtension.fromInt(secondGenerationModel.secondGenerationFemaleIVList[1]).color
        ],
      ),
    );
  }

  void restoreMaleDefaultColors() {
    if (secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationMaleIVList)) {
      secondGenerationModel.restartListValues(secondGenerationModel.secondGenerationMaleIVList);
    }
    emit(
      DefaultMaleColorsRestoredState(
        valuesList: <Color>[
          IVColorExtension.fromInt(secondGenerationModel.secondGenerationMaleIVList[0]).color,
          IVColorExtension.fromInt(secondGenerationModel.secondGenerationMaleIVList[1]).color
        ],
      ),
    );
  }

  List<Color> getFemaleButtonColors() {
    if (state is IVChangedFemaleColorsState) {
      return (state as IVChangedFemaleColorsState).valuesList;
    } else if (state is DefaultFemaleColorsRestoredState) {
      return (state as DefaultFemaleColorsRestoredState).valuesList;
    }
    return <Color>[
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationFemaleIVList[0]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationFemaleIVList[1]).color
    ];
  }

  List<Color> getMaleButtonColors() {
    if (state is IVChangedMaleColorsState) {
      return (state as IVChangedMaleColorsState).valuesList;
    } else if (state is DefaultMaleColorsRestoredState) {
      return (state as DefaultMaleColorsRestoredState).valuesList;
    }
    return <Color>[
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationMaleIVList[0]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenerationMaleIVList[1]).color
    ];
  }

  List<bool> isFemaleButtonsEnabled() {
    return _getButtonsState(secondGenerationModel.secondGenerationFemaleIVList, secondGenerationModel.secondGenerationMaleIVList);
  }

  List<bool> isMaleButtonsEnabled() {
    return _getButtonsState(secondGenerationModel.secondGenerationMaleIVList, secondGenerationModel.secondGenerationFemaleIVList);
  }

  bool isFemaleRestartButtonEnabled() {
    return secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationFemaleIVList);
  }

  bool isMaleRestartButtonEnabled() {
    return secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationMaleIVList);
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
}
