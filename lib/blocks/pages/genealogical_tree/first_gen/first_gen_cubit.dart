import 'dart:core';

import 'package:breeder/blocks/pages/genealogical_tree/first_gen/a_first_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_init_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_iv_buttons_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_monster_default_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_model.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_buttons/iv_buttons_model.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstGenCubit extends Cubit<AFirstGenState> {
  final MaxIVFormCubit _maxIVFormCubit = globalLocator<MaxIVFormCubit>();
  final IVButtonsModel _ivButtonsModel = IVButtonsModel();
  FirstGenModel firstGenModel = FirstGenModel();

  FirstGenCubit() : super(FirstGenInitState());

  void setIVColors(FirstGenIndex firstGenIndex, IVColor ivColor) {
    firstGenModel.updateIVColor(firstGenIndex, ivColor);
    emit(FirstGenColorsChangedState(firstGenMap: _getIVColorMap()));
  }

  void resetAllToDefaultColors() {
    firstGenModel.resetAll();
    emit(FirstGenColorsChangedState(firstGenMap: _getIVColorMap()));
  }

  void resetMonsterToDefaultIVColors(FirstGenIndex firstGenIndex) {
    firstGenModel.resetMonsterToDefaultIVColors(firstGenIndex);
    emit(FirstGenMonsterDefaultState(firstGenMap: _getIVColorMap()));
  }

  void setIVStateIndexOne() {
    Map<IVColor, bool> ivButtonsMap = _initializeIVButtonsMap();
    if (firstGenModel.hasNonDefaultIVColor(FirstGenIndex.one)) {
      ivButtonsMap = _getSingledUnblockedIVButtonMap(FirstGenIndex.one);
    }
    emit(FirstGenIVButtonsState(ivButtonMap: ivButtonsMap));
  }

  void setIVStateIndexTwo() {
    Map<IVColor, bool> ivButtonsMap = _getSingleBlockedIVButtonMap(FirstGenIndex.one);
    List<IVColor> currentIVColorList = firstGenModel.firstGenMap[FirstGenIndex.two]!.ivColorList;
    if (firstGenModel.hasNonDefaultIVColor(FirstGenIndex.two)) {
      for (IVColor key in ivButtonsMap.keys) {
        ivButtonsMap[key] = currentIVColorList.contains(key);
      }
    }
    emit(FirstGenIVButtonsState(ivButtonMap: ivButtonsMap));
  }

  void setIVStateIndexThree() {
    Map<IVColor, bool> ivButtonsMap = _initializeIVButtonsMap();
    if (firstGenModel.hasNonDefaultIVColor(FirstGenIndex.three)) {
      ivButtonsMap = _getSingledUnblockedIVButtonMap(FirstGenIndex.three);
    }
    emit(FirstGenIVButtonsState(ivButtonMap: ivButtonsMap));
  }

  void setIVStateIndexFour() {
    Map<IVColor, bool> ivButtonsMap = _initializeIVButtonsMap();

    if (firstGenModel.hasNonDefaultIVColor(FirstGenIndex.four)) {
      ivButtonsMap = _getSingledUnblockedIVButtonMap(FirstGenIndex.four);
    } else {
      Map<FirstGenIndex, List<IVColor>> ivColorMap = _getIVColorMap();

      bool previousIVColorBool = _hasPreviousIVColor(FirstGenIndex.three);

      if (previousIVColorBool) {
        for (IVColor key in ivButtonsMap.keys) {
          ivButtonsMap[key] = !ivColorMap.values.any((List<IVColor> ivColorList) => ivColorList.contains(key));
        }
      } else {
        for (IVColor key in ivButtonsMap.keys) {
          ivButtonsMap[key] = ivColorMap.entries
              .where((MapEntry<FirstGenIndex, List<IVColor>> entry) => entry.key.value < FirstGenIndex.three.value)
              .any((MapEntry<FirstGenIndex, List<IVColor>> entry) => entry.value.contains(key));
        }
      }
    }
    emit(FirstGenIVButtonsState(ivButtonMap: ivButtonsMap));
  }

  Map<IVColor, bool> getIVButtonsState() {
    if (state is FirstGenIVButtonsState) {
      return (state as FirstGenIVButtonsState).ivButtonMap;
    } else {
      return _initializeIVButtonsMap();
    }
  }

  Map<FirstGenIndex, List<IVColor>> getIVColors() {
    if (state is FirstGenColorsChangedState) {
      return (state as FirstGenColorsChangedState).firstGenMap;
    } else if (state is FirstGenMonsterDefaultState) {
      return (state as FirstGenMonsterDefaultState).firstGenMap;
    }
    return _getIVColorMap();
  }

  Map<FirstGenIndex, bool> getMonstersEnabledState() {
    Map<FirstGenIndex, bool> monsterButtonsMap = <FirstGenIndex, bool>{};
    for (FirstGenIndex firstGenIndex in FirstGenIndex.values) {
      monsterButtonsMap[firstGenIndex] = _isMonsterEnabled(firstGenIndex);
    }
    return monsterButtonsMap;
  }

  bool isRestartButtonEnabled(FirstGenIndex secondGenIndex) {
    bool restartButtonEnabledBool = firstGenModel.hasNonDefaultIVColor(secondGenIndex);
    return restartButtonEnabledBool;
  }

  int getMonstersNumber() {
    int monsterAmount = _maxIVFormCubit.maxIVFormModel.getAmountList()[0];
    if (monsterAmount == 0) {
      monsterAmount = FirstGenIndex.values.length;
    }
    return monsterAmount;
  }

  // TODO(balladyna): 'if' condition is temporary solution until the IVColors button management feature is implemented.
  bool _isMonsterEnabled(FirstGenIndex firstGenIndex) {
    if (firstGenIndex.value == 1) {
      return true;
    } else if (firstGenIndex.value > 4) {
      return false;
    }

    FirstGenIndex previousIndex = firstGenModel.getActivePairFemaleIndex(firstGenIndex) == firstGenIndex
        ? firstGenModel.getPreviousPairMaleIndex(firstGenIndex)
        : firstGenModel.getActivePairFemaleIndex(firstGenIndex);

    return firstGenModel.hasNonDefaultIVColor(previousIndex);
  }

  bool _hasPreviousIVColor(FirstGenIndex firstGenIndex) {
    Map<FirstGenIndex, List<IVColor>> ivColorMap = _getIVColorMap();
    List<IVColor> femaleIVColorList = ivColorMap[firstGenIndex]!;
    bool hasIVColorBool = ivColorMap.entries
        .where((MapEntry<FirstGenIndex, List<IVColor>> entry) => entry.key.value < firstGenIndex.value)
        .any((MapEntry<FirstGenIndex, List<IVColor>> entry) => entry.value.contains(femaleIVColorList[0]));
    return hasIVColorBool;
  }

  Map<FirstGenIndex, List<IVColor>> _getIVColorMap() {
    Map<FirstGenIndex, List<IVColor>> ivColorMap = firstGenModel.firstGenMap.map(
        (FirstGenIndex firstGenIndex, MonsterModel monsterModel) => MapEntry<FirstGenIndex, List<IVColor>>(firstGenIndex, monsterModel.ivColorList));
    return ivColorMap;
  }

  Map<IVColor, bool> _getSingleBlockedIVButtonMap(FirstGenIndex firstGenIndex) {
    Map<IVColor, bool> ivButtonsMap = Map<IVColor, bool>.from(_ivButtonsModel.ivButtonsMap);
    List<IVColor> previousMonsterIVList = firstGenModel.firstGenMap[firstGenIndex]!.ivColorList;
    for (IVColor key in ivButtonsMap.keys) {
      ivButtonsMap[key] = !previousMonsterIVList.contains(key);
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> _getSingledUnblockedIVButtonMap(FirstGenIndex firstGenIndex) {
    Map<IVColor, bool> ivButtonsMap = Map<IVColor, bool>.from(_ivButtonsModel.ivButtonsMap);
    List<IVColor> currentIVColorList = firstGenModel.firstGenMap[firstGenIndex]!.ivColorList;
    for (IVColor key in ivButtonsMap.keys) {
      ivButtonsMap[key] = currentIVColorList.contains(key);
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> _initializeIVButtonsMap() {
    Map<IVColor, bool> ivButtonMap = Map<IVColor, bool>.from(_ivButtonsModel.ivButtonsMap);
    return ivButtonMap;
  }
}
