import 'dart:async';

import 'package:breeder/blocks/pages/genealogical_tree/first_gen/a_first_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/first_gen_cubit.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_monster_default_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/state/second_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/state/second_gen_init_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenCubit extends Cubit<ASecondGenState> {
  final FirstGenCubit _firstGenCubit = globalLocator<FirstGenCubit>();
  late StreamSubscription<AFirstGenState> _firstGenCubitSubscription;
  SecondGenModel secondGenModel = SecondGenModel();

  SecondGenCubit() : super(SecondGenInitState()) {
    _firstGenCubitSubscription = _firstGenCubit.stream.listen(
      (AFirstGenState state) {
        if (state is FirstGenColorsChangedState || state is FirstGenMonsterDefaultState) {
          handleFirstGenColorsChanged();
        }
      },
    );
  }

  void handleFirstGenColorsChanged() {
    for (SecondGenIndex secondGenIndex in SecondGenIndex.values) {
      _updateMonsterModel(secondGenIndex);
    }
    emit(SecondGenColorsChangedState(secondGenMap: _getIVColorMap()));
  }

  Map<SecondGenIndex, List<IVColor>> getIVColor() {
    if (state is SecondGenColorsChangedState) {
      return (state as SecondGenColorsChangedState).secondGenMap;
    }
    return _getIVColorMap();
  }

  Map<SecondGenIndex, bool> getMonstersState() {
    Map<SecondGenIndex, bool> monstersStateMap = _getMonstersStateMap();
    return monstersStateMap;
  }

  // TODO(balladyna): After adjustments in MaxIVPage, the 'if' condition will become redundant and should be removed.
  int getInheritedMonsterAmount() {
    double inheritedMonsterAmount = _firstGenCubit.getMonstersAmount() / 2;

    if (inheritedMonsterAmount - inheritedMonsterAmount.floor() == 0.5) {
      return inheritedMonsterAmount.round();
    } else {
      return inheritedMonsterAmount.truncate();
    }
  }

  Map<SecondGenIndex, List<IVColor>> _getIVColorMap() {
    Map<SecondGenIndex, List<IVColor>> ivColorMap = secondGenModel.secondGenMap.map((SecondGenIndex secondGenIndex, MonsterModel monsterModel) =>
        MapEntry<SecondGenIndex, List<IVColor>>(secondGenIndex, monsterModel.ivColorList));
    return ivColorMap;
  }

  Map<SecondGenIndex, bool> _getMonstersStateMap() {
    Map<SecondGenIndex, bool> monsterButtonsMap = secondGenModel.secondGenMap.map(
        (SecondGenIndex secondGenIndex, MonsterModel monsterModel) => MapEntry<SecondGenIndex, bool>(secondGenIndex, monsterModel.isAutoFilledBool));
    return monsterButtonsMap;
  }

  void _updateMonsterModel(SecondGenIndex secondGenIndex) {
    int motherFirstGenIndexValue = secondGenModel.getMotherIndexValue(secondGenIndex);
    int fatherFirstGenIndexValue = secondGenModel.getFatherIndexValue(secondGenIndex);

    FirstGenIndex motherFirstGenIndex = _firstGenCubit.firstGenModel.getIndexFromValue(motherFirstGenIndexValue);
    FirstGenIndex fatherFirstGenIndex = _firstGenCubit.firstGenModel.getIndexFromValue(fatherFirstGenIndexValue);

    List<IVColor> parentsList = <IVColor>[
      _firstGenCubit.firstGenModel.firstGenMap[motherFirstGenIndex]!.ivColorList[0],
      _firstGenCubit.firstGenModel.firstGenMap[fatherFirstGenIndex]!.ivColorList[0]
    ];

    if (parentsList.contains(IVColor.defaultColor)) {
      secondGenModel.setDefaultValues(secondGenIndex);
    } else {
      secondGenModel.propagateFromParent(secondGenIndex, parentsList);
    }
  }

  @override
  Future<void> close() {
    _firstGenCubitSubscription.cancel();
    return super.close();
  }
}
