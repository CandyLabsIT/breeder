import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_female_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_female_colors_default_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_init_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_male_colors_changed_state.dart.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_male_colors_default_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenCubit extends Cubit<ASecondGenState> {
  SecondGenModel secondGenModel = SecondGenModel();

  SecondGenCubit() : super(InitSecondGenState());

  void setFemaleColors(SecondGenIndex index, IVColor ivColor) {
    secondGenModel.updateMapValues(index, ivColor);
    emit(SecondGenFemaleColorsChangedState(colorsMap: getFemaleColors()));
  }

  void setMaleColors(SecondGenIndex index, IVColor ivColor) {
    secondGenModel.updateMapValues(index, ivColor);
    emit(SecondGenMaleColorsChangedState(colorsMap: getMaleColors()));
  }

  void setAllDefaultValues() {
    secondGenModel.restartAll();
    emit(SecondGenFemaleColorsChangedState(colorsMap: secondGenModel.colorMap));
  }

  void setFemaleListDefaultColors(SecondGenIndex index) {
    secondGenModel.restartMapValues(index);
    emit(SecondGenFemaleListColorsDefaultState(colorsMap: getFemaleColors()));
  }

  void setMaleListDefaultColors(SecondGenIndex index) {
    secondGenModel.restartMapValues(index);
    emit(SecondGenMaleColorsDefaultState(colorsMap: getFemaleColors()));
  }

  Map<SecondGenIndex, List<IVColor>> getFemaleButtonsColors() {
    if (state is SecondGenFemaleColorsChangedState) {
      return (state as SecondGenFemaleColorsChangedState).colorsMap;
    } else if (state is SecondGenFemaleListColorsDefaultState) {
      return (state as SecondGenFemaleListColorsDefaultState).colorsMap;
    }
    return getFemaleColors();
  }

  Map<SecondGenIndex, List<IVColor>> getMaleButtonsColors() {
    if (state is SecondGenMaleColorsChangedState) {
      return (state as SecondGenMaleColorsChangedState).colorsMap;
    } else if (state is SecondGenMaleColorsDefaultState) {
      return (state as SecondGenMaleColorsDefaultState).colorsMap;
    }
    return getMaleColors();
  }

  Map<IVColor, bool> getButtonsState(SecondGenIndex index) {
    return _getButtonsState(index);
  }

  bool isRestartButtonEnabled(SecondGenIndex pairValue) {
    return secondGenModel.isListFilled(pairValue);
  }

  Map<IVColor, bool> _getButtonsState(SecondGenIndex index) {
    Map<IVColor, bool> ivColorMap = <IVColor, bool>{
      for (IVColor ivColor in IVColor.values) ivColor: true,
    };

    List<IVColor> primaryList = secondGenModel.colorMap[index]!;
    List<IVColor> secondaryList = secondGenModel.colorMap[secondGenModel.getIndex(index)]!;

    if (secondGenModel.isListFilled(index)) {
      int primaryListZeroCount = primaryList.where((IVColor element) => element == IVColor.defaultColor).length;
      int secondaryListZeroCount = secondaryList.where((IVColor element) => element == IVColor.defaultColor).length;

      if (primaryListZeroCount == 0) {
        for (IVColor key in ivColorMap.keys) {
          ivColorMap[key] = primaryList.contains(key);
        }
        return ivColorMap;
      } else if (secondaryListZeroCount == 0) {
        if (secondGenModel.hasCommonValue(index)) {
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

  Map<SecondGenIndex, List<IVColor>> getFemaleColors() {
    return _getColors(SecondGenIndex.zero);
  }

  Map<SecondGenIndex, List<IVColor>> getMaleColors() {
    return _getColors(SecondGenIndex.one);
  }

  Map<SecondGenIndex, List<IVColor>> _getColors(SecondGenIndex index) {
    Map<SecondGenIndex, List<IVColor>> map = <SecondGenIndex, List<IVColor>>{};
    SecondGenIndex max = SecondGenIndex.fifteen;

    if (secondGenModel.isFemale(index)) {
      max = SecondGenIndex.fourteen;
    }

    for (int i = index.value; i <= max.value; i += 2) {
      SecondGenIndex key = SecondGenIndex.values.firstWhere(
              (SecondGenIndex element) => element.value == i
      );
      map[key] = List<IVColor>.from(secondGenModel.colorMap[key]!);
    }
    return map;
  }
}
