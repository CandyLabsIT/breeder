import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_colors_default_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_init_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen_index.dart';
import 'package:flutter_test/flutter_test.dart';

//ignore_for_file: cascade_invocations

Future<void> main() async {
  await initLocator();

  group('Tests of SecondGenerationCubit process', () {
    SecondGenCubit actualSecondGenCubit = globalLocator<SecondGenCubit>();

    List<IVColor> ivColorList = <IVColor>[];

    SecondGenModel secondGenModel = SecondGenModel()
      ..secondGenMap[SecondGenIndex.one]![0] = IVColor.hpColor
      ..secondGenMap[SecondGenIndex.one]![1] = IVColor.defColor
      ..secondGenMap[SecondGenIndex.two]![0] = IVColor.defColor
      ..secondGenMap[SecondGenIndex.two]![1] = IVColor.atkColor;

    test('Should return [SecondGenerationInitState] state', () {
      ASecondGenState expectedSecondGenInitState = InitSecondGenState();

      expect(actualSecondGenCubit.state, expectedSecondGenInitState);
    });

    test('Should return [SecondGenerationInitState] when [SecondGenModel] data is initialized', () {
      actualSecondGenCubit.secondGenModel = secondGenModel;

      ASecondGenState expectedSecondGenInitState = InitSecondGenState();

      expect(actualSecondGenCubit.state, expectedSecondGenInitState);
    });

    test('Should emit [SecondGenColorsChangedState] if [SecondGenMap values changed]', () {
      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{};

      for (SecondGenIndex index in SecondGenIndex.values) {
        if (index == SecondGenIndex.one) {
          ivColorList = <IVColor>[IVColor.defColor, IVColor.defaultColor];
        } else {
          ivColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
        }
        expectedSecondGenMap[index] = ivColorList;
      }

      ASecondGenState expectedSecondGenState = SecondGenColorsChangedState(colorsMap: expectedSecondGenMap);

      actualSecondGenCubit.setColors(SecondGenIndex.one, IVColor.defColor);

      expect(actualSecondGenCubit.state, expectedSecondGenState);
    });

    test('Should return [SecondGenColorsChangedState] if [all values are restart]', () {
      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
        for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
      };

      ASecondGenState expectedSecondGenState = SecondGenColorsChangedState(colorsMap: expectedSecondGenMap);

      actualSecondGenCubit.setAllDefaultValues();

      expect(actualSecondGenCubit.state, expectedSecondGenState);
    });

    test('Should return [SecondGenListColorsDefaultState] if [SecondGenMap is not none]', () {
      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
        for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
      };

      ASecondGenState expectedSecondGenState = SecondGenListColorsDefaultState(colorsMap: expectedSecondGenMap);

      ivColorList = <IVColor>[IVColor.atkColor, IVColor.spAtkColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.six] = ivColorList;

      actualSecondGenCubit.setListDefaultColors(SecondGenIndex.six);

      expect(actualSecondGenCubit.state, expectedSecondGenState);
    });
    //
    // test('Should return [SecondGenMaleColorsDefaultState] if [secondGenMaleIVList is not none]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel;
    //
    //   actualSecondGenCubit.setMaleDefaultColors(SecondGenIndex.pairZero);
    //
    //   ASecondGenState expectedSecondGenMaleColorsDefaultState = const SecondGenMaleColorsDefaultState(colorsList: <Color>[
    //     Color(0xFFD9D9D9),
    //     Color(0xFFD9D9D9),
    //     Color(0xffd9d9d9),
    //     Color(0xffd9d9d9),
    //     Color(0xffd9d9d9),
    //     Color(0xffd9d9d9),
    //     Color(0xffd9d9d9),
    //     Color(0xffd9d9d9),
    //     Color(0xffd9d9d9),
    //     Color(0xffd9d9d9),
    //     Color(0xffd9d9d9),
    //     Color(0xffd9d9d9),
    //     Color(0xffd9d9d9),
    //     Color(0xffd9d9d9)
    //   ]);
    //
    //   expect(actualSecondGenCubit.state, expectedSecondGenMaleColorsDefaultState);
    // });
    //
    // test('Should return [all true values] if [both values in secondGenFemaleIVList == 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel;
    //
    //   List<bool> actualButtonsState = actualSecondGenCubit.getButtonsState(SecondGenIndex.pairZero);
    //
    //   List<bool> expectedButtonsState = List<bool>.filled(7, true);
    //
    //   expect(actualButtonsState, expectedButtonsState);
    // });
    //
    // test('Should return [all true values] if [only value secondGenFemaleIVList[0] > 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][0][0] = 4
    //     ..secondGenIVList[0][0][1] = 0;
    //
    //   List<bool> actualButtonsState = actualSecondGenCubit.getButtonsState(SecondGenIndex.pairZero);
    //
    //   List<bool> expectedButtonsState = List<bool>.filled(7, true);
    //
    //   expect(actualButtonsState, expectedButtonsState);
    // });
    //
    // test('Should return [all true values] if [only value secondGenFemaleIVList[1] > 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][0][0] = 0
    //     ..secondGenIVList[0][0][1] = 6;
    //
    //   List<bool> actualButtonsState = actualSecondGenCubit.getButtonsState(SecondGenIndex.pairZero);
    //
    //   List<bool> expectedButtonsState = List<bool>.filled(7, true);
    //
    //   expect(actualButtonsState, expectedButtonsState);
    // });
    //
    // test('Should return [two true values] if [both values in secondGenerationFemaleIVList > 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][0][0] = 4
    //     ..secondGenIVList[0][0][1] = 3;
    //
    //   List<bool> actualButtonsState = actualSecondGenCubit.getButtonsState(SecondGenIndex.pairZero);
    //
    //   List<bool> expectedButtonsState = <bool>[true, false, false, true, true, false, false];
    //
    //   expect(actualButtonsState, expectedButtonsState);
    // });
    //
    // test(
    //     'Should return [three false values] if [only secondGenFemaleIVList[0]> 0, both values in secondGenMaleIVList > 0 and secondGenFemaleIVList[0] != each values in secondGenMaleIVList]',
    //     () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][0][0] = 4
    //     ..secondGenIVList[0][0][1] = 0
    //     ..secondGenIVList[0][1][0] = 3
    //     ..secondGenIVList[0][1][1] = 2;
    //
    //   List<bool> actualButtonsState = actualSecondGenCubit.getButtonsState(SecondGenIndex.pairZero);
    //
    //   List<bool> expectedButtonsState = <bool>[true, false, true, true, true, false, false];
    //
    //   expect(actualButtonsState, expectedButtonsState);
    // });
    //
    // test(
    //     'Should return [only one false value] if [only secondGenFemaleIVList[0]> 0, both values in secondGenMaleIVList > 0 and secondGenFemaleIVList[0] == one of values in secondGenFemaleIVList]',
    //     () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][0][0] = 3
    //     ..secondGenIVList[0][0][1] = 0
    //     ..secondGenIVList[0][1][0] = 3
    //     ..secondGenIVList[0][1][1] = 2;
    //
    //   List<bool> actualButtonsState = actualSecondGenCubit.getButtonsState(SecondGenIndex.pairZero);
    //
    //   List<bool> expectedButtonsState = <bool>[true, true, false, true, true, true, true];
    //
    //   expect(actualButtonsState, expectedButtonsState);
    // });
    //
    // test('Should return [all true values] if [both values in secondGenMaleIVList == 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][1][0] = 0
    //     ..secondGenIVList[0][1][1] = 0;
    //
    //   List<bool> actualButtonsState = actualSecondGenCubit.getMaleButtonsState(SecondGenIndex.pairZero);
    //
    //   List<bool> expectedButtonsState = List<bool>.filled(7, true);
    //
    //   expect(actualButtonsState, expectedButtonsState);
    // });
    //
    // test('Should return [all true values] if [if only secondGenMaleIVList[0] > 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][1][0] = 3
    //     ..secondGenIVList[0][1][1] = 0;
    //
    //   List<bool> actualButtonsState = actualSecondGenCubit.getMaleButtonsState(SecondGenIndex.pairZero);
    //
    //   List<bool> expectedButtonsState = List<bool>.filled(7, true);
    //
    //   expect(actualButtonsState, expectedButtonsState);
    // });
    //
    // test('Should return [two true values] if [both values in secondGenMaleIVList > 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][1][0] = 4
    //     ..secondGenIVList[0][1][1] = 3;
    //
    //   List<bool> actualButtonsState = actualSecondGenCubit.getMaleButtonsState(SecondGenIndex.pairZero);
    //
    //   List<bool> expectedButtonsState = <bool>[true, false, false, true, true, false, false];
    //
    //   expect(actualButtonsState, expectedButtonsState);
    // });
    //
    // test(
    //     'Should return [three false values] if [only secondGenMaleIVList[0]> 0 and both values in secondGenFemaleIVList > 0 and secondGenMaleIVList[0] != of both values in secondGenFemaleIVList]',
    //     () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][1][0] = 4
    //     ..secondGenIVList[0][1][1] = 0
    //     ..secondGenIVList[0][0][0] = 3
    //     ..secondGenIVList[0][0][1] = 2;
    //
    //   List<bool> actualButtonsState = actualSecondGenCubit.getMaleButtonsState(SecondGenIndex.pairZero);
    //
    //   List<bool> expectedButtonsState = <bool>[true, false, true, true, true, false, false];
    //
    //   expect(actualButtonsState, expectedButtonsState);
    // });
    //
    // test(
    //     'Should return [only one false value] if [only secondGenMaleIVList[0]> 0 and both values in secondGenFemaleIVList > 0 and secondGenMaleIVList[0] == one of values in secondGenFemaleIVList]',
    //     () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][1][0] = 3
    //     ..secondGenIVList[0][1][1] = 0
    //     ..secondGenIVList[0][0][0] = 3
    //     ..secondGenIVList[0][0][1] = 2;
    //
    //   List<bool> actualButtonsState = actualSecondGenCubit.getMaleButtonsState(SecondGenIndex.pairZero);
    //
    //   List<bool> expectedButtonsState = <bool>[true, true, false, true, true, true, true];
    //
    //   expect(actualButtonsState, expectedButtonsState);
    // });
    //
    // test('Should return [true] if [both values in secondGenFemaleIVList > 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][0][0] = 3
    //     ..secondGenIVList[0][0][1] = 2;
    //
    //   bool actualButtonState = actualSecondGenCubit.isRestartButtonEnabled(SecondGenIndex.pairZero);
    //
    //   bool expectedButtonsState = true;
    //
    //   expect(actualButtonState, expectedButtonsState);
    // });
    //
    // test('Should return [true] if [only secondGenFemaleIVList[0] > 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][0][0] = 1
    //     ..secondGenIVList[0][0][1] = 0;
    //
    //   bool actualButtonState = actualSecondGenCubit.isRestartButtonEnabled(SecondGenIndex.pairZero);
    //
    //   bool expectedButtonsState = true;
    //   expect(actualButtonState, expectedButtonsState);
    // });
    //
    // test('Should return [true] if [only secondGenFemaleIVList[1] > 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][0][0] = 0
    //     ..secondGenIVList[0][0][1] = 2;
    //
    //   bool actualButtonState = actualSecondGenCubit.isRestartButtonEnabled(SecondGenIndex.pairZero);
    //
    //   bool expectedButtonsState = true;
    //   expect(actualButtonState, expectedButtonsState);
    // });
    //
    // test('Should return [false] if [both values in secondGenFemaleIVList[0] == 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][0][0] = 0
    //     ..secondGenIVList[0][0][1] = 0;
    //
    //   bool actualButtonState = actualSecondGenCubit.isRestartButtonEnabled(SecondGenIndex.pairZero);
    //
    //   bool expectedButtonsState = false;
    //   expect(actualButtonState, expectedButtonsState);
    // });
    //
    // test('Should return [true] if [both values in secondGenMaleIVList > 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][1][0] = 1
    //     ..secondGenIVList[0][1][1] = 2;
    //
    //   bool actualButtonState = actualSecondGenCubit.isMaleRestartButtonEnabled(SecondGenIndex.pairZero);
    //
    //   bool expectedButtonsState = true;
    //   expect(actualButtonState, expectedButtonsState);
    // });
    //
    // test('Should return [true] if [only secondGenMaleIVList[1] > 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][1][0] = 0
    //     ..secondGenIVList[0][1][1] = 2;
    //
    //   bool actualButtonState = actualSecondGenCubit.isMaleRestartButtonEnabled(SecondGenIndex.pairZero);
    //
    //   bool expectedButtonsState = true;
    //   expect(actualButtonState, expectedButtonsState);
    // });
    //
    // test('Should return [true] if [only secondGenMaleIVList[0] > 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][1][0] = 1
    //     ..secondGenIVList[0][1][1] = 0;
    //
    //   bool actualButtonState = actualSecondGenCubit.isMaleRestartButtonEnabled(SecondGenIndex.pairZero);
    //
    //   bool expectedButtonsState = true;
    //   expect(actualButtonState, expectedButtonsState);
    // });
    //
    // test('Should return [false] if [both values in secondGenMaleIVList == 0]', () {
    //   actualSecondGenCubit.secondGenModel = secondGenModel
    //     ..secondGenIVList[0][1][0] = 0
    //     ..secondGenIVList[0][1][1] = 0;
    //
    //   bool actualButtonState = actualSecondGenCubit.isMaleRestartButtonEnabled(SecondGenIndex.pairZero);
    //
    //   bool expectedButtonsState = false;
    //   expect(actualButtonState, expectedButtonsState);
    // });
  });
}
