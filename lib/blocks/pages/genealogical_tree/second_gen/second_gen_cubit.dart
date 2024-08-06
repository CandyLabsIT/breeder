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

  void setAllDefaultValues() {
    secondGenModel.restartAll();
    emit(SecondGenColorsChangedState(colorsMap: Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap)));
  }

  void setListDefaultColors(SecondGenIndex secondGenIndex) {
    secondGenModel.restartListValues(secondGenIndex);
    emit(SecondGenListColorsDefaultState(colorsMap: Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap)));
  }

  Map<SecondGenIndex, List<IVColor>> getButtonsColors() {
    if (state is SecondGenColorsChangedState) {
      return (state as SecondGenColorsChangedState).colorsMap;
    } else if (state is SecondGenListColorsDefaultState) {
      return (state as SecondGenListColorsDefaultState).colorsMap;
    }
    return Map<SecondGenIndex, List<IVColor>>.from(secondGenModel.secondGenMap);
  }

  Map<IVColor, bool> getButtonsState(SecondGenIndex secondGenIndex) {
    return _getButtonsState(secondGenIndex);
  }

  bool isRestartButtonEnabled(SecondGenIndex secondGenIndex) {
    return secondGenModel.isListFilled(secondGenIndex);
  }

  Map<IVColor, bool> _getButtonsState(SecondGenIndex secondGenIndex) {
    Map<IVColor, bool> ivColorMap = <IVColor, bool>{
      for (IVColor ivColor in IVColor.values) ivColor: true,
    };

    List<IVColor> primaryList = secondGenModel.secondGenMap[secondGenIndex]!;
    List<IVColor> secondaryList = secondGenModel.secondGenMap[secondGenModel.getIndex(secondGenIndex)]!;

    if (secondGenModel.isListFilled(secondGenIndex)) {
      int primaryListZeroCount = primaryList
          .where((IVColor element) => element == IVColor.defaultColor)
          .length;
      int secondaryListZeroCount = secondaryList
          .where((IVColor element) => element == IVColor.defaultColor)
          .length;

      if (primaryListZeroCount == 0) {
        for (IVColor key in ivColorMap.keys) {
          ivColorMap[key] = primaryList.contains(key);
        }
        return ivColorMap;
      } else if (secondaryListZeroCount == 0) {
        if (secondGenModel.hasCommonValue(secondGenIndex)) {
          for (IVColor key in ivColorMap.keys) {
            ivColorMap[key] = primaryList.contains(key) || !secondaryList.contains(key);
          }
          return ivColorMap;
        } else {
          for (IVColor key in ivColorMap.keys) {
            ivColorMap[key] = primaryList.contains(key) || secondaryList.contains(key);
          }
          return ivColorMap;
        }
      }
    }
    return ivColorMap;
  }
}
