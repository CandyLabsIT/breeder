//ignore_for_file: cascade_invocations

import 'package:breeder/blocks/pages/genealogical_tree/first_gen/a_first_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/first_gen_cubit.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_init_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_iv_buttons_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_monster_default_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_model.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_buttons/iv_buttons_model.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:breeder/shared/models/max_iv_form/max_iv_form_model.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  await initLocator();

  group('Tests of FirstGenCubit process', () {
    FirstGenCubit actualFirstGenCubit = globalLocator<FirstGenCubit>();
    MaxIVFormCubit maxIVFormCubit = globalLocator<MaxIVFormCubit>();
    FirstGenModel actualFirstGenModel = FirstGenModel();
    IVButtonsModel ivButtonsModel = IVButtonsModel();

    MaxIVFormModel maxIVFormModel = MaxIVFormModel()
      ..maxIVTextEditingControllersList[0].text = '0'
      ..maxIVTextEditingControllersList[1].text = '1'
      ..maxIVTextEditingControllersList[2].text = '1'
      ..maxIVTextEditingControllersList[3].text = '1'
      ..maxIVTextEditingControllersList[4].text = '1';

    maxIVFormCubit.maxIVFormModel = maxIVFormModel;

    MonsterModel actualFirstGenMonsterModel() {
      List<IVColor> ivList = <IVColor>[IVColor.defaultColor];
      bool isAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.firstGen;
      MonsterModel firstGenMonsterModel = MonsterModel(ivColorList: ivList, isAutoFilledBool: isAutoFilledBool, monsterGen: monsterGen);
      return firstGenMonsterModel;
    }

    Map<FirstGenIndex, MonsterModel> expectedFirstGenMap = <FirstGenIndex, MonsterModel>{
      for (FirstGenIndex firstGenIndex in FirstGenIndex.values) firstGenIndex: actualFirstGenMonsterModel()
    };

    test('Should return [FirstGenInitState] state', () {
      AFirstGenState expectedFirstGenState = FirstGenInitState();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should return [FirstGenInitState] when [FirstGenModel] data is initialized', () {
      actualFirstGenCubit.firstGenModel = actualFirstGenModel;

      AFirstGenState expectedFirstGenState = FirstGenInitState();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenColorsChangedState] if [firstGenModel was added, and start color was default]', () {
      expectedFirstGenMap[FirstGenIndex.one] = MonsterModel(
        ivColorList: const <IVColor>[IVColor.atkColor],
        isAutoFilledBool: false,
        monsterGen: expectedFirstGenMap[FirstGenIndex.one]!.monsterGen,
      );

      Map<FirstGenIndex, List<IVColor>> expectedIVColorMap = expectedFirstGenMap.map((FirstGenIndex firstGenIndex, MonsterModel monsterModel) =>
          MapEntry<FirstGenIndex, List<IVColor>>(firstGenIndex, monsterModel.ivColorList));

      AFirstGenState expectedFirstGenState = FirstGenColorsChangedState(firstGenMap: expectedIVColorMap);

      actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.atkColor);

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenColorsChangedState] if [firstGenModel has been atkColor and new color is the same]', () {
      expectedFirstGenMap[FirstGenIndex.one] = MonsterModel(
        ivColorList: const <IVColor>[IVColor.defaultColor],
        isAutoFilledBool: false,
        monsterGen: expectedFirstGenMap[FirstGenIndex.one]!.monsterGen,
      );

      Map<FirstGenIndex, List<IVColor>> expectedIVColorMap = expectedFirstGenMap.map((FirstGenIndex firstGenIndex, MonsterModel monsterModel) =>
          MapEntry<FirstGenIndex, List<IVColor>>(firstGenIndex, monsterModel.ivColorList));

      AFirstGenState expectedFirstGenState = FirstGenColorsChangedState(firstGenMap: expectedIVColorMap);

      actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.atkColor);

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenColorsChangedState] if [all monsters are reset]', () {
      expectedFirstGenMap[FirstGenIndex.one] = MonsterModel(
        ivColorList: const <IVColor>[IVColor.defaultColor],
        isAutoFilledBool: false,
        monsterGen: expectedFirstGenMap[FirstGenIndex.one]!.monsterGen,
      );

      Map<FirstGenIndex, List<IVColor>> expectedIVColorMap = expectedFirstGenMap.map((FirstGenIndex firstGenIndex, MonsterModel monsterModel) =>
          MapEntry<FirstGenIndex, List<IVColor>>(firstGenIndex, monsterModel.ivColorList));

      AFirstGenState expectedFirstGenState = FirstGenColorsChangedState(firstGenMap: expectedIVColorMap);

      actualFirstGenCubit.resetAllToDefaultColors();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenMonsterDefaultState] if [monster value is reset]', () {
      Map<FirstGenIndex, List<IVColor>> expectedIVColorMap = expectedFirstGenMap.map((FirstGenIndex firstGenIndex, MonsterModel monsterModel) =>
          MapEntry<FirstGenIndex, List<IVColor>>(firstGenIndex, monsterModel.ivColorList));

      AFirstGenState expectedFirstGenState = FirstGenMonsterDefaultState(firstGenMap: expectedIVColorMap);

      actualFirstGenCubit.resetMonsterToDefaultIVColors(FirstGenIndex.two);

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenIVButtonsState for index one] if [index one color value is defaultColor]', () {
      Map<IVColor, bool> expectedIVButtonMap = Map<IVColor, bool>.from(ivButtonsModel.ivButtonsMap);

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit.setIVStateIndexOne();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenIVButtonsState for index one] if [monster value was defaultColor and user add speedColor]', () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: false
      };

      expectedIVButtonMap[IVColor.speedColor] = true;

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.speedColor);

      actualFirstGenCubit.setIVStateIndexOne();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenIVButtonsState for index one] if [monster value was defaultColor and user press hpColor]', () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: false
      };

      expectedIVButtonMap[IVColor.speedColor] = true;

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.hpColor);

      actualFirstGenCubit.setIVStateIndexOne();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenIVButtonsState for index one] if [monster value was speedColor and user add speedColor]', () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: true
      };

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.speedColor);

      actualFirstGenCubit.setIVStateIndexOne();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenIVButtonsState for index two] if [monster value is defaultColor]', () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: true
      };

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit.setIVStateIndexTwo();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });
    test('Should emit [FirstGenIVButtonsState for index two] if [monster value is defaultColor and previous monster color is speedColor]', () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: true
      };

      expectedIVButtonMap[IVColor.speedColor] = false;

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.speedColor);

      actualFirstGenCubit.setIVStateIndexTwo();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test(
        'Should emit [FirstGenIVButtonsState for index two] if [monster value is defaultColor, new color is atkColor and previous monster color is speedColor]',
        () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: false
      };

      expectedIVButtonMap[IVColor.atkColor] = true;

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit.setIVColors(FirstGenIndex.two, IVColor.atkColor);

      actualFirstGenCubit.setIVStateIndexTwo();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test(
        'Should emit [FirstGenIVButtonsState for index two] if [monster value is atkColor and user try to press hpColor and previous monster color is speedColor]',
        () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: false
      };

      expectedIVButtonMap[IVColor.atkColor] = true;

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit.setIVColors(FirstGenIndex.two, IVColor.hpColor);

      actualFirstGenCubit.setIVStateIndexTwo();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test(
        'Should emit [FirstGenIVButtonsState for index two] if [monster value is atkColor and user press atkColor and previous monster color is speedColor]',
        () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: true
      };

      expectedIVButtonMap[IVColor.speedColor] = false;

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit.setIVColors(FirstGenIndex.two, IVColor.atkColor);

      actualFirstGenCubit.setIVStateIndexTwo();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenIVButtonsState for index three] if [monster value is defaultColor]', () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: true
      };

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit.setIVStateIndexThree();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenIVButtonsState for index three] if [monster value is defaultColor and new IVColor is atkColor]', () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: false
      };

      expectedIVButtonMap[IVColor.atkColor] = true;

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit
        ..setIVColors(FirstGenIndex.three, IVColor.atkColor)
        ..setIVStateIndexThree();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenIVButtonsState for index three] if [monster value is atkColor and user tried chose defColor]', () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: false
      };

      expectedIVButtonMap[IVColor.atkColor] = true;

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit
        ..setIVColors(FirstGenIndex.three, IVColor.defColor)
        ..setIVStateIndexThree();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should emit [FirstGenIVButtonsState for index three] if [monster value is atkColor and user chose atkColor]', () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: true
      };

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit
        ..setIVColors(FirstGenIndex.three, IVColor.atkColor)
        ..setIVStateIndexThree();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test(
        'Should emit [FirstGenIVButtonsState for index four] if [monster value is defaultColor and in previous pair is atkColor and speedColor and female was atkColor]',
        () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: true
      };

      expectedIVButtonMap[IVColor.atkColor] = false;
      expectedIVButtonMap[IVColor.speedColor] = false;

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit
        ..setIVColors(FirstGenIndex.two, IVColor.atkColor)
        ..setIVColors(FirstGenIndex.three, IVColor.atkColor)
        ..setIVStateIndexFour();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test(
        'Should emit [FirstGenIVButtonsState for index four] if [monster value is defaultColor and in previous pair is atkColor and speedColor and female was hpColor]',
        () {
      late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: false
      };

      expectedIVButtonMap[IVColor.atkColor] = true;
      expectedIVButtonMap[IVColor.speedColor] = true;

      AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

      actualFirstGenCubit
        ..resetMonsterToDefaultIVColors(FirstGenIndex.three)
        ..setIVColors(FirstGenIndex.three, IVColor.hpColor)
        ..setIVStateIndexFour();

      expect(actualFirstGenCubit.state, expectedFirstGenState);
    });

    test('Should return [true] if [firstGenIndex is one and index value is equal to 1]', () {
      bool expectBool = true;
      actualFirstGenCubit.resetAllToDefaultColors();
      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
      bool actualBool = actualFirstGenCubit.getMonstersEnabledState()[actualFirstGenIndex]!;
      expect(actualBool, expectBool);
    });

    test('Should return [true] if [firstGenIndex is two and index value is equal to 2 and previous monster does not include defaultColor]', () {
      bool expectBool = true;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.two;
      actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.speedColor);
      bool actualBool = actualFirstGenCubit.getMonstersEnabledState()[actualFirstGenIndex]!;

      expect(actualBool, expectBool);
    });

    test('Should return [false] if [firstGenIndex is two and index value is equal to 2 and previous monster include defaultColor]', () {
      bool expectBool = false;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.two;
      actualFirstGenCubit.resetAllToDefaultColors();
      bool actualBool = actualFirstGenCubit.getMonstersEnabledState()[actualFirstGenIndex]!;

      expect(actualBool, expectBool);
    });

    test('Should return [false] if [firstGenIndex is two and index value is equal to 2 and previous monster include defaultColor]', () {
      bool expectBool = false;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.two;
      bool actualBool = actualFirstGenCubit.isRestartButtonEnabled(actualFirstGenIndex);

      expect(actualBool, expectBool);
    });

    test('Should return [false] if [firstGenIndex is three and index value is equal to 3]', () {
      bool expectBool = false;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.three;
      bool actualBool = actualFirstGenCubit.getMonstersEnabledState()[actualFirstGenIndex]!;

      expect(actualBool, expectBool);
    });

    test('Should return [true] if [firstGenIndex is three and index value is equal to 3 and previous index contains non default value]', () {
      bool expectBool = true;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.three;
      actualFirstGenCubit.setIVColors(FirstGenIndex.two, IVColor.atkColor);
      bool actualBool = actualFirstGenCubit.getMonstersEnabledState()[actualFirstGenIndex]!;

      expect(actualBool, expectBool);
    });

    test('Should return [four] if [firstGenIndex is four and index value is equal to 4 and previous monster has default color]', () {
      bool expectBool = false;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.four;
      bool actualBool = actualFirstGenCubit.getMonstersEnabledState()[actualFirstGenIndex]!;

      expect(actualBool, expectBool);
    });

    test('Should return [four] if [firstGenIndex is four and index value is equal to 4 and previous monster has default color]', () {
      bool expectBool = true;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.four;
      actualFirstGenCubit.setIVColors(FirstGenIndex.three, IVColor.atkColor);
      bool actualBool = actualFirstGenCubit.getMonstersEnabledState()[actualFirstGenIndex]!;

      expect(actualBool, expectBool);
    });

    test('Should return [false] if [firstGenIndex is one and index value is equal to 1 and previous monster does not include defaultColor]', () {
      bool expectBool = false;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
      bool actualBool = actualFirstGenCubit.isRestartButtonEnabled(actualFirstGenIndex);

      expect(actualBool, expectBool);
    });

    test('Should return [false] if [firstGenIndex is one and index value is equal to 1 and previous monster does not include defaultColor]', () {
      bool expectBool = true;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
      IVColor actualIVColor = IVColor.hpColor;
      actualFirstGenCubit.setIVColors(actualFirstGenIndex, actualIVColor);
      bool actualBool = actualFirstGenCubit.isRestartButtonEnabled(actualFirstGenIndex);

      expect(actualBool, expectBool);
    });

    test('Should return [32] if [maxIVFormModel[0] is equal to 0]', () {
      int expectedMonsterAmount = 32;

      int actualAmonMonsterAmount = actualFirstGenCubit.getMonstersAmount();

      expect(actualAmonMonsterAmount, expectedMonsterAmount);
    });

    test('Should return [32] if [maxIVFormModel[0] is equal to 32]', () {
      int expectedMonsterAmount = 32;

      MaxIVFormModel maxIVFormModel = MaxIVFormModel()..maxIVTextEditingControllersList[0].text = '32';

      maxIVFormCubit.maxIVFormModel = maxIVFormModel;

      int actualAmonMonsterAmount = actualFirstGenCubit.getMonstersAmount();

      expect(actualAmonMonsterAmount, expectedMonsterAmount);
    });

    test('Should return [12] if [maxIVFormModel[0] is equal to 12]', () {
      int expectedMonsterAmount = 12;

      MaxIVFormModel maxIVFormModel = MaxIVFormModel()..maxIVTextEditingControllersList[0].text = '12';

      maxIVFormCubit.maxIVFormModel = maxIVFormModel;

      int actualAmonMonsterAmount = actualFirstGenCubit.getMonstersAmount();

      expect(actualAmonMonsterAmount, expectedMonsterAmount);
    });
  });
}
