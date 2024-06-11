//ignore_for_file: cascade_invocations

import 'dart:ui';

import 'package:breeder/blocks/pages/second_generation/a_second_generation_cubit.dart';
import 'package:breeder/blocks/pages/second_generation/second_generation_cubit.dart';
import 'package:breeder/blocks/pages/second_generation/state/female_colors_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/init_second_generation_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/male_colors_state.dart.dart';
import 'package:breeder/blocks/pages/second_generation/state/restarted_female_values_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/restarted_male_values_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/second_generation_model.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  await initLocator();

  group('Tests of SecondGenerationCubit process', () {
    SecondGenerationCubit actualSecondGenerationCubit = globalLocator<SecondGenerationCubit>();

    SecondGenerationModel secondGenerationModel = SecondGenerationModel()
      ..secondGenerationFemaleIVList[0] = 4
      ..secondGenerationFemaleIVList[1] = 0
      ..secondGenerationMaleIVList[0] = 3
      ..secondGenerationMaleIVList[1] = 0;

    test('Should emit [ASecondGenerationState] state', () {
      ASecondGenerationState expectedInitSecondGenerationState = InitSecondGenerationState();

      expect(actualSecondGenerationCubit.state, expectedInitSecondGenerationState);
    });
    test('Should emit [MaxIVFormInitState] when [MaxIVSlotsModel] data is initialized', () {
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
    test('Should return [RestartedFemaleValues] if [secondGenerationFemaleIVList is not none]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel;

      actualSecondGenerationCubit.resetFemaleValues();

      ASecondGenerationState expectedRestartedFemaleValues = const RestartedFemaleValuesState(valuesList: <Color>[Color(0xFFD9D9D9), Color(0xFFD9D9D9)]);

      expect(actualSecondGenerationCubit.state, expectedRestartedFemaleValues);
    });

    test('Should return [RestartedMaleValues] if [secondGenerationMaleIVList is not none]', () {
      actualSecondGenerationCubit.secondGenerationModel = secondGenerationModel;

      actualSecondGenerationCubit.resetMaleValues();

      ASecondGenerationState expectedRestartedMaleValues = const RestartedMaleValuesState(valuesList: <Color>[Color(0xFFD9D9D9), Color(0xFFD9D9D9)]);

      expect(actualSecondGenerationCubit.state, expectedRestartedMaleValues);
    });
  });
}
