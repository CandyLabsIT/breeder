import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_colors_default_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/states/second_gen_init_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
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

    test('Should emit [SecondGenColorsChangedState] if [SecondGenMap changed]', () {
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

    test('Should return [SecondGenColorsChangedState] if [whole generation is reset to default IVColors]', () {
      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
        for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
      };

      ASecondGenState expectedSecondGenState = SecondGenColorsChangedState(secondGenMap: expectedSecondGenMap);

      actualSecondGenCubit.resetGenToDefaultColors();

      expect(actualSecondGenCubit.state, expectedSecondGenState);
    });

    test('Should return [SecondGenListColorsDefaultState] if [SecondGenMap has no-default value]', () {
      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
        for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
      };

      ASecondGenState expectedSecondGenState = SecondGenMonsterDefaultState(secondGenMap: expectedSecondGenMap);

      primaryIVColorList = <IVColor>[IVColor.atkColor, IVColor.spAtkColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.six] = primaryIVColorList;

      actualSecondGenCubit.resetMonsterToDefaultColors(SecondGenIndex.six);

      expect(actualSecondGenCubit.state, expectedSecondGenState);
    });

    test('Should return [SecondGenMap] if [SecondGenColorsChangedState is emitted and ivColor changed]', () {
      actualSecondGenCubit.secondGenModel = secondGenModel;
      actualSecondGenCubit.resetGenToDefaultColors();

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

    test('Should return [SecondGenMap] if [SecondGenColorsChangedState is emitted and whole gen is reset]', () {
      actualSecondGenCubit.secondGenModel = secondGenModel;

      actualSecondGenCubit.secondGenModel = secondGenModel;
      actualSecondGenCubit.resetGenToDefaultColors();

      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
        for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
      };

      expect(actualSecondGenCubit.getColors(), expectedSecondGenMap);
    });

    test('Should return [SecondGenMap] if [resetMonsterToDefaultColors is emitted]', () {
      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
        for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
      };

      primaryIVColorList = <IVColor>[IVColor.atkColor, IVColor.spAtkColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.six] = primaryIVColorList;

      actualSecondGenCubit.resetMonsterToDefaultColors(SecondGenIndex.six);

      expect(actualSecondGenCubit.getColors(), expectedSecondGenMap);
    });

    test('Should return [map with all true values] if [both IVColors are defaultColor in activeList and in pairedList both IVColors are default IVColor]', () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values)
          if (ivColor != IVColor.defaultColor) ivColor: true
      };

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getIVButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test('Should return [map with all true values] if [one IVColors is defaultColor in activeList and in pairedList both values are default IVColors]', () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values)
          if (ivColor != IVColor.defaultColor) ivColor: true
      };

      primaryIVColorList = <IVColor>[IVColor.atkColor, IVColor.defaultColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getIVButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test('Should return [map with two true values - for IVColors from activeList] if [both IVColors are non-default IVColor in activeList and in pairedList both values are default IVColors]', () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{};
      primaryIVColorList = <IVColor>[IVColor.atkColor, IVColor.spAtkColor];

      for (IVColor ivColor in IVColor.values) {
        if (ivColor == IVColor.defaultColor){
          continue;
        }
        else if (primaryIVColorList.contains(ivColor)) {
          expectedIVColorMap[ivColor] = true;
        } else {
          expectedIVColorMap[ivColor] = false;
        }
      }
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getIVButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test(
        'Should return [map with tree true values - IVColor from activeList and IVColors from pairedList] if  [one IVColor is default IVColor in activeList, both values in pairedList are non-default IVColors and pairedList has no common IVColor with activeList]',
        () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{};
      primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.defaultColor];
      secondaryIVColorList = <IVColor>[IVColor.atkColor, IVColor.spAtkColor];

      for (IVColor ivColor in IVColor.values) {
        if (ivColor == IVColor.defaultColor){
          continue;
        }
        else if (primaryIVColorList.contains(ivColor) || secondaryIVColorList.contains(ivColor)) {
          expectedIVColorMap[ivColor] = true;
        } else {
          expectedIVColorMap[ivColor] = false;
        }
      }

      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.two] = secondaryIVColorList;

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getIVButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test(
        'Should return  [map with one false value - for non-common value from pairedList] if  [one IVColor is default IVColor in activeList, both IVColors in pairedList are non-default IVColorS, pairedList has common IVColor with activeList]',
        () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{};
      primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.defaultColor];
      secondaryIVColorList = <IVColor>[IVColor.defColor, IVColor.spAtkColor];

      for (IVColor ivColor in IVColor.values) {
        if (ivColor == IVColor.defaultColor){
          continue;
        }
        else if (ivColor == IVColor.spAtkColor) {
          expectedIVColorMap[ivColor] = false;
        } else {
          expectedIVColorMap[ivColor] = true;
        }
      }

      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.two] = secondaryIVColorList;

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getIVButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test('Should return [map with all true values] if [one IVColor in activeList and in pairedList is one non-default IVColor, no value is repeated in both lists]', () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values)
        if (ivColor != IVColor.defaultColor) ivColor: true
      };
      primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.defaultColor];
      secondaryIVColorList = <IVColor>[IVColor.defaultColor, IVColor.spAtkColor];

      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.two] = secondaryIVColorList;

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getIVButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test('Should return [map with all true values] if [one IVColor in activeList and in pairedList is one non-default IVColor, and the value is common in both lists]', () {
      Map<IVColor, bool> expectedIVColorMap = <IVColor, bool>{
        for (IVColor ivColor in IVColor.values)
          if (ivColor != IVColor.defaultColor) ivColor: true
      };
      primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.defaultColor];
      secondaryIVColorList = <IVColor>[IVColor.defaultColor, IVColor.spAtkColor];

      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.two] = secondaryIVColorList;

      Map<IVColor, bool> actualIVColorMap = actualSecondGenCubit.getIVButtonsState(SecondGenIndex.one);

      expect(actualIVColorMap, expectedIVColorMap);
    });

    test('Should return [false] if [both IVColors in activeList are default IVColor]', () {
      bool expectedRestartButtonState = false;

      primaryIVColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      bool actualRestartButtonState = actualSecondGenCubit.isRestartButtonEnabled(SecondGenIndex.one);

      expect(actualRestartButtonState, expectedRestartButtonState);
    });

    test('Should return [true] if [one IVColor in activeList is default IVColor]', () {
      bool expectedRestartButtonState = true;
      primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.defaultColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      bool actualRestartButtonState = actualSecondGenCubit.isRestartButtonEnabled(SecondGenIndex.one);

      expect(actualRestartButtonState, expectedRestartButtonState);
    });

    test('Should return [true] if [both IVColors in activeList are non-default IVColor]', () {
      bool expectedRestartButtonState = true;
      primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.spAtkColor];
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      bool actualRestartButtonState = actualSecondGenCubit.isRestartButtonEnabled(SecondGenIndex.one);

      expect(actualRestartButtonState, expectedRestartButtonState);
    });
  });
}
