import 'dart:ui';

import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_female_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_female_colors_default_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_init_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_male_colors_changed_state.dart.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_male_colors_default_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenCubit extends Cubit<ASecondGenState> {
  SecondGenModel secondGenerationModel = SecondGenModel();

  SecondGenCubit() : super(InitSecondGenState());

  void getFemaleColors(int femaleValue) {
    secondGenerationModel.updateValues(secondGenerationModel.secondGenFemaleIVList, femaleValue);
    emit(
      SecondGenFemaleColorsChangedState(colorsList: <Color>[
        IVColorExtension.fromInt(secondGenerationModel.secondGenFemaleIVList[0]).color,
        IVColorExtension.fromInt(secondGenerationModel.secondGenFemaleIVList[1]).color
      ]),
    );
  }

  void getMaleColors(int maleValue) {
    secondGenerationModel.updateValues(secondGenerationModel.secondGenMaleIVList, maleValue);
    emit(
      SecondGenMaleColorsChangedState(colorsList: <Color>[
        IVColorExtension.fromInt(secondGenerationModel.secondGenMaleIVList[0]).color,
        IVColorExtension.fromInt(secondGenerationModel.secondGenMaleIVList[1]).color
      ]),
    );
  }

  void getFemaleDefaultColors() {
    if (secondGenerationModel.isSumPositive(secondGenerationModel.secondGenFemaleIVList)) {
      secondGenerationModel.restartListValues(secondGenerationModel.secondGenFemaleIVList);
    }
    emit(
      SecondGenFemaleColorsDefaultState(
        colorsList: <Color>[
          IVColorExtension.fromInt(secondGenerationModel.secondGenFemaleIVList[0]).color,
          IVColorExtension.fromInt(secondGenerationModel.secondGenFemaleIVList[1]).color
        ],
      ),
    );
  }

  void getMaleDefaultColors() {
    if (secondGenerationModel.isSumPositive(secondGenerationModel.secondGenMaleIVList)) {
      secondGenerationModel.restartListValues(secondGenerationModel.secondGenMaleIVList);
    }
    emit(
      SecondGenMaleColorsDefaultState(
        colorsList: <Color>[
          IVColorExtension.fromInt(secondGenerationModel.secondGenMaleIVList[0]).color,
          IVColorExtension.fromInt(secondGenerationModel.secondGenMaleIVList[1]).color
        ],
      ),
    );
  }

  List<Color> getFemaleButtonColors() {
    if (state is SecondGenFemaleColorsChangedState) {
      return (state as SecondGenFemaleColorsChangedState).colorsList;
    } else if (state is SecondGenFemaleColorsDefaultState) {
      return (state as SecondGenFemaleColorsDefaultState).colorsList;
    }
    return <Color>[
      IVColorExtension.fromInt(secondGenerationModel.secondGenFemaleIVList[0]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenFemaleIVList[1]).color
    ];
  }

  List<Color> getMaleButtonColors() {
    if (state is SecondGenMaleColorsChangedState) {
      return (state as SecondGenMaleColorsChangedState).colorsList;
    } else if (state is SecondGenMaleColorsDefaultState) {
      return (state as SecondGenMaleColorsDefaultState).colorsList;
    }
    return <Color>[
      IVColorExtension.fromInt(secondGenerationModel.secondGenMaleIVList[0]).color,
      IVColorExtension.fromInt(secondGenerationModel.secondGenMaleIVList[1]).color
    ];
  }

  List<bool> getFemaleButtonsState() {
    return _getButtonsState(secondGenerationModel.secondGenFemaleIVList, secondGenerationModel.secondGenMaleIVList);
  }

  List<bool> isMaleButtonsEnabled() {
    return _getButtonsState(secondGenerationModel.secondGenMaleIVList, secondGenerationModel.secondGenFemaleIVList);
  }

  bool isFemaleRestartButtonEnabled() {
    return secondGenerationModel.isSumPositive(secondGenerationModel.secondGenFemaleIVList);
  }

  bool isMaleRestartButtonEnabled() {
    return secondGenerationModel.isSumPositive(secondGenerationModel.secondGenMaleIVList);
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
