import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_init_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_monster_default_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenCubit extends Cubit<ASecondGenState> {
  SecondGenModel secondGenModel = SecondGenModel();

  SecondGenCubit() : super(InitSecondGenState());

  void setColors(SecondGenIndex secondGenIndex, IVColor ivColor) {
    secondGenModel.updateIVColor(secondGenIndex, ivColor);
    Map<SecondGenIndex, List<IVColor>> secondGenMap = Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap);
    emit(SecondGenColorsChangedState(secondGenMap: secondGenMap));
  }

  void resetAllToDefaultColors() {
    secondGenModel.resetAll();
    Map<SecondGenIndex, List<IVColor>> secondGenMap = Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap);
    emit(SecondGenColorsChangedState(secondGenMap: secondGenMap));
  }

  void resetMonsterToDefaultIVColors(SecondGenIndex secondGenIndex) {
    secondGenModel.resetMonsterToDefaultIVColors(secondGenIndex);
    Map<SecondGenIndex, List<IVColor>> secondGenMap = Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap);
    emit(SecondGenMonsterDefaultState(secondGenMap: secondGenMap));
  }

  Map<SecondGenIndex, List<IVColor>> getColors() {
    if (state is SecondGenColorsChangedState) {
      return (state as SecondGenColorsChangedState).secondGenMap;
    } else if (state is SecondGenMonsterDefaultState) {
      return (state as SecondGenMonsterDefaultState).secondGenMap;
    }
    Map<SecondGenIndex, List<IVColor>> secondGenMap = Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap);
    return secondGenMap;
  }

  bool isRestartButtonEnabled(SecondGenIndex secondGenIndex) {
    bool restartButtonEnabledBool = secondGenModel.hasIVValue(secondGenIndex);
    return restartButtonEnabledBool;
  }

  Map<IVColor, bool> getIVButtonsState(SecondGenIndex secondGenIndex) {
    SecondGenIndex femaleIndex = secondGenModel.getFemaleIndex(secondGenIndex);
    SecondGenIndex maleIndex = secondGenModel.getMaleIndex(secondGenIndex);

    List<IVColor> femaleIVList = secondGenModel.secondGenMap[femaleIndex]!;
    List<IVColor> maleIVList = secondGenModel.secondGenMap[maleIndex]!;

    if (secondGenIndex == femaleIndex) {
      return _setIVButtonsState(femaleIVList, maleIVList, secondGenIndex);
    } else {
      return _setIVButtonsState(maleIVList, femaleIVList, secondGenIndex);
    }
  }

  Map<IVColor, bool> _setIVButtonsState(List<IVColor> activeMonsterIVList, List<IVColor> pairedMonsterIVList, SecondGenIndex secondGenIndex) {
    Map<IVColor, bool> ivButtonsMap = <IVColor, bool>{
      for (IVColor ivColor in IVColor.values)
        if (ivColor != IVColor.defaultColor) ivColor: true
    };

    // check if active monster has at least one IVValue
    if (secondGenModel.hasIVValue(secondGenIndex)) {
      // count how many defaultColor are in active and paired monsters lists
      int activeMonsterDefaultIVCount = activeMonsterIVList.where((IVColor element) => element == IVColor.defaultColor).length;
      int pairedMonsterIVDefaultIVCount = pairedMonsterIVList.where((IVColor element) => element == IVColor.defaultColor).length;

      // if active monster has zero defaultColor, return map with true for IVColor that are in the active monster's list.
      if (activeMonsterDefaultIVCount == 0) {
        for (IVColor key in ivButtonsMap.keys) {
          ivButtonsMap[key] = activeMonsterIVList.contains(key);
        }
        return ivButtonsMap;
        // if the active monster has only one defaultColor and the paired list has zero defaultColor, check if they have any common IVColor
      } else if (pairedMonsterIVDefaultIVCount == 0) {
        if (secondGenModel.hasCommonIVColor(secondGenIndex)) {
          for (IVColor key in ivButtonsMap.keys) {
            // if they have a common IVColor, return map with one false for non-repeating value from the paired monster list
            ivButtonsMap[key] = activeMonsterIVList.contains(key) || !pairedMonsterIVList.contains(key);
          }
          return ivButtonsMap;
        } else {
          // if the two lists do not share common value, return map with three true values for IVColors contained in active monster list and the paired monster list
          for (IVColor key in ivButtonsMap.keys) {
            ivButtonsMap[key] = activeMonsterIVList.contains(key) || pairedMonsterIVList.contains(key);
          }
          return ivButtonsMap;
        }
      }
    }
    return ivButtonsMap;
  }
}
