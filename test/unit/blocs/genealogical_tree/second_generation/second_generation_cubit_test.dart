import 'dart:ui';

import 'package:breeder/blocks/pages/second_generation/a_second_generation_state.dart';
import 'package:breeder/blocks/pages/second_generation/second_generation_cubit.dart';
import 'package:breeder/blocks/pages/second_generation/state/female_colors_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/init_second_generation_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/male_colors_state.dart.dart';
import 'package:breeder/blocks/pages/second_generation/state/restarted_female_values_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/restarted_male_values_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/second_generation/second_generation_model.dart';
import 'package:flutter_test/flutter_test.dart';

//ignore_for_file: cascade_invocations

Future<void> main() async {
  await initLocator();

  group('Tests of SecondGenerationCubit process', () {
    SecondGenerationCubit actualSecondGenerationCubit = globalLocator<SecondGenerationCubit>();

    SecondGenerationModel secondGenerationModel = SecondGenerationModel()
      ..secondGenerationFemaleIVList[0] = 4
      ..secondGenerationFemaleIVList[1] = 0
      ..secondGenerationMaleIVList[0] = 3
      ..secondGenerationMaleIVList[1] = 0;

    test('Should return [InitSecondGenerationState] state', () {
      ASecondGenerationState expectedInitSecondGenerationState = InitSecondGenerationState();

      expect(actualSecondGenerationCubit.state, expectedInitSecondGenerationState);
    });

    test('Should return [MaxIVFormInitState] when [MaxIVSlotsModel] data is initialized', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel;

      ASecondGenerationState expectedInitSecondGenerationState = InitSecondGenerationState();

      expect(actualSecondGenerationCubit.state, expectedInitSecondGenerationState);
    });

    test('Should return [FemaleColorsState] if [femaleValue is not none]', () {
      int actualFemaleValue = 3;

      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel;

      actualSecondGenerationCubit.getFemaleColors(actualFemaleValue);

      ASecondGenerationState expectedFemaleColorsState = const FemaleColorsState(valuesList: <Color>[Color(0xFFFFDAD6), Color(0xFFFDFB8E)]);

      expect(actualSecondGenerationCubit.state, expectedFemaleColorsState);
    });

    test('Should return [MaleColorsState] if [maleValue is not none]', () {
      int actualMaleValue = 1;

      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel;

      actualSecondGenerationCubit.getMaleColors(actualMaleValue);

      ASecondGenerationState expectedFemaleColorsState = const MaleColorsState(valuesList: <Color>[Color(0xFFFDFB8E), Color(0xFFFA4A78)]);

      expect(actualSecondGenerationCubit.state, expectedFemaleColorsState);
    });

    test('Should return [RestartedFemaleValuesState] if [secondGenerationFemaleIVList is not none]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel;

      actualSecondGenerationCubit.resetFemaleValues();

      ASecondGenerationState expectedRestartedFemaleValues =
          const RestartedFemaleValuesState(valuesList: <Color>[Color(0xFFD9D9D9), Color(0xFFD9D9D9)]);

      expect(actualSecondGenerationCubit.state, expectedRestartedFemaleValues);
    });

    test('Should return [RestartedMaleValuesState] if [secondGenerationMaleIVList is not none]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel;

      actualSecondGenerationCubit.resetMaleValues();

      ASecondGenerationState expectedRestartedMaleValues = const RestartedMaleValuesState(valuesList: <Color>[Color(0xFFD9D9D9), Color(0xFFD9D9D9)]);

      expect(actualSecondGenerationCubit.state, expectedRestartedMaleValues);
    });

    test('Should return [all true values] if [both values in secondGenerationFemaleIVList == 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel;

      List<bool> actualButtonsState = actualSecondGenerationCubit.isFemaleButtonsEnabled();

      List<bool> expectedButtonsState = List<bool>.filled(7, true);

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [all true values] if [only value secondGenerationFemaleIVList[0] > 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 4
        ..secondGenerationFemaleIVList[1] = 0;

      List<bool> actualButtonsState = actualSecondGenerationCubit.isFemaleButtonsEnabled();

      List<bool> expectedButtonsState = List<bool>.filled(7, true);

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [all true values] if [only value secondGenerationFemaleIVList[1] > 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 0
        ..secondGenerationFemaleIVList[1] = 6;

      List<bool> actualButtonsState = actualSecondGenerationCubit.isFemaleButtonsEnabled();

      List<bool> expectedButtonsState = List<bool>.filled(7, true);

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [two true values] if [both values in secondGenerationFemaleIVList > 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 4
        ..secondGenerationFemaleIVList[1] = 3;

      List<bool> actualButtonsState = actualSecondGenerationCubit.isFemaleButtonsEnabled();

      List<bool> expectedButtonsState = <bool>[true, false, false, true, true, false, false];

      expect(actualButtonsState, expectedButtonsState);
    });

    test(
        'Should return [three false values] if [only secondGenerationFemaleIVList[0]> 0, both values in secondGenerationMaleIVList > 0 and secondGenerationFemaleIVList[0] != each values in secondGenerationMaleIVList]',
        () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 4
        ..secondGenerationFemaleIVList[1] = 0
        ..secondGenerationMaleIVList[0] = 3
        ..secondGenerationMaleIVList[1] = 2;

      List<bool> actualButtonsState = actualSecondGenerationCubit.isFemaleButtonsEnabled();

      List<bool> expectedButtonsState = <bool>[true, false, true, true, true, false, false];

      expect(actualButtonsState, expectedButtonsState);
    });

    test(
        'Should return [only one false value] if [only secondGenerationFemaleIVList[0]> 0, both values in secondGenerationMaleIVList > 0 and secondGenerationFemaleIVList[0] == one of values in secondGenerationFemaleIVList]',
        () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 3
        ..secondGenerationFemaleIVList[1] = 0
        ..secondGenerationMaleIVList[0] = 3
        ..secondGenerationMaleIVList[1] = 2;

      List<bool> actualButtonsState = actualSecondGenerationCubit.isFemaleButtonsEnabled();

      List<bool> expectedButtonsState = <bool>[true, true, false, true, true, true, true];

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [all true values] if [both values in secondGenerationMaleIVList == 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationMaleIVList[0] = 0
        ..secondGenerationMaleIVList[1] = 0;

      List<bool> actualButtonsState = actualSecondGenerationCubit.isMaleButtonsEnabled();

      List<bool> expectedButtonsState = List<bool>.filled(7, true);

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [all true values] if [if only secondGenerationMaleIVList[0] > 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationMaleIVList[0] = 3
        ..secondGenerationMaleIVList[1] = 0;

      List<bool> actualButtonsState = actualSecondGenerationCubit.isMaleButtonsEnabled();

      List<bool> expectedButtonsState = List<bool>.filled(7, true);

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [two true values] if [both values in secondGenerationMaleIVList > 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationMaleIVList[0] = 4
        ..secondGenerationMaleIVList[1] = 3;

      List<bool> actualButtonsState = actualSecondGenerationCubit.isMaleButtonsEnabled();

      List<bool> expectedButtonsState = <bool>[false, false, false, true, true, false, false];

      expect(actualButtonsState, expectedButtonsState);
    });

    test(
        'Should return [three false values] if [only secondGenerationMaleIVList[0]> 0 and both values in secondGenerationFemaleIVList > 0 and secondGenerationMaleIVList[0] != of both values in secondGenerationFemaleIVList]',
        () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationMaleIVList[0] = 4
        ..secondGenerationMaleIVList[1] = 0
        ..secondGenerationFemaleIVList[0] = 3
        ..secondGenerationFemaleIVList[1] = 2;

      List<bool> actualButtonsState = actualSecondGenerationCubit.isMaleButtonsEnabled();

      List<bool> expectedButtonsState = <bool>[true, false, true, true, true, false, false];

      expect(actualButtonsState, expectedButtonsState);
    });

    test(
        'Should return [only one false value] if [only secondGenerationMaleIVList[0]> 0 and both values in secondGenerationFemaleIVList > 0 and secondGenerationMaleIVList[0] == one of values in secondGenerationFemaleIVList]',
        () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationMaleIVList[0] = 3
        ..secondGenerationMaleIVList[1] = 0
        ..secondGenerationFemaleIVList[0] = 3
        ..secondGenerationFemaleIVList[1] = 2;

      List<bool> actualButtonsState = actualSecondGenerationCubit.isMaleButtonsEnabled();

      List<bool> expectedButtonsState = <bool>[true, true, false, true, true, true, true];

      expect(actualButtonsState, expectedButtonsState);
    });

    test('Should return [true] if [both values in secondGenerationFemaleIVList > 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 3
        ..secondGenerationFemaleIVList[1] = 2;

      bool actualButtonState = actualSecondGenerationCubit.isFemaleRestartButtonEnabled();

      bool expectedButtonsState = true;

      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [true] if [only secondGenerationFemaleIVList[0] > 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 1
        ..secondGenerationFemaleIVList[1] = 0;

      bool actualButtonState = actualSecondGenerationCubit.isFemaleRestartButtonEnabled();

      bool expectedButtonsState = true;
      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [true] if [only secondGenerationFemaleIVList[1] > 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 0
        ..secondGenerationFemaleIVList[1] = 2;

      bool actualButtonState = actualSecondGenerationCubit.isFemaleRestartButtonEnabled();

      bool expectedButtonsState = true;
      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [false] if [both values in secondGenerationFemaleIVList[0] == 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 0
        ..secondGenerationFemaleIVList[1] = 0;

      bool actualButtonState = actualSecondGenerationCubit.isFemaleRestartButtonEnabled();

      bool expectedButtonsState = false;
      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [true] if [both values in secondGenerationMaleIVList > 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationMaleIVList[0] = 1
        ..secondGenerationMaleIVList[1] = 2;

      bool actualButtonState = actualSecondGenerationCubit.isMaleRestartButtonEnabled();

      bool expectedButtonsState = true;
      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [true] if [only secondGenerationMaleIVList[1] > 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationMaleIVList[0] = 0
        ..secondGenerationMaleIVList[1] = 2;

      bool actualButtonState = actualSecondGenerationCubit.isMaleRestartButtonEnabled();

      bool expectedButtonsState = true;
      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [true] if [only secondGenerationMaleIVList[0] > 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationMaleIVList[0] = 1
        ..secondGenerationMaleIVList[1] = 0;

      bool actualButtonState = actualSecondGenerationCubit.isMaleRestartButtonEnabled();

      bool expectedButtonsState = true;
      expect(actualButtonState, expectedButtonsState);
    });

    test('Should return [false] if [both values in secondGenerationMaleIVList == 0]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel
        ..secondGenerationMaleIVList[0] = 0
        ..secondGenerationMaleIVList[1] = 0;

      bool actualButtonState = actualSecondGenerationCubit.isMaleRestartButtonEnabled();

      bool expectedButtonsState = false;
      expect(actualButtonState, expectedButtonsState);
    });
  });
}
