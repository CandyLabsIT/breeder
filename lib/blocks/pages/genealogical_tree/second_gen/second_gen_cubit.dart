import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_female_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_female_colors_default_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_init_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_male_colors_changed_state.dart.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_male_colors_default_state.dart';
import 'package:breeder/shared/models/genealogical_tree/gender_values.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_values.dart';
import 'package:breeder/shared/models/genealogical_tree/pairs_value.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenCubit extends Cubit<ASecondGenState> {
  SecondGenModel secondGenModel = SecondGenModel();

  SecondGenCubit() : super(InitSecondGenState());

  void setFemaleColors(PairsValues pairValue, IVValues femaleIVValue) {
    secondGenModel.updateListValues(pairValue.value, GenderValues.female.value, femaleIVValue.value);
    emit(SecondGenFemaleColorsChangedState(colorsList: _getColorsList(GenderValues.female.value)));
  }

  void setMaleColors(PairsValues pairValue, IVValues maleIVValue) {
    secondGenModel.updateListValues(pairValue.value, GenderValues.male.value, maleIVValue.value);
    emit(SecondGenMaleColorsChangedState(colorsList: _getColorsList(GenderValues.male.value)));
  }

  void setDefaultValues() {
    secondGenModel.restartAll();
    emit(SecondGenFemaleColorsChangedState(colorsList: _getColorsList(GenderValues.female.value)));
    emit(SecondGenMaleColorsChangedState(colorsList: _getColorsList(GenderValues.male.value)));
  }

  void setFemaleDefaultColors(PairsValues pairValue) {
    if (secondGenModel.isSumPositive(pairValue.value, GenderValues.female.value)) {
      secondGenModel.restartListValues(pairValue.value, GenderValues.female.value);
    }
    emit(SecondGenFemaleColorsDefaultState(colorsList: _getColorsList(GenderValues.female.value)));
  }

  void setMaleDefaultColors(PairsValues pairValue) {
    if (secondGenModel.isSumPositive(pairValue.value, GenderValues.male.value)) {
      secondGenModel.restartListValues(pairValue.value, GenderValues.male.value);
    }
    emit(SecondGenMaleColorsDefaultState(colorsList: _getColorsList(GenderValues.male.value)));
  }

  List<Color> getFemaleButtonColors() {
    if (state is SecondGenFemaleColorsChangedState) {
      return (state as SecondGenFemaleColorsChangedState).colorsList;
    } else if (state is SecondGenFemaleColorsDefaultState) {
      return (state as SecondGenFemaleColorsDefaultState).colorsList;
    }
    return _getColorsList(GenderValues.female.value);
  }

  List<Color> getMaleButtonColors() {
    if (state is SecondGenMaleColorsChangedState) {
      return (state as SecondGenMaleColorsChangedState).colorsList;
    } else if (state is SecondGenMaleColorsDefaultState) {
      return (state as SecondGenMaleColorsDefaultState).colorsList;
    }
    return _getColorsList(GenderValues.male.value);
  }

  List<bool> getFemaleButtonsState(PairsValues pairValue) {
    return _getButtonsState(pairValue, GenderValues.female.value, GenderValues.male.value);
  }

  List<bool> getMaleButtonsState(PairsValues pairValue) {
    return _getButtonsState(pairValue, GenderValues.male.value, GenderValues.female.value);
  }

  bool isFemaleRestartButtonEnabled(PairsValues pairValue) {
    return secondGenModel.isSumPositive(pairValue.value, GenderValues.female.value);
  }

  bool isMaleRestartButtonEnabled(PairsValues pairValue) {
    return secondGenModel.isSumPositive(pairValue.value, GenderValues.male.value);
  }

  List<bool> _getButtonsState(PairsValues pairValue, int primaryGenderValue, int secondaryGenderValue) {
    final List<bool> buttonsList = List<bool>.filled(7, true);

    List<int> primaryList = secondGenModel.secondGenIVList[pairValue.value][primaryGenderValue];
    List<int> secondaryList = secondGenModel.secondGenIVList[pairValue.value][secondaryGenderValue];

    if (secondGenModel.isSumPositive(pairValue.value, primaryGenderValue)) {
      int primaryListZeroCount = primaryList.where((int element) => element == 0).length;
      int secondaryListZeroCount = secondaryList.where((int element) => element == 0).length;

      if (primaryListZeroCount == 0) {
        for (int i = 1; i < 7; i++) {
          buttonsList[i] = primaryList.contains(i);
        }
        return buttonsList;
      } else if (secondaryListZeroCount == 0) {
        if (secondGenModel.hasCommonValue(pairValue.value)) {
          for (int i = 1; i < 7; i++) {
            buttonsList[i] = primaryList.contains(i) || !secondaryList.contains(i) ;
          }
        } else {
          for (int i = 1; i < 7; i++) {
            buttonsList[i] = primaryList.contains(i) || secondaryList.contains(i);
          }
        }
        return buttonsList;
      }
    }
    return buttonsList;
  }

  List<Color> _getColorsList(int genderValue) {
    return List<List<Color>>.generate(7, (int pairValue) => List<Color>.generate(2, (int ivIndex) => _getColor(pairValue, genderValue, ivIndex)))
        .expand((List<Color> list) => list)
        .toList();
  }

  Color _getColor(int pairValue, int genderValue, int ivIndex) {
    return IVColorExtension.fromInt(secondGenModel.secondGenIVList[pairValue][genderValue][ivIndex]).color;
  }
}
