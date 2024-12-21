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
import 'package:breeder/shared/models/max_iv_form/max_iv_form_model.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  await initLocator();

  group('Tests of [FirstGenCubit] process', () {
    //Arrange
    late FirstGenCubit firstGenCubit;
    late SecondGenCubit actualSecondGenCubit;
    MaxIVFormCubit maxIVFormCubit = globalLocator<MaxIVFormCubit>();

    MonsterModel actualSecondGenMonsterModel() {
      List<IVColor> ivList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      bool isAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel secondGenMonsterModel = MonsterModel(ivColorList: ivList, isAutoFilledBool: isAutoFilledBool, monsterGen: monsterGen);
      return secondGenMonsterModel;
    }

    Map<SecondGenIndex, MonsterModel> expectedSecondGenMap = <SecondGenIndex, MonsterModel>{
      for (SecondGenIndex secondGenIndex in SecondGenIndex.values) secondGenIndex: actualSecondGenMonsterModel()
    };

    Map<SecondGenIndex, List<IVColor>> expectedIVColorMap = expectedSecondGenMap.map((SecondGenIndex secondGenIndex, MonsterModel monsterModel) =>
        MapEntry<SecondGenIndex, List<IVColor>>(secondGenIndex, monsterModel.ivColorList));

    MaxIVFormModel maxIVFormModel = MaxIVFormModel()..maxIVTextEditingControllersList[0].text = '0';

    maxIVFormCubit.maxIVFormModel = maxIVFormModel;

    group('Test of SecondGenCubit when [first monster parents are not filled with IVs]', () {
      // Act
      setUpAll(() {
        firstGenCubit = FirstGenCubit();
        actualSecondGenCubit = SecondGenCubit();
      });

      test('Should return [SecondGenInitState] state', () {
        //Arrange
        ASecondGenState expectedSecondGenState = SecondGenInitState();

        // Assert
        expect(actualSecondGenCubit.state, expectedSecondGenState);
      });

      test('Should return [false] when [first monster parents are not filled]', () {
        //Arrange
        Map<SecondGenIndex, bool> expectedMonsterButtonsMap = <SecondGenIndex, bool>{
          for (SecondGenIndex secondGenIndex in SecondGenIndex.values) secondGenIndex: false
        };

        // Act
        Map<SecondGenIndex, bool> actualMonsterButtonsMap = actualSecondGenCubit.getMonstersState();

        // Assert
        expectLater(actualMonsterButtonsMap, expectedMonsterButtonsMap);
      });
    });

    group('Test of SecondGenCubit when [monster parents are filled]', () {
      // Act
      setUpAll(() {
        firstGenCubit = globalLocator<FirstGenCubit>();
        actualSecondGenCubit = globalLocator<SecondGenCubit>();
      });

      test(
          'Should emit [SecondGenColorsChangedState] with [default ivList of secondGenMap[SecondGenIndex.one] when [FirstGenColorsChangedState] and [first parent of first monster is filled]',
          () {
        //Arrange
        ASecondGenState expectedSecondGenState = SecondGenColorsChangedState(secondGenMap: expectedIVColorMap);

        // Act
        firstGenCubit.setIVColors(FirstGenIndex.one, IVColor.hpColor);

        // Assert
        expectLater(actualSecondGenCubit.stream, emitsInOrder(<dynamic>[expectedSecondGenState]));
      });

      test(
          'Should emit [SecondGenColorsChangedState] with updated ivList (IVColor.atkColor, IVColor.hpColor) of secondGenMap[SecondGenIndex.one] when [FirstGenColorsChangedState is emitted] and [both parents are filled with IV]',
          () {
        //Arrange
        expectedIVColorMap[SecondGenIndex.one] = <IVColor>[IVColor.atkColor, IVColor.hpColor];
        ASecondGenState expectedSecondGenState = SecondGenColorsChangedState(secondGenMap: expectedIVColorMap);

        // Act
        firstGenCubit.setIVColors(FirstGenIndex.two, IVColor.atkColor);

        // Assert
        expectLater(actualSecondGenCubit.stream, emitsInOrder(<dynamic>[expectedSecondGenState]));
      });

      test('Should return [true] when [both parents are filled with IV]', () {
        //Arrange
        Map<SecondGenIndex, bool> expectedMonsterButtonsMap = <SecondGenIndex, bool>{
          for (SecondGenIndex secondGenIndex in SecondGenIndex.values) secondGenIndex: false
        };
        expectedMonsterButtonsMap[SecondGenIndex.one] = true;

        // Act
        Map<SecondGenIndex, bool> actualMonsterButtonsMap = actualSecondGenCubit.getMonstersState();

        // Assert
        expect(actualMonsterButtonsMap, expectedMonsterButtonsMap);
      });

      test(
          'Should return [SecondGenColorsChangedState] with restored to default ivList of secondGenMap[SecondGenIndex.one] when [FirstGenColorsChangedState is emitted] and [parents are reset]',
          () {
        //Arrange
        expectedIVColorMap[SecondGenIndex.one] = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
        ASecondGenState expectedSecondGenState = SecondGenColorsChangedState(secondGenMap: expectedIVColorMap);

        // Act
        firstGenCubit.resetMonsterToDefaultIVColors(FirstGenIndex.one);

        // Assert
        expectLater(actualSecondGenCubit.stream, emitsInOrder(<dynamic>[expectedSecondGenState]));
      });
    });

    group('Tests of SecondGenCubit.getInheritedMonsterNumber()', () {
      //Act
      setUpAll(() {
        firstGenCubit = globalLocator<FirstGenCubit>();
        actualSecondGenCubit = globalLocator<SecondGenCubit>();
      });

      test('Should return [16] when number of first Gen monsters is [32]', () {
        //Arrange
        int expectedMonstersNumber = 16;

        // Act
        firstGenCubit.getMonstersNumber();
        int actualMonstersNumber = actualSecondGenCubit.getInheritedMonsterNumber();

        // Assert
        expect(actualMonstersNumber, expectedMonstersNumber);
      });

      test('Should return [8] when number of first Gen monsters is [16]', () {
        //Arrange
        int expectedMonstersNumber = 8;

        // Act
        MaxIVFormModel maxIVFormModel = MaxIVFormModel()..maxIVTextEditingControllersList[0].text = '16';
        maxIVFormCubit.maxIVFormModel = maxIVFormModel;
        firstGenCubit.getMonstersNumber();
        int actualMonstersAmount = actualSecondGenCubit.getInheritedMonsterNumber();

        // Assert
        expect(actualMonstersAmount, expectedMonstersNumber);
      });
    });
  });
}
