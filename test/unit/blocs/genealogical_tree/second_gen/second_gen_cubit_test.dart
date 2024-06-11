import 'package:breeder/blocks/pages/genealogical_tree/first_gen/first_gen_cubit.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/state/second_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/state/second_gen_init_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:breeder/shared/models/max_iv_form/max_iv_form_model.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  await initLocator();

  group('Tests of FirstGenCubit process', () {
    FirstGenCubit firstGenCubit = globalLocator<FirstGenCubit>();
    SecondGenCubit actualSecondGenCubit = globalLocator<SecondGenCubit>();
    SecondGenModel actualSecondGenModel = SecondGenModel();
    MaxIVFormCubit maxIVFormCubit = globalLocator<MaxIVFormCubit>();

    MonsterModel actualSecondGenMonsterModel() {
      List<IVColor> ivList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      bool isAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel secondGenMonsterModel = MonsterModel(ivColorList: ivList, isAutoFilledBool: isAutoFilledBool, monsterGen: monsterGen);
      return secondGenMonsterModel;
    }

    MaxIVFormModel maxIVFormModel = MaxIVFormModel()
      ..maxIVTextEditingControllersList[0].text = '0'
      ..maxIVTextEditingControllersList[1].text = '1'
      ..maxIVTextEditingControllersList[2].text = '1'
      ..maxIVTextEditingControllersList[3].text = '1'
      ..maxIVTextEditingControllersList[4].text = '1';

    maxIVFormCubit.maxIVFormModel = maxIVFormModel;

    Map<SecondGenIndex, MonsterModel> expectedSecondGenMap = <SecondGenIndex, MonsterModel>{
      for (SecondGenIndex secondGenIndex in SecondGenIndex.values) secondGenIndex: actualSecondGenMonsterModel()
    };

    Map<SecondGenIndex, List<IVColor>> expectedIVColorMap = expectedSecondGenMap.map((SecondGenIndex secondGenIndex, MonsterModel monsterModel) =>
        MapEntry<SecondGenIndex, List<IVColor>>(secondGenIndex, monsterModel.ivColorList));

    test('Should return [SecondGenInitState] state', () {
      ASecondGenState expectedSecondGenState = SecondGenInitState();

      expect(actualSecondGenCubit.state, expectedSecondGenState);
    });

    test('Should return [SecondGenInitState] state when [SecondGenModel] data is initialized', () {
      ASecondGenState expectedSecondGenState = SecondGenInitState();

      actualSecondGenCubit.secondGenModel = actualSecondGenModel;

      expect(actualSecondGenCubit.state, expectedSecondGenState);
    });

    test('Should emit [SecondGenColorsChangedState] if [FirstGenColorsChangedState is emitted and parents han non default values]', () async {
      expectedIVColorMap[SecondGenIndex.one] = <IVColor>[IVColor.atkColor, IVColor.hpColor];

      ASecondGenState expectedSecondGenState = SecondGenColorsChangedState(secondGenMap: expectedIVColorMap);

      firstGenCubit
        ..setIVColors(FirstGenIndex.one, IVColor.hpColor)
        ..setIVColors(FirstGenIndex.two, IVColor.atkColor);

      await expectLater(actualSecondGenCubit.stream, emitsInOrder(<dynamic>[expectedSecondGenState]));
    });

    test('Should return [false for key SecondGenIndex.one in map] if FirstGenIndex.one and two in firstGen map has default values', () {
      Map<SecondGenIndex, bool> expectedMonsterButtonsMap = <SecondGenIndex, bool>{
        for (SecondGenIndex secondGenIndex in SecondGenIndex.values) secondGenIndex: false
      };

      Map<SecondGenIndex, bool> actualMonsterButtonsMap = actualSecondGenCubit.getMonstersState();

      expect(actualMonsterButtonsMap, expectedMonsterButtonsMap);
    });

    test(
        'Should return [false for key SecondGenIndex.one in map] if FirstGenIndex.one has not default value and index two has default value in firstGen map',
        () async {
      Map<SecondGenIndex, bool> expectedMonsterButtonsMap = <SecondGenIndex, bool>{
        for (SecondGenIndex secondGenIndex in SecondGenIndex.values) secondGenIndex: false
      };

      firstGenCubit.setIVColors(FirstGenIndex.one, IVColor.atkColor);

      Map<SecondGenIndex, bool> actualMonsterButtonsMap = actualSecondGenCubit.getMonstersState();
      await expectLater(actualMonsterButtonsMap, expectedMonsterButtonsMap);
    });

    test('Should return [16] if amount of first Gen monsters is 32', () {
      int expectedMonstersAmount = 16;

      firstGenCubit.getMonstersAmount();

      int actualMonstersAmount = actualSecondGenCubit.getInheritedMonsterAmount();

      expect(actualMonstersAmount, expectedMonstersAmount);
    });

    test('Should return [8] if amount of first Gen monsters is 16', () {
      int expectedMonstersAmount = 8;

      MaxIVFormModel maxIVFormModel = MaxIVFormModel()..maxIVTextEditingControllersList[0].text = '16';

      maxIVFormCubit.maxIVFormModel = maxIVFormModel;
      firstGenCubit.getMonstersAmount();

      int actualMonstersAmount = actualSecondGenCubit.getInheritedMonsterAmount();

      expect(actualMonstersAmount, expectedMonstersAmount);
    });

    test('Should return [3] if amount of first Gen monsters is 5', () {
      int expectedMonstersAmount = 3;

      MaxIVFormModel maxIVFormModel = MaxIVFormModel()..maxIVTextEditingControllersList[0].text = '5';

      maxIVFormCubit.maxIVFormModel = maxIVFormModel;
      firstGenCubit.getMonstersAmount();

      int actualMonstersAmount = actualSecondGenCubit.getInheritedMonsterAmount();

      expect(actualMonstersAmount, expectedMonstersAmount);
    });
  });
}
