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

    List<IVColor> primaryIVColorList = <IVColor>[];
    List<IVColor> secondaryIVColorList = <IVColor>[];

    SecondGenModel secondGenModel = SecondGenModel();

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
          primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.defaultColor];
        } else {
          primaryIVColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
        }
        expectedSecondGenMap[index] = primaryIVColorList;
      }

      ASecondGenState expectedSecondGenState = SecondGenColorsChangedState(secondGenMap: expectedSecondGenMap);

      actualSecondGenCubit.setColors(SecondGenIndex.one, IVColor.defColor);

      expect(actualSecondGenCubit.state, expectedSecondGenState);
    });

    test('Should return [SecondGenColorsChangedState] if [all values are reset]', () {
      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
        for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
      };

      ASecondGenState expectedSecondGenState = SecondGenColorsChangedState(secondGenMap: expectedSecondGenMap);

      actualSecondGenCubit.resetAllToDefaultColors();

      expect(actualSecondGenCubit.state, expectedSecondGenState);
    });

    test('Should return [SecondGenListColorsDefaultState] if [SecondGenMap is not none]', () {
      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
        for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
      };

      ASecondGenState expectedSecondGenState = SecondGenIVListDefaultState(secondGenMap: expectedSecondGenMap);

      primaryIVColorList = <IVColor>[IVColor.atkColor, IVColor.spAtkColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.six] = primaryIVColorList;

      actualSecondGenCubit.resetIVListToDefaultColors(SecondGenIndex.six);

      expect(actualSecondGenCubit.state, expectedSecondGenState);
    });

    test('Should return [SecondGenMap] if [SecondGenColorsChangedState is emitted and ivColor changed]', () {
      actualSecondGenCubit.secondGenModel = secondGenModel;
      actualSecondGenCubit.resetAllToDefaultColors();

      actualSecondGenCubit.setColors(SecondGenIndex.one, IVColor.atkColor);

      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{};

      for (SecondGenIndex index in SecondGenIndex.values) {
        if (index == SecondGenIndex.one) {
          primaryIVColorList = <IVColor>[IVColor.atkColor, IVColor.defaultColor];
        } else {
          primaryIVColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
        }
        expectedSecondGenMap[index] = primaryIVColorList;
      }

      expect(actualSecondGenCubit.getColors(), expectedSecondGenMap);
    });

    test('Should return [SecondGenMap] if [SecondGenColorsChangedState is emitted and all values are reset]', () {
      actualSecondGenCubit.secondGenModel = secondGenModel;

      actualSecondGenCubit.secondGenModel = secondGenModel;
      actualSecondGenCubit.resetAllToDefaultColors();

      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
        for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
      };

      expect(actualSecondGenCubit.getColors(), expectedSecondGenMap);
    });

    test('Should return [SecondGenMap] if [SecondGenListColorsDefaultState is emitted]', () {
      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
        for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
      };

      primaryIVColorList = <IVColor>[IVColor.atkColor, IVColor.spAtkColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.six] = primaryIVColorList;

      actualSecondGenCubit.resetIVListToDefaultColors(SecondGenIndex.six);

      expect(actualSecondGenCubit.getColors(), expectedSecondGenMap);
    });

    test('Should return [SecondGenMap] if [buttons are checked]', () {
      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
        for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
      };

      actualSecondGenCubit.isRestartButtonEnabled(SecondGenIndex.one);

      expect(actualSecondGenCubit.getColors(), expectedSecondGenMap);
    });

    test('Should return [map with all true values] if [both values are defaultColor and in second list both values are defaultColor]', () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values) ivColor: true,
      };

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test('Should return [map with all true values] if [one value is defaultColor and in second list both values are defaultColor]', () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values) ivColor: true,
      };

      primaryIVColorList = <IVColor>[IVColor.atkColor, IVColor.defaultColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test('Should return [three true values] if [both values are not defaultColor  and in second list both values are defaultColor]', () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{};
      primaryIVColorList = <IVColor>[IVColor.atkColor, IVColor.spAtkColor];

      for (IVColor ivColor in IVColor.values) {
        if (primaryIVColorList.contains(ivColor)) {
          expectedIVColorMap[ivColor] = true;
        } else {
          expectedIVColorMap[ivColor] = false;
        }
      }
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test(
        'Should return [four true values] if  [one value is defaultColor and in second list both values are not defaultColor and second list does not contain value from first list]',
        () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{};
      primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.defaultColor];
      secondaryIVColorList = <IVColor>[IVColor.atkColor, IVColor.spAtkColor];

      for (IVColor ivColor in IVColor.values) {
        if (primaryIVColorList.contains(ivColor) || secondaryIVColorList.contains(ivColor)) {
          expectedIVColorMap[ivColor] = true;
        } else {
          expectedIVColorMap[ivColor] = false;
        }
      }

      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.two] = secondaryIVColorList;

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test(
        'Should return  [one false value] if  [one value is defaultColor and in second list both values are not defaultColor and primary and second list contains one the same value]',
        () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{};
      primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.defaultColor];
      secondaryIVColorList = <IVColor>[IVColor.defColor, IVColor.spAtkColor];

      for (IVColor ivColor in IVColor.values) {
        if (ivColor == IVColor.spAtkColor) {
          expectedIVColorMap[ivColor] = false;
        } else {
          expectedIVColorMap[ivColor] = true;
        }
      }

      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.two] = secondaryIVColorList;

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test('Should return [all true values] if [one value in primary and second list is defaultColor, no value is repeated in both lists]', () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values) ivColor: true,
      };
      primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.defaultColor];
      secondaryIVColorList = <IVColor>[IVColor.defaultColor, IVColor.spAtkColor];

      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.two] = secondaryIVColorList;

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test('Should return [false] if [both values are defaultColor]', () {
      bool expectedRestartButtonState = false;

      primaryIVColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      bool actualRestartButtonState = actualSecondGenCubit.isRestartButtonEnabled(SecondGenIndex.one);

      expect(actualRestartButtonState, expectedRestartButtonState);
    });

    test('Should return [true] if [one values are defaultColor]', () {
      bool expectedRestartButtonState = true;
      primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.defaultColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      bool actualRestartButtonState = actualSecondGenCubit.isRestartButtonEnabled(SecondGenIndex.one);

      expect(actualRestartButtonState, expectedRestartButtonState);
    });

    test('Should return [true] if [both values are not defaultColor]', () {
      bool expectedRestartButtonState = true;
      primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.spAtkColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      bool actualRestartButtonState = actualSecondGenCubit.isRestartButtonEnabled(SecondGenIndex.one);

      expect(actualRestartButtonState, expectedRestartButtonState);
    });
  });
}
