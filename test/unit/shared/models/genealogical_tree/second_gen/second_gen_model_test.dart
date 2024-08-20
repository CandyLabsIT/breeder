import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final SecondGenModel secondGenModel = SecondGenModel();

  Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
    for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
  };
  Map<SecondGenIndex, List<IVColor>> actualSecondGenMap = secondGenModel.secondGenMap;

  group('Tests of SecondGenModel.updateMapValues()', () {
    test('Should return [all default values]', () {
      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [defaultColor and non defaultColor] if [both values == defaultColor in primary list and value ]', () {
      IVColor actualIVColor = IVColor.atkColor;
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.updateMapValues(actualSecondGenIndex, actualIVColor);
      expectedSecondGenMap[SecondGenIndex.one]![0] = IVColor.atkColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [non defaultColors] if [first value is non defaultColor and second defaultColor]', () {
      IVColor actualIVColor = IVColor.defColor;
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.updateMapValues(actualSecondGenIndex, actualIVColor);

      expectedSecondGenMap[SecondGenIndex.one]![0] = IVColor.atkColor;
      expectedSecondGenMap[SecondGenIndex.one]![1] = IVColor.defColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [no changed map] if [list if filled] and if [list in map not contain IVColor]', () {
      IVColor actualIVColor = IVColor.spAtkColor;
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.updateMapValues(actualSecondGenIndex, actualIVColor);
      expectedSecondGenMap[SecondGenIndex.one]![0] = IVColor.atkColor;
      expectedSecondGenMap[SecondGenIndex.one]![1] = IVColor.defColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [default IVColor and non default IVColor] if [list if filled] and if [list in map contain IVColor]', () {
      IVColor actualIVColor = IVColor.atkColor;
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.updateMapValues(actualSecondGenIndex, actualIVColor);
      expectedSecondGenMap[SecondGenIndex.one]![0] = IVColor.defaultColor;
      expectedSecondGenMap[SecondGenIndex.one]![1] = IVColor.defColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [default IVColor] if [list if filled with one IVColor] and if [list in map contain IVColor]', () {
      IVColor actualIVColor = IVColor.defColor;
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.updateMapValues(actualSecondGenIndex, actualIVColor);
      expectedSecondGenMap[SecondGenIndex.one]![0] = IVColor.defaultColor;
      expectedSecondGenMap[SecondGenIndex.one]![1] = IVColor.defaultColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });
  });
  group('Tests of SecondGenModel.resetIVListValues()', () {
    test('Should return [all default values] if [list contains only non defaultColors]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![0] = IVColor.defColor;
      actualSecondGenMap[actualSecondGenIndex]![1] = IVColor.spAtkColor;
      secondGenModel.resetIVListValues(actualSecondGenIndex);

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [all default values] if [only first element of list is non defaultColor]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![0] = IVColor.defColor;
      secondGenModel.resetIVListValues(actualSecondGenIndex);

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [all default values] if [only second element of list is non defaultColor]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![1] = IVColor.defColor;
      secondGenModel.resetIVListValues(actualSecondGenIndex);

      expect(actualSecondGenMap, expectedSecondGenMap);
    });
  });

  group('Tests of SecondGenModel.resetAll()', () {
    test('Should return [all default values] if [list contains only non defaultColors]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![0] = IVColor.defColor;
      actualSecondGenMap[actualSecondGenIndex]![1] = IVColor.spAtkColor;
      secondGenModel.resetAll();

      actualSecondGenMap = secondGenModel.secondGenMap;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [all default values] if [only first element of list is non defaultColor]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![0] = IVColor.defColor;
      secondGenModel.resetAll();

      actualSecondGenMap = secondGenModel.secondGenMap;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [all default values] if [only second element of list is non defaultColor]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![1] = IVColor.defColor;
      secondGenModel.resetAll();

      actualSecondGenMap = secondGenModel.secondGenMap;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });
  });

  group('Tests of SecondGenModel.isIVListFilled()', () {
    test('Should return [false] if [list contains only defaultColor]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      bool actualBool = secondGenModel.isIVListFilled(actualSecondGenIndex);
      bool expectedBool = false;

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if [list contains one defaultColor]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;
      secondGenModel.secondGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;

      bool actualBool = secondGenModel.isIVListFilled(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if [list not contains defaultColor]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;
      secondGenModel.secondGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.secondGenMap[actualSecondGenIndex]![1] = IVColor.atkColor;

      bool actualBool = secondGenModel.isIVListFilled(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });
  });

  group('Tests of SecondGenModel.hasCommonValue()', () {
    test('Should return [false] if [first list not contain value from second list, second list is default]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.secondGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.secondGenMap[actualSecondGenIndex]![1] = IVColor.atkColor;

      bool actualBool = secondGenModel.hasCommonValue(actualSecondGenIndex);
      bool expectedBool = false;

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if [first list contain value from second list, second list is not default]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.secondGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.secondGenMap[actualSecondGenIndex]![1] = IVColor.atkColor;

      secondGenModel.secondGenMap[SecondGenIndex.two]![0] = IVColor.spAtkColor;

      bool actualBool = secondGenModel.hasCommonValue(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if [first list contains only one non default value and value is in second list, second list is not default]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.secondGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.secondGenMap[actualSecondGenIndex]![1] = IVColor.defaultColor;

      secondGenModel.secondGenMap[SecondGenIndex.two]![0] = IVColor.spAtkColor;

      bool actualBool = secondGenModel.hasCommonValue(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });

    test('Should return [false] if [first list contains only one non default value and value is in second list, second list is not default]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.secondGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.secondGenMap[actualSecondGenIndex]![1] = IVColor.defaultColor;

      secondGenModel.secondGenMap[SecondGenIndex.two]![0] = IVColor.spAtkColor;

      bool actualBool = secondGenModel.hasCommonValue(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });
  });
  group('Tests of SecondGenModel.getFemaleIndex()', () {
    test('Should return [secondGenIndex] if [secondGenIndex is female index]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      SecondGenIndex actualFemaleIndex = secondGenModel.getFemaleIndex(actualSecondGenIndex);
      SecondGenIndex expectedFemaleIndex = SecondGenIndex.one;

      expect(actualFemaleIndex, expectedFemaleIndex);
    });

    test('Should return [secondGenIndex - 1] if [secondGenIndex is male index]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.two;

      SecondGenIndex actualFemaleIndex = secondGenModel.getFemaleIndex(actualSecondGenIndex);
      SecondGenIndex expectedFemaleIndex = SecondGenIndex.one;

      expect(actualFemaleIndex, expectedFemaleIndex);
    });
  });
  group('Tests of SecondGenModel.getMaleIndex()', () {
    test('Should return [secondGenIndex] if [secondGenIndex is male index]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.two;

      SecondGenIndex actualMaleIndex = secondGenModel.getMaleIndex(actualSecondGenIndex);
      SecondGenIndex expectedMaleIndex = SecondGenIndex.two;

      expect(actualMaleIndex, expectedMaleIndex);
    });

    test('Should return [secondGenIndex - 1] if [secondGenIndex is female index]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      SecondGenIndex actualMaleIndex = secondGenModel.getMaleIndex(actualSecondGenIndex);
      SecondGenIndex expectedMaleIndex = SecondGenIndex.two;

      expect(actualMaleIndex, expectedMaleIndex);
    });
  });
}
