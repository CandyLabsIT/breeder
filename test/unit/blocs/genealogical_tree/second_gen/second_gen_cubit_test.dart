import 'dart:ui';

import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/state/second_gen_female_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/state/second_gen_female_colors_default_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/state/second_gen_init_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/state/second_gen_male_colors_changed_state.dart.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/state/second_gen_male_colors_default_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:flutter_test/flutter_test.dart';

//ignore_for_file: cascade_invocations

Future<void> main() async {
  await initLocator();

  group('Tests of SecondGenerationCubit process', () {
    SecondGenCubit actualSecondGenCubit = globalLocator<SecondGenCubit>();

    SecondGenModel secondGenerationModel = SecondGenModel()
      ..secondGenFemaleIVList[0] = 4
      ..secondGenFemaleIVList[1] = 0
      ..secondGenMaleIVList[0] = 3
      ..secondGenMaleIVList[1] = 0;

    test('Should return [SecondGenerationInitState] state', () {
      ASecondGenState expectedSecondGenInitState = InitSecondGenState();

      expect(actualSecondGenCubit.state, expectedSecondGenInitState);
    });

    test('Should return [SecondGenerationInitState] when [SecondGenModel] data is initialized', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel;

      ASecondGenState expectedSecondGenInitState = InitSecondGenState();

      expect(actualSecondGenCubit.state, expectedSecondGenInitState);
    });

    test('Should return [FemaleColorsState] if [femaleValue is not none]', () {
      int actualFemaleValue = 3;

      actualSecondGenCubit.secondGenerationModel = secondGenerationModel;

      actualSecondGenCubit.getIVFemaleColors(actualFemaleValue);

      ASecondGenState expectedSecondGenFemaleColorsChangedState =
          const SecondGenFemaleColorsChangedState(colorsList: <Color>[Color(0xFFFFDAD6), Color(0xFFFDFB8E)]);

      expect(actualSecondGenCubit.state, expectedSecondGenFemaleColorsChangedState);
    });

    test('Should return [MaleColorsState] if [maleValue is not none]', () {
      int actualMaleValue = 1;

      actualSecondGenCubit.secondGenerationModel = secondGenerationModel;

      actualSecondGenCubit.getIVMaleColors(actualMaleValue);

      ASecondGenState expectedSecondGenFemaleColorsChangedState =
          const SecondGenMaleColorsChangedState(colorsList: <Color>[Color(0xFFFDFB8E), Color(0xFFFA4A78)]);

      expect(actualSecondGenCubit.state, expectedSecondGenFemaleColorsChangedState);
    });

    test('Should return [SecondGenFemaleColorsDefaultState] if [secondGenFemaleIVList is not none]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel;

      actualSecondGenCubit.restoreFemaleDefaultColors();

      ASecondGenState expectedSecondGenFemaleColorsDefaultState =
          const SecondGenFemaleColorsDefaultState(colorsList: <Color>[Color(0xFFD9D9D9), Color(0xFFD9D9D9)]);

      expect(actualSecondGenCubit.state, expectedSecondGenFemaleColorsDefaultState);
    });

    test('Should return [SecondGenMaleColorsDefaultState] if [secondGenMaleIVList is not none]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel;

      actualSecondGenCubit.restoreMaleDefaultColors();

      ASecondGenState expectedSecondGenMaleColorsDefaultState =
          const SecondGenMaleColorsDefaultState(colorsList: <Color>[Color(0xFFD9D9D9), Color(0xFFD9D9D9)]);

      expect(actualSecondGenCubit.state, expectedSecondGenMaleColorsDefaultState);
    });

    test('Should return [all true values] if [both values in secondGenFemaleIVList == 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel;

      List<bool> actualButtonsState = actualSecondGenCubit.isFemaleButtonsEnabled();

      List<bool> expectedButtonsState = List<bool>.filled(7, true);

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [all true values] if [only value secondGenFemaleIVList[0] > 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenFemaleIVList[0] = 4
        ..secondGenFemaleIVList[1] = 0;

      List<bool> actualButtonsState = actualSecondGenCubit.isFemaleButtonsEnabled();

      List<bool> expectedButtonsState = List<bool>.filled(7, true);

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [all true values] if [only value secondGenFemaleIVList[1] > 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenFemaleIVList[0] = 0
        ..secondGenFemaleIVList[1] = 6;

      List<bool> actualButtonsState = actualSecondGenCubit.isFemaleButtonsEnabled();

      List<bool> expectedButtonsState = List<bool>.filled(7, true);

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [two true values] if [both values in secondGenerationFemaleIVList > 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenFemaleIVList[0] = 4
        ..secondGenFemaleIVList[1] = 3;

      List<bool> actualButtonsState = actualSecondGenCubit.isFemaleButtonsEnabled();

      List<bool> expectedButtonsState = <bool>[true, false, false, true, true, false, false];

      expect(actualButtonsState, expectedButtonsState);
    });

    test(
        'Should return [three false values] if [only secondGenFemaleIVList[0]> 0, both values in secondGenMaleIVList > 0 and secondGenFemaleIVList[0] != each values in secondGenMaleIVList]',
        () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenFemaleIVList[0] = 4
        ..secondGenFemaleIVList[1] = 0
        ..secondGenMaleIVList[0] = 3
        ..secondGenMaleIVList[1] = 2;

      List<bool> actualButtonsState = actualSecondGenCubit.isFemaleButtonsEnabled();

      List<bool> expectedButtonsState = <bool>[true, false, true, true, true, false, false];

      expect(actualButtonsState, expectedButtonsState);
    });

    test(
        'Should return [only one false value] if [only secondGenFemaleIVList[0]> 0, both values in secondGenMaleIVList > 0 and secondGenFemaleIVList[0] == one of values in secondGenFemaleIVList]',
        () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenFemaleIVList[0] = 3
        ..secondGenFemaleIVList[1] = 0
        ..secondGenMaleIVList[0] = 3
        ..secondGenMaleIVList[1] = 2;

      List<bool> actualButtonsState = actualSecondGenCubit.isFemaleButtonsEnabled();

      List<bool> expectedButtonsState = <bool>[true, true, false, true, true, true, true];

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [all true values] if [both values in secondGenMaleIVList == 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenMaleIVList[0] = 0
        ..secondGenMaleIVList[1] = 0;

      List<bool> actualButtonsState = actualSecondGenCubit.isMaleButtonsEnabled();

      List<bool> expectedButtonsState = List<bool>.filled(7, true);

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [all true values] if [if only secondGenMaleIVList[0] > 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenMaleIVList[0] = 3
        ..secondGenMaleIVList[1] = 0;

      List<bool> actualButtonsState = actualSecondGenCubit.isMaleButtonsEnabled();

      List<bool> expectedButtonsState = List<bool>.filled(7, true);

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [two true values] if [both values in secondGenMaleIVList > 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenMaleIVList[0] = 4
        ..secondGenMaleIVList[1] = 3;

      List<bool> actualButtonsState = actualSecondGenCubit.isMaleButtonsEnabled();

      List<bool> expectedButtonsState = <bool>[false, false, false, true, true, false, false];

      expect(actualButtonsState, expectedButtonsState);
    });

    test(
        'Should return [three false values] if [only secondGenMaleIVList[0]> 0 and both values in secondGenFemaleIVList > 0 and secondGenMaleIVList[0] != of both values in secondGenFemaleIVList]',
        () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenMaleIVList[0] = 4
        ..secondGenMaleIVList[1] = 0
        ..secondGenFemaleIVList[0] = 3
        ..secondGenFemaleIVList[1] = 2;

      List<bool> actualButtonsState = actualSecondGenCubit.isMaleButtonsEnabled();

      List<bool> expectedButtonsState = <bool>[true, false, true, true, true, false, false];

      expect(actualButtonsState, expectedButtonsState);
    });

    test(
        'Should return [only one false value] if [only secondGenMaleIVList[0]> 0 and both values in secondGenFemaleIVList > 0 and secondGenMaleIVList[0] == one of values in secondGenFemaleIVList]',
        () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenMaleIVList[0] = 3
        ..secondGenMaleIVList[1] = 0
        ..secondGenFemaleIVList[0] = 3
        ..secondGenFemaleIVList[1] = 2;

      List<bool> actualButtonsState = actualSecondGenCubit.isMaleButtonsEnabled();

      List<bool> expectedButtonsState = <bool>[true, true, false, true, true, true, true];

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [true] if [both values in secondGenFemaleIVList > 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenFemaleIVList[0] = 3
        ..secondGenFemaleIVList[1] = 2;

      bool actualButtonState = actualSecondGenCubit.isFemaleRestartButtonEnabled();

      bool expectedButtonsState = true;

      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [true] if [only secondGenFemaleIVList[0] > 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenFemaleIVList[0] = 1
        ..secondGenFemaleIVList[1] = 0;

      bool actualButtonState = actualSecondGenCubit.isFemaleRestartButtonEnabled();

      bool expectedButtonsState = true;
      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [true] if [only secondGenFemaleIVList[1] > 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenFemaleIVList[0] = 0
        ..secondGenFemaleIVList[1] = 2;

      bool actualButtonState = actualSecondGenCubit.isFemaleRestartButtonEnabled();

      bool expectedButtonsState = true;
      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [false] if [both values in secondGenFemaleIVList[0] == 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenFemaleIVList[0] = 0
        ..secondGenFemaleIVList[1] = 0;

      bool actualButtonState = actualSecondGenCubit.isFemaleRestartButtonEnabled();

      bool expectedButtonsState = false;
      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [true] if [both values in secondGenMaleIVList > 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenMaleIVList[0] = 1
        ..secondGenMaleIVList[1] = 2;

      bool actualButtonState = actualSecondGenCubit.isMaleRestartButtonEnabled();

      bool expectedButtonsState = true;
      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [true] if [only secondGenMaleIVList[1] > 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenMaleIVList[0] = 0
        ..secondGenMaleIVList[1] = 2;

      bool actualButtonState = actualSecondGenCubit.isMaleRestartButtonEnabled();

      bool expectedButtonsState = true;
      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [true] if [only secondGenMaleIVList[0] > 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenMaleIVList[0] = 1
        ..secondGenMaleIVList[1] = 0;

      bool actualButtonState = actualSecondGenCubit.isMaleRestartButtonEnabled();

      bool expectedButtonsState = true;
      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [false] if [both values in secondGenMaleIVList == 0]', () {
      actualSecondGenCubit.secondGenerationModel = secondGenerationModel
        ..secondGenMaleIVList[0] = 0
        ..secondGenMaleIVList[1] = 0;

      bool actualButtonState = actualSecondGenCubit.isMaleRestartButtonEnabled();

      bool expectedButtonsState = false;
      expect(actualButtonState, expectedButtonsState);
    });
  });
}
