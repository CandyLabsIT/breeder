import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_colors_default_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_init_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenCubit extends Cubit<ASecondGenState> {
  SecondGenModel secondGenModel = SecondGenModel();

  SecondGenCubit() : super(InitSecondGenState());

  void setColors(SecondGenIndex secondGenIndex, IVColor ivColor) {
    secondGenModel.updateMapValues(secondGenIndex, ivColor);
    emit(SecondGenColorsChangedState(secondGenMap: Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap)));
  }

  void resetAllToDefaultColors() {
    secondGenModel.resetAll();
    emit(SecondGenColorsChangedState(secondGenMap: Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap)));
  }

  void resetIVListToDefaultColors(SecondGenIndex secondGenIndex) {
    secondGenModel.resetIVListValues(secondGenIndex);
    emit(SecondGenIVListDefaultState(secondGenMap: Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap)));
  }

  Map<SecondGenIndex, List<IVColor>> getColors() {
    if (state is SecondGenColorsChangedState) {
      return (state as SecondGenColorsChangedState).secondGenMap;
    } else if (state is SecondGenIVListDefaultState) {
      return (state as SecondGenIVListDefaultState).secondGenMap;
    }
    return Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap);
  }

  bool isRestartButtonEnabled(SecondGenIndex secondGenIndex) {
    return secondGenModel.isIVListFilled(secondGenIndex);
  }

  Map<IVColor, bool> getButtonsState(SecondGenIndex secondGenIndex) {
    SecondGenIndex femaleIndex = secondGenModel.getFemaleIndex(secondGenIndex);
    SecondGenIndex maleIndex = secondGenModel.getMaleIndex(secondGenIndex);

    List<IVColor> femaleIVList = secondGenModel.secondGenMap[femaleIndex]!;
    List<IVColor> maleIVList = secondGenModel.secondGenMap[maleIndex]!;

    if (secondGenIndex == femaleIndex) {
      return _setButtonsState(femaleIVList, maleIVList, secondGenIndex);
    } else {
      return _setButtonsState(maleIVList, femaleIVList, secondGenIndex);
    }
  }

  Map<IVColor, bool> _setButtonsState(List<IVColor> activeMonsterIVList, List<IVColor> pairedMonsterIVList, SecondGenIndex secondGenIndex) {

    Map<IVColor, bool> ivButtonsMap = <IVColor, bool>{
      for (IVColor ivColor in IVColor.values) ivColor: true,
    };
  
    // check if active monster has at least one non-defaultColor
    if (secondGenModel.isIVListFilled(secondGenIndex)) {
      // Count how many defaultColor are in active and paired monsters lists
      int activeMonsterDefaultCount = activeMonsterIVList.where((IVColor element) => element == IVColor.defaultColor).length;
      int pairedMonsterDefaultCount = pairedMonsterIVList.where((IVColor element) => element == IVColor.defaultColor).length;
      
      // if active monster has zero defaultColor, return map with true for IVColor that are in the active monster's list.
      if (activeMonsterDefaultCount == 0) {
        for (IVColor key in ivButtonsMap.keys) {
          ivButtonsMap[key] = activeMonsterIVList.contains(key);
        }
        return ivButtonsMap;
        // if the active monster has only one defaultColor and the paired list has zero defaultColor, check if they have any common IVColor
      } else if (pairedMonsterDefaultCount == 0) {
        if (secondGenModel.hasCommonValue(secondGenIndex)) {
          for (IVColor key in ivButtonsMap.keys) {
            // If they have a common IVColor, return map with one false for non-repeating value from the paired monster list
            ivButtonsMap[key] = activeMonsterIVList.contains(key) || !pairedMonsterIVList.contains(key);
          }
          return ivButtonsMap;
        } else {
          // If the two lists do not share common value, return map with three true values for IVColors contained in active monster list and the paired monster list
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
