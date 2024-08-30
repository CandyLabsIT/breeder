import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/blocks/pages/genealogical_tree/third_generation/a_third_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/third_generation/state/init_third_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/third_generation/state/third_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/third_generation/state/third_gen_iv_list_default_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_generation_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdGenCubit extends Cubit<AThirdGenState> {
  SecondGenCubit secondGenCubit = globalLocator<SecondGenCubit>();
  ThirdGenModel thirdGenModel = ThirdGenModel();

  ThirdGenCubit() : super(InitThirdGenState());

  void setColors(ThirdGenIndex thirdGenIndex, IVColor ivColor) {
    thirdGenModel.updateMapValues(thirdGenIndex, ivColor);
    emit(ThirdGenColorsChangedState(thirdGenMap: Map<ThirdGenIndex, List<IVColor>>.from(thirdGenModel.thirdGenMap)));
  }

  void resetAllToDefaultColors() {
    thirdGenModel.restartAll();
    emit(ThirdGenColorsChangedState(thirdGenMap: Map<ThirdGenIndex, List<IVColor>>.from(thirdGenModel.thirdGenMap)));
  }

  void resetIVListToDefaultColors(ThirdGenIndex thirdGenIndex) {
    thirdGenModel.resetIVListValues(thirdGenIndex);
    emit(ThirdGenIVListDefaultState(thirdGenMap: Map<ThirdGenIndex, List<IVColor>>.from(thirdGenModel.thirdGenMap)));
  }

  Map<ThirdGenIndex, List<IVColor>> getColors() {
    Map<ThirdGenIndex, List<IVColor>> childrenMap = secondGenCubit.secondGenModel.childrenMap;
    for (ThirdGenIndex thirdGenIndex in ThirdGenIndex.values) {
      List<IVColor> parentsList = childrenMap[thirdGenIndex]!;
      if (isParentsListFilled(parentsList)) {
        thirdGenModel.updateListValues(thirdGenIndex, parentsList);
      }
    }

    if (state is ThirdGenColorsChangedState) {
      return (state as ThirdGenColorsChangedState).thirdGenMap;
    } else if (state is ThirdGenIVListDefaultState) {
      return (state as ThirdGenIVListDefaultState).thirdGenMap;
    }
    return Map<ThirdGenIndex, List<IVColor>>.from(thirdGenModel.thirdGenMap);
  }


  bool isParentsListFilled(List<IVColor> parentsList) {
    return !parentsList.contains(IVColor.defaultColor);
  }

  bool isRestartButtonEnabled(ThirdGenIndex thirdGenIndex) {
    return thirdGenModel.isIVListFilled(thirdGenIndex);
  }

  Map<IVColor, bool> getButtonState(ThirdGenIndex thirdGenIndex) {
    ThirdGenIndex femaleIndex = thirdGenModel.getFemaleIndex(thirdGenIndex);
    ThirdGenIndex maleIndex = thirdGenModel.getMaleIndex(thirdGenIndex);

    List<IVColor> femaleIVList = thirdGenModel.thirdGenMap[femaleIndex]!;
    List<IVColor> maleIVList = thirdGenModel.thirdGenMap[maleIndex]!;

    if (thirdGenIndex == femaleIndex) {
      return _setButtonsState(femaleIVList, maleIVList, thirdGenIndex);
    } else {
      return _setButtonsState(maleIVList, femaleIVList, thirdGenIndex);
    }
  }

  Map<IVColor, bool> _setButtonsState(List<IVColor> activeMonsterIVList, List<IVColor> pairedMonsterIVList, ThirdGenIndex thirdGenIndex) {
    Map<IVColor, bool> ivButtonsMap = <IVColor, bool>{
      for (IVColor ivColor in IVColor.values) ivColor: true,
    };

    if (thirdGenModel.isIVListFilled(thirdGenIndex)) {
      int activeMonsterDefaultCount = activeMonsterIVList.where((IVColor ivColor) => ivColor == IVColor.defaultColor).length;
      int pairedMonsterDefaultCount = pairedMonsterIVList.where((IVColor ivColor) => ivColor == IVColor.defaultColor).length;
      int commonValues = thirdGenModel.countCommonValues(thirdGenIndex);

      if (activeMonsterDefaultCount == 0 && pairedMonsterDefaultCount == 3 || activeMonsterDefaultCount == 0) {
        for (IVColor key in ivButtonsMap.keys) {
          ivButtonsMap[key] = activeMonsterIVList.contains(key);
        }
        return ivButtonsMap;
      } else if (pairedMonsterDefaultCount <= 1) {
        if ((activeMonsterDefaultCount == 2 && commonValues == 0) || (activeMonsterDefaultCount == 1 && commonValues == 1)) {
          for (IVColor key in ivButtonsMap.keys) {
            ivButtonsMap[key] = activeMonsterIVList.contains(key) || pairedMonsterIVList.contains(key);
          }
        } else if (commonValues == 2 && activeMonsterDefaultCount == 1) {
          for (IVColor key in ivButtonsMap.keys) {
            ivButtonsMap[key] = activeMonsterIVList.contains(key) || !pairedMonsterIVList.contains(key);
          }
        }
      }
    }
    return ivButtonsMap;
  }
}
