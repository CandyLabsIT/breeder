import 'dart:core';

import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_first_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/first_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/first_gen_monster_default_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_init_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_model.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstGenCubit extends Cubit<ASecondGenState> {
  FirstGenModel firstGenModel = FirstGenModel();
  MaxIVFormCubit maxIVFormCubit = globalLocator<MaxIVFormCubit>();

  FirstGenCubit() : super(InitSecondGenState());

  void setColors(FirstGenIndex secondGenIndex, IVColor ivColor) {
    firstGenModel.updateIVColor(secondGenIndex, ivColor);
    Map<FirstGenIndex, List<IVColor>> secondGenMap = Map<FirstGenIndex, List<IVColor>>.from(firstGenModel.firstGenMap);
    emit(FirstGenColorsChangedState(firstGenMap: secondGenMap));
  }

  void resetAllToDefaultColors() {
    firstGenModel.resetAll();
    Map<FirstGenIndex, List<IVColor>> secondGenMap = Map<FirstGenIndex, List<IVColor>>.from(firstGenModel.firstGenMap);
    emit(FirstGenColorsChangedState(firstGenMap: secondGenMap));
  }

  void resetMonsterToDefaultIVColors(FirstGenIndex firstGenIndex) {
    firstGenModel.resetMonsterToDefaultIVColors(firstGenIndex);
    Map<FirstGenIndex, List<IVColor>> secondGenMap = Map<FirstGenIndex, List<IVColor>>.from(firstGenModel.firstGenMap);
    emit(SecondGenMonsterDefaultState(firstGenMap: secondGenMap));
  }

  Map<FirstGenIndex, List<IVColor>> getColors() {
    if (state is FirstGenColorsChangedState) {
      return (state as FirstGenColorsChangedState).firstGenMap;
    } else if (state is SecondGenMonsterDefaultState) {
      return (state as SecondGenMonsterDefaultState).firstGenMap;
    }
    Map<FirstGenIndex, List<IVColor>> secondGenMap = Map<FirstGenIndex, List<IVColor>>.from(firstGenModel.firstGenMap);
    return secondGenMap;
  }

  Map<FirstGenIndex, bool> getMonsterButtonState() {
    Map<FirstGenIndex, bool> monsterButtonsMap = <FirstGenIndex, bool>{};
    for (FirstGenIndex firstGenIndex in FirstGenIndex.values) {
      monsterButtonsMap[firstGenIndex] = isMonsterPairEnabled(firstGenIndex);
    }
    return monsterButtonsMap;
  }

  bool isMonsterPairEnabled(FirstGenIndex firstGenIndex) {
    bool isEnabledBool = false;

    List<int> maxIVList = maxIVFormCubit.maxIVFormModel.getAmountList();
    int maxIVSum = maxIVFormCubit.maxIVFormModel.calculateWeightedSum();
    int firstGenIndexValue = firstGenIndex.value;

    if (maxIVList[0] != 0 && maxIVSum > maxIVList[0] && firstGenIndexValue <= maxIVList[0]) {
      if (firstGenIndexValue <= 2) {
        isEnabledBool = true;
        return isEnabledBool;
      }
      if (firstGenIndexValue > maxIVList[0]) {
        return isEnabledBool;
      } else {
        isEnabledBool = firstGenModel.isPreviousPairFilled(firstGenIndex);
      }
    } else if (maxIVList[0] == 0 || maxIVSum == maxIVList[0] || firstGenIndexValue <= maxIVList[0]) {
      if (firstGenIndexValue <= 2) {
        isEnabledBool = true;
        return isEnabledBool;
      }
      isEnabledBool = firstGenModel.isPreviousPairFilled(firstGenIndex);
      return isEnabledBool;
    }
    return isEnabledBool;
  }

  bool isRestartButtonEnabled(FirstGenIndex secondGenIndex) {
    bool restartButtonEnabledBool = firstGenModel.hasIVValue(secondGenIndex);
    return restartButtonEnabledBool;
  }

  Map<IVColor, bool> getIVButtonsState(FirstGenIndex secondGenIndex) {
    FirstGenIndex femaleIndex = firstGenModel.getFemaleIndex(secondGenIndex);
    FirstGenIndex maleIndex = firstGenModel.getMaleIndex(secondGenIndex);

    List<IVColor> femaleIVList = firstGenModel.firstGenMap[femaleIndex]!;
    List<IVColor> maleIVList = firstGenModel.firstGenMap[maleIndex]!;

    if (secondGenIndex == femaleIndex) {
      return _setIVButtonsState(femaleIVList, maleIVList, femaleIndex, maleIndex);
    } else {
      return _setIVButtonsState(maleIVList, femaleIVList, maleIndex, femaleIndex);
    }
  }

  Map<IVColor, bool> _setIVButtonsState(List<IVColor> activeMonsterIVList, List<IVColor> pairedMonsterIVList, FirstGenIndex activeGenIndex,
      FirstGenIndex pairedGenIndex) {
    Map<IVColor, bool> ivButtonsMap = <IVColor, bool>{
      for (IVColor ivColor in IVColor.values)
        if (ivColor != IVColor.defaultColor) ivColor: true
    };

    FirstGenIndex maleIndex = firstGenModel.getMaleIndex(activeGenIndex);

    if (firstGenModel.hasIVValue(activeGenIndex)) {
      for (IVColor key in ivButtonsMap.keys) {
        ivButtonsMap[key] = activeMonsterIVList.contains(key);
      }
      return ivButtonsMap;
    }


    if (activeGenIndex.value <= 2) {
      // check if active monster has IVValue

      // if the active monster has only one defaultColor and the paired list has zero defaultColor, check if they have any common IVColor
      if (firstGenModel.hasIVValue(pairedGenIndex)) {
        for (IVColor key in ivButtonsMap.keys) {
          // if they have a common IVColor, return map with one false for non-repeating value from the paired monster list
          ivButtonsMap[key] = !pairedMonsterIVList.contains(key);
        }
      }
    }
    else if (firstGenModel.isQuotientIndexValueEven(maleIndex)) {
      if (firstGenModel.hasIVValue(pairedGenIndex)) {
        if(){}

        } else {

        }

        return ivButtonsMap;
        }
