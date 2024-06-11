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
import 'package:breeder/shared/models/genealogical_tree/iv_buttons/iv_buttons_model.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:breeder/shared/models/max_iv_form/max_iv_form_model.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  await initLocator();

  group('Tests of FirstGenCubit process', () {
    // Act
    late FirstGenCubit actualFirstGenCubit;
    MaxIVFormCubit maxIVFormCubit = globalLocator<MaxIVFormCubit>();
    IVButtonsModel ivButtonsModel = IVButtonsModel();

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

    MaxIVFormModel maxIVFormModel = MaxIVFormModel()..maxIVTextEditingControllersList[0].text = '0';
    maxIVFormCubit.maxIVFormModel = maxIVFormModel;

    group('Test of [FirstGenCubit] initialization', () {
      setUp(() {
        actualFirstGenCubit = FirstGenCubit();
      });

      test('Should emit [FirstGenInitState] state', () {
        //Arrange
        AFirstGenState expectedFirstGenState = FirstGenInitState();

        // Assert
        expect(actualFirstGenCubit.state, expectedFirstGenState);
      });
    });

    group('Test of FirstGenCubit.getMonstersEnabledState()', () {
      // Act
      setUpAll(() {
        actualFirstGenCubit = FirstGenCubit();
      });

      test('Should return [true] and [enable first monster to set IV] for [first monster]', () {
        //Arrange
        bool expectedEnabledStateBool = true;

        // Act
        FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
        bool actualEnabledStateBool = actualFirstGenCubit.getMonstersEnabledState()[actualFirstGenIndex]!;

        // Assert
        expect(actualEnabledStateBool, expectedEnabledStateBool);
      });

      test('Should return [false] and [disable first monster to set IV] for second monster when [first monster is not filled with IV]', () {
        //Arrange
        bool expectedEnabledStateBool = false;

        // Act
        FirstGenIndex actualFirstGenIndex = FirstGenIndex.two;
        actualFirstGenCubit.resetAllToDefaultColors();
        bool actualEnabledStateBool = actualFirstGenCubit.getMonstersEnabledState()[actualFirstGenIndex]!;

        // Assert
        expect(actualEnabledStateBool, expectedEnabledStateBool);
      });

      test('Should return [true] and [enable first monster to set IV] for second monster when [first monster is filled with attack IV]', () {
        //Arrange
        bool expectedEnabledStateBool = true;

        // Act
        FirstGenIndex actualFirstGenIndex = FirstGenIndex.two;
        actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.atkColor);

        bool actualEnabledStateBool = actualFirstGenCubit.getMonstersEnabledState()[actualFirstGenIndex]!;

        // Assert
        expect(actualEnabledStateBool, expectedEnabledStateBool);
      });
    });

    group('Test of FirstGenCubit.isRestartButtonEnabled()', () {
      // Act
      setUpAll(() {
        actualFirstGenCubit = FirstGenCubit();
      });

      test('Should return [false] and [disable restart button for first monster] when [first monster is not filled with IV]', () {
        //Arrange
        bool expectedEnabledStateBool = false;

        // Act
        FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
        bool actualEnabledStateBool = actualFirstGenCubit.isRestartButtonEnabled(actualFirstGenIndex);

        // Assert
        expect(actualEnabledStateBool, expectedEnabledStateBool);
      });

      test('Should return [true] and [enable restart button for first monster] when [user choose attack IV for first monster]', () {
        //Arrange
        bool expectedEnabledStateBool = true;

        // Act
        FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
        actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.atkColor);
        bool actualEnabledStateBool = actualFirstGenCubit.isRestartButtonEnabled(actualFirstGenIndex);

        // Assert
        expect(actualEnabledStateBool, expectedEnabledStateBool);
      });

      test('Should return [true] and [enable restart button for first monster] when [user choose hp IV for second monster]', () {
        //Arrange
        bool expectedEnabledStateBool = true;

        // Act
        FirstGenIndex actualFirstGenIndex = FirstGenIndex.two;
        actualFirstGenCubit.setIVColors(FirstGenIndex.two, IVColor.hpColor);
        bool actualEnabledStateBool = actualFirstGenCubit.isRestartButtonEnabled(actualFirstGenIndex);

        // Assert
        expect(actualEnabledStateBool, expectedEnabledStateBool);
      });
    });

    group('Test of FirstGenCubit.setIVColors()', () {
      // Act
      setUpAll(() {
        actualFirstGenCubit = FirstGenCubit();
      });

      test(
          'Should emit [FirstGenColorsChangedState] with [filled ivList of firstGenMap[FirstGenIndex.one] with IVColor.atkColor] when [user choose attack IV for first monster]',
          () {
        //Arrange
        expectedFirstGenMap[FirstGenIndex.one] = MonsterModel(
          ivColorList: const <IVColor>[IVColor.atkColor],
          isAutoFilledBool: false,
          monsterGen: expectedFirstGenMap[FirstGenIndex.one]!.monsterGen,
        );

        Map<FirstGenIndex, List<IVColor>> expectedIVColorMap = expectedFirstGenMap.map((FirstGenIndex firstGenIndex, MonsterModel monsterModel) =>
            MapEntry<FirstGenIndex, List<IVColor>>(firstGenIndex, monsterModel.ivColorList));

        AFirstGenState expectedFirstGenState = FirstGenColorsChangedState(firstGenMap: expectedIVColorMap);

        // Act
        actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.atkColor);

        // Assert
        expect(actualFirstGenCubit.state, expectedFirstGenState);
        expect(actualFirstGenCubit.getIVColors(), expectedIVColorMap);
      });

      test(
          'Should emit [FirstGenColorsChangedState] with [filled ivList of firstGenMap[FirstGenIndex.two] with IVColor.speedColor] when [user choose speed IV for second monster]',
          () {
        //Arrange
        expectedFirstGenMap[FirstGenIndex.two] = MonsterModel(
          ivColorList: const <IVColor>[IVColor.speedColor],
          isAutoFilledBool: false,
          monsterGen: expectedFirstGenMap[FirstGenIndex.one]!.monsterGen,
        );

        Map<FirstGenIndex, List<IVColor>> expectedIVColorMap = expectedFirstGenMap.map((FirstGenIndex firstGenIndex, MonsterModel monsterModel) =>
            MapEntry<FirstGenIndex, List<IVColor>>(firstGenIndex, monsterModel.ivColorList));
        AFirstGenState expectedFirstGenState = FirstGenColorsChangedState(firstGenMap: expectedIVColorMap);

        // Act
        actualFirstGenCubit.setIVColors(FirstGenIndex.two, IVColor.speedColor);

        // Assert
        expect(actualFirstGenCubit.state, expectedFirstGenState);
      });

      test(
          'Should emit [FirstGenColorsChangedState]  with restored to default ivList of firstGenMap[FirstGenIndex.one] when [user choose again attack IV for first monster]',
          () {
        //Arrange
        expectedFirstGenMap[FirstGenIndex.one] = MonsterModel(
          ivColorList: const <IVColor>[IVColor.defaultColor],
          isAutoFilledBool: false,
          monsterGen: expectedFirstGenMap[FirstGenIndex.one]!.monsterGen,
        );

        expectedFirstGenMap[FirstGenIndex.two] = MonsterModel(
          ivColorList: const <IVColor>[IVColor.defaultColor],
          isAutoFilledBool: false,
          monsterGen: expectedFirstGenMap[FirstGenIndex.one]!.monsterGen,
        );

        Map<FirstGenIndex, List<IVColor>> expectedIVColorMap = expectedFirstGenMap.map((FirstGenIndex firstGenIndex, MonsterModel monsterModel) =>
            MapEntry<FirstGenIndex, List<IVColor>>(firstGenIndex, monsterModel.ivColorList));

        AFirstGenState expectedFirstGenState = FirstGenColorsChangedState(firstGenMap: expectedIVColorMap);

        // Act
        actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.atkColor);

        // Assert
        expect(actualFirstGenCubit.state, expectedFirstGenState);
      });
    });

    group('Test of FirstGenCubit.setIVStateIndexOne()', () {
      // Act
      setUpAll(() {
        actualFirstGenCubit = FirstGenCubit();
      });

      test('Should emit [FirstGenIVButtonsState] with [ivButtonMap where all IVColors has true values] when [first monster IV is not filled with IV]',
          () {
        //Arrange
        Map<IVColor, bool> expectedIVButtonMap = Map<IVColor, bool>.from(ivButtonsModel.ivButtonsMap);

        AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

        // Act
        actualFirstGenCubit.setIVStateIndexOne();

        // Assert
        expect(actualFirstGenCubit.state, expectedFirstGenState);
      });

      test(
          'Should emit [FirstGenIVButtonsState] with [ivButtonMap where only atkColor has true value] when [user choose attack IV for first monster]',
          () {
        //Arrange
        late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
          for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: false
        };

        expectedIVButtonMap[IVColor.atkColor] = true;
        AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

        // Act
        actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.atkColor);
        actualFirstGenCubit.setIVStateIndexOne();

        // Assert
        expect(actualFirstGenCubit.state, expectedFirstGenState);
      });
    });

    group('Test of FirstGenCubit.setIVStateIndexTwo()', () {
      // Act
      setUpAll(() {
        actualFirstGenCubit = FirstGenCubit();
      });

      test(
          'Should emit [FirstGenIVButtonsState] with [ivButtonMap where only atkColor has false value] when [first monster is filled with attack IV] and [second monster is not filled with IV]',
          () {
        //Arrange
        late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
          for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: true
        };

        expectedIVButtonMap[IVColor.atkColor] = false;
        AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

        // Act
        actualFirstGenCubit.setIVColors(FirstGenIndex.one, IVColor.atkColor);
        actualFirstGenCubit.setIVStateIndexTwo();

        // Assert
        expect(actualFirstGenCubit.state, expectedFirstGenState);
      });

      test('Should emit [FirstGenIVButtonsState] with [ivButtonMap where only hpColor has true value] when [user choose hp IV for second monster]',
          () {
        //Arrange
        late Map<IVColor, bool> expectedIVButtonMap = <IVColor, bool>{
          for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: false
        };

        expectedIVButtonMap[IVColor.hpColor] = true;
        AFirstGenState expectedFirstGenState = FirstGenIVButtonsState(ivButtonMap: expectedIVButtonMap);

        // Act
        actualFirstGenCubit.setIVColors(FirstGenIndex.two, IVColor.hpColor);
        actualFirstGenCubit.setIVStateIndexTwo();

        // Assert
        expect(actualFirstGenCubit.state, expectedFirstGenState);
      });
    });

    group('Tests of FirstGenCubit.resetMonsterToDefaultIVColors()', () {
      // Act
      setUpAll(() {
        actualFirstGenCubit = FirstGenCubit();
      });

      test(
          'Should emit [FirstGenMonsterDefaultState] with restored to default ivList of firstGenMap[FirstGenIndex.two] for second monster when [second monster is reset]',
          () {
        //Arrange
        Map<FirstGenIndex, List<IVColor>> expectedIVColorMap = expectedFirstGenMap.map((FirstGenIndex firstGenIndex, MonsterModel monsterModel) =>
            MapEntry<FirstGenIndex, List<IVColor>>(firstGenIndex, monsterModel.ivColorList));

        expectedIVColorMap[FirstGenIndex.two] = <IVColor>[IVColor.defaultColor];
        AFirstGenState expectedFirstGenState = FirstGenMonsterDefaultState(firstGenMap: expectedIVColorMap);

        // Act
        actualFirstGenCubit.resetMonsterToDefaultIVColors(FirstGenIndex.two);

        // Assert
        expect(actualFirstGenCubit.state, expectedFirstGenState);
      });
    });

    group('Tests of [FirstGenCubit.resetAllToDefaultColors()] - this method is invoked only when user returns to main menu view', () {
      // Act
      setUpAll(() {
        actualFirstGenCubit = FirstGenCubit();
      });

      test('Should emit [FirstGenColorsChangedState] with restored to default ivList of firstGenMap] when [all monsters are reset]', () {
        //Arrange
        expectedFirstGenMap[FirstGenIndex.one] = MonsterModel(
          ivColorList: const <IVColor>[IVColor.defaultColor],
          isAutoFilledBool: false,
          monsterGen: expectedFirstGenMap[FirstGenIndex.one]!.monsterGen,
        );

        expectedFirstGenMap[FirstGenIndex.two] = MonsterModel(
          ivColorList: const <IVColor>[IVColor.defaultColor],
          isAutoFilledBool: false,
          monsterGen: expectedFirstGenMap[FirstGenIndex.one]!.monsterGen,
        );

        Map<FirstGenIndex, List<IVColor>> expectedIVColorMap = expectedFirstGenMap.map((FirstGenIndex firstGenIndex, MonsterModel monsterModel) =>
            MapEntry<FirstGenIndex, List<IVColor>>(firstGenIndex, monsterModel.ivColorList));
        AFirstGenState expectedFirstGenState = FirstGenColorsChangedState(firstGenMap: expectedIVColorMap);

        // Act
        actualFirstGenCubit.resetAllToDefaultColors();

        // Assert
        expect(actualFirstGenCubit.state, expectedFirstGenState);
      });
    });

    group('Tests of FirstGenCubit.getMonstersNumber()', () {
      test('Should return [32] when [0 (zero) monster with 1 IV user added in MaxIVFormPage]', () {
        //Arrange
        int expectedMonsterAmount = 32;

        // Act
        int actualMonsterAmount = actualFirstGenCubit.getMonstersNumber();

        // Assert
        expect(actualMonsterAmount, expectedMonsterAmount);
      });

      test('Should return [12] when [12 monsters with 1 IV user added in MaxIVFormPage]', () {
        //Arrange
        int expectedMonsterAmount = 12;

        // Act
        MaxIVFormModel maxIVFormModel = MaxIVFormModel()..maxIVTextEditingControllersList[0].text = '12';
        maxIVFormCubit.maxIVFormModel = maxIVFormModel;

        int actualMonsterAmount = actualFirstGenCubit.getMonstersNumber();

        // Assert
        expect(actualMonsterAmount, expectedMonsterAmount);
      });
    });
  });
}
