import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_female_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_female_colors_default_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_init_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenCubit extends Cubit<ASecondGenState> {
  SecondGenModel secondGenModel = SecondGenModel();

  SecondGenCubit() : super(InitSecondGenState());

  void setColors(SecondGenIndex index, IVColor ivColor) {
    secondGenModel.updateMapValues(index, ivColor);
    emit(SecondGenFemaleColorsChangedState(colorsMap: secondGenModel.getColorsMap()));
  }

  void setAllDefaultValues() {
    secondGenModel.restartAll();
    emit(SecondGenFemaleColorsChangedState(colorsMap: secondGenModel.colorMap));
  }

  void setListDefaultColors(SecondGenIndex index) {
    secondGenModel.restartMapValues(index);
    emit(SecondGenFemaleListColorsDefaultState(colorsMap: secondGenModel.getColorsMap()));
  }

  Map<SecondGenIndex, List<IVColor>> getButtonsColors() {
    if (state is SecondGenFemaleColorsChangedState) {
      return (state as SecondGenFemaleColorsChangedState).colorsMap;
    } else if (state is SecondGenFemaleListColorsDefaultState) {
      return (state as SecondGenFemaleListColorsDefaultState).colorsMap;
    }
    return secondGenModel.getColorsMap();
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
}
