import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/third_generation/a_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/init_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/restarted_third_generation_female_values_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/restarted_third_generation_male_values_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/third_generation_female_color_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/third_generation_male_color_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_generation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdGenerationCubit extends Cubit<AThirdGenerationState> {
  SecondGenCubit secondGenCubit = globalLocator<SecondGenCubit>();
  ThirdGenerationModel thirdGenerationModel = ThirdGenerationModel();

  ThirdGenerationCubit() : super(InitSecondGenerationFamilyState());

  void getFemaleColors(int listNumber, int value) {
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
    if (thirdGenerationModel.isIVListFilled(thirdGenerationModel.thirdGenerationIVList[listNumber][0])) {
      thirdGenerationModel.resetIVListValues(thirdGenerationModel.thirdGenerationIVList[listNumber][0]);
    }
    emit(
      RestartedThirdGenerationFemaleValuesState(
        valuesList: _getColorsList(0),
      ),
    );
  }

  void resetThirdMaleValues(int listNumber) {
    if (thirdGenerationModel.isIVListFilled(thirdGenerationModel.thirdGenerationIVList[listNumber][1])) {
      thirdGenerationModel.resetIVListValues(thirdGenerationModel.thirdGenerationIVList[listNumber][1]);
    }
    emit(
      RestartedThirdGenerationMaleValuesState(valuesList: _getColorsList(1)),
    );
  }

  void resetValues() {
    thirdGenerationModel.restartAll();
    emit(ThirdGenerationFemaleColorsState(valuesList: _getColorsList(0)));
    emit(ThirdGenerationMaleColorsState(valuesList: _getColorsList(0)));
  }

  List<Color> getFemaleButtonColors() {
    int index = 0;
    for (int i = 0; i < 8; i += 2) {
      getFemaleChildColor(i, index, 0);
      index = index + 1;
    }

    if (state is ThirdGenerationFemaleColorsState) {
      return (state as ThirdGenerationFemaleColorsState).valuesList;
    } else if (state is RestartedThirdGenerationFemaleValuesState) {
      return (state as RestartedThirdGenerationFemaleValuesState).valuesList;
    }
    return _getColorsList(0);
  }

  List<Color> getMaleButtonColors() {
    int index = 0;
    for (int i = 1; i < 8; i += 2) {
      getFemaleChildColor(i, index, 1);
      index = index + 1;
    }

    if (state is ThirdGenerationMaleColorsState) {
      return (state as ThirdGenerationMaleColorsState).valuesList;
    } else if (state is RestartedThirdGenerationMaleValuesState) {
      return (state as RestartedThirdGenerationMaleValuesState).valuesList;
    }
    return _getColorsList(1);
  }

  bool isFemaleRestartButtonEnabled(int listNumber) {
    return thirdGenerationModel.isIVListFilled(thirdGenerationModel.thirdGenerationIVList[listNumber][0]);
  }

  bool isMaleRestartButtonEnabled(int listNumber) {
    return thirdGenerationModel.isIVListFilled(thirdGenerationModel.thirdGenerationIVList[listNumber][1]);
  }

  List<bool> isFemaleButtonsEnabled(int listNumber) {
    return _getButtonsState(thirdGenerationModel.thirdGenerationIVList[listNumber][0], thirdGenerationModel.thirdGenerationIVList[listNumber][1]);
  }

  List<bool> isMaleButtonsEnabled(int listNumber) {
    return _getButtonsState(thirdGenerationModel.thirdGenerationIVList[listNumber][1], thirdGenerationModel.thirdGenerationIVList[listNumber][0]);
  }

  List<bool> _getButtonsState(List<int> primaryList, List<int> secondaryList) {
    final List<bool> buttonsList = List<bool>.filled(7, true);

    if (thirdGenerationModel.isIVListFilled(primaryList)) {
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


}
