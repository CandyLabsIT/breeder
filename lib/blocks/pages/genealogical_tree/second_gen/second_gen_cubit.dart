import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_colors_default_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_init_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen_index.dart';
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
      return _getButtonsState(femaleIVList, maleIVList, secondGenIndex);
    } else {
      return _getButtonsState(maleIVList, femaleIVList, secondGenIndex);
    }
  }

  Map<IVColor, bool> _getButtonsState(List<IVColor> activeIVList, List<IVColor> pairedIVList, SecondGenIndex secondGenIndex) {

    Map<IVColor, bool> ivButtonsMap = <IVColor, bool>{
      for (IVColor ivColor in IVColor.values) ivColor: true,
    };

    if (secondGenModel.isIVListFilled(secondGenIndex)) {
      int activeMonsterDefaultCount = activeIVList.where((IVColor element) => element == IVColor.defaultColor).length;
      int pairedMonsterDefaultCount = pairedIVList.where((IVColor element) => element == IVColor.defaultColor).length;

      if (activeMonsterDefaultCount == 0) {
        for (IVColor key in ivButtonsMap.keys) {
          ivButtonsMap[key] = activeIVList.contains(key);
        }
        return ivButtonsMap;
      } else if (pairedMonsterDefaultCount == 0) {
        if (secondGenModel.hasCommonValue(secondGenIndex)) {
          for (IVColor key in ivButtonsMap.keys) {
            ivButtonsMap[key] = activeIVList.contains(key) || !pairedIVList.contains(key);
          }
          return ivButtonsMap;
        } else {
          for (IVColor key in ivButtonsMap.keys) {
            ivButtonsMap[key] = activeIVList.contains(key) || pairedIVList.contains(key);
          }
          return ivButtonsMap;
        }
      }
    }
    return ivButtonsMap;
  }
}
