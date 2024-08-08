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
    emit(SecondGenColorsChangedState(colorsMap: Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap)));
  }

  void setAllDefaultColors() {
    secondGenModel.resetAll();
    emit(SecondGenColorsChangedState(colorsMap: Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap)));
  }

  void setListDefaultColors(SecondGenIndex secondGenIndex) {
    secondGenModel.restartListValues(secondGenIndex);
    emit(SecondGenListColorsDefaultState(colorsMap: Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap)));
  }

  Map<SecondGenIndex, List<IVColor>> getColors() {
    if (state is SecondGenColorsChangedState) {
      return (state as SecondGenColorsChangedState).colorsMap;
    } else if (state is SecondGenListColorsDefaultState) {
      return (state as SecondGenListColorsDefaultState).colorsMap;
    }
    return Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap);
  }

  bool isRestartButtonEnabled(SecondGenIndex secondGenIndex) {
    return secondGenModel.isListFilled(secondGenIndex);
  }

  Map<IVColor, bool> getButtonsState(SecondGenIndex secondGenIndex) {
    Map<IVColor, bool> ivButtonsMap = <IVColor, bool>{
      for (IVColor ivColor in IVColor.values) ivColor: true,
    };

    List<IVColor> activeMonsterIVList = secondGenModel.secondGenMap[secondGenIndex]!;
    List<IVColor> pairedMonsterIVList = secondGenModel.secondGenMap[secondGenModel.getIndex(secondGenIndex)]!;

    if (secondGenModel.isListFilled(secondGenIndex)) {
      int activeMonsterDefaultCount = activeMonsterIVList.where((IVColor element) => element == IVColor.defaultColor).length;
      int pairedMonsterDefaultCount = pairedMonsterIVList.where((IVColor element) => element == IVColor.defaultColor).length;

      if (activeMonsterDefaultCount == 0) {
        for (IVColor key in ivButtonsMap.keys) {
          ivButtonsMap[key] = activeMonsterIVList.contains(key);
        }
        return ivButtonsMap;
      } else if (pairedMonsterDefaultCount == 0) {
        if (secondGenModel.hasCommonValue(secondGenIndex)) {
          for (IVColor key in ivButtonsMap.keys) {
            ivButtonsMap[key] = activeMonsterIVList.contains(key) || !pairedMonsterIVList.contains(key);
          }
          return ivButtonsMap;
        } else {
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
