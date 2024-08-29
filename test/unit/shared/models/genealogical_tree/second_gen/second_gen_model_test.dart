import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/first_gen_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final FirstGenModel secondGenModel = FirstGenModel();

  Map<FirstGenIndex, List<IVColor>> expectedSecondGenMap = <FirstGenIndex, List<IVColor>>{
    for (FirstGenIndex index in FirstGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
  };
  Map<FirstGenIndex, List<IVColor>> actualSecondGenMap = secondGenModel.firstGenMap;

  group('Tests of SecondGenModel.updateValues()', () {
    test('Should return [defaultColor and IV value] if [activeList both values are defaultColors and actualIVColor is IV value]', () {
      IVColor actualIVColor = IVColor.atkColor;
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      secondGenModel.updateIVColor(actualSecondGenIndex, actualIVColor);
      expectedSecondGenMap[FirstGenIndex.one]![0] = IVColor.atkColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test(
        'Should return [only IV values in activeList] if [activeList first element is IV value and second is defaultColor and actualIVColor is IV value]',
        () {
      IVColor actualIVColor = IVColor.defColor;
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      secondGenModel.updateIVColor(actualSecondGenIndex, actualIVColor);

      expectedSecondGenMap[FirstGenIndex.one]![0] = IVColor.atkColor;
      expectedSecondGenMap[FirstGenIndex.one]![1] = IVColor.defColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [not changed map] if [activeList is filled with IV value] and if [activeList not contain actualIVColor]', () {
      IVColor actualIVColor = IVColor.spAtkColor;
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      secondGenModel.updateIVColor(actualSecondGenIndex, actualIVColor);
      expectedSecondGenMap[FirstGenIndex.one]![0] = IVColor.atkColor;
      expectedSecondGenMap[FirstGenIndex.one]![1] = IVColor.defColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [defaultColor and IV value in activeList] if [activeList is filled] and if [activeList contain actualIVColor]', () {
      IVColor actualIVColor = IVColor.atkColor;
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      secondGenModel.updateIVColor(actualSecondGenIndex, actualIVColor);
      expectedSecondGenMap[FirstGenIndex.one]![0] = IVColor.defaultColor;
      expectedSecondGenMap[FirstGenIndex.one]![1] = IVColor.defColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [defaultColor] if [activeList is filled with one IV value] and if [activeList contain actualIVColor]', () {
      IVColor actualIVColor = IVColor.defColor;
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      secondGenModel.updateIVColor(actualSecondGenIndex, actualIVColor);
      expectedSecondGenMap[FirstGenIndex.one]![0] = IVColor.defaultColor;
      expectedSecondGenMap[FirstGenIndex.one]![1] = IVColor.defaultColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });
  });
  group('Tests of SecondGenModel.resetIVLisToDefaultIVColors()', () {
    test('Should return [all defaultColors in activeList] if [activeList contains only IV values]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![0] = IVColor.defColor;
      actualSecondGenMap[actualSecondGenIndex]![1] = IVColor.spAtkColor;
      secondGenModel.resetMonsterToDefaultIVColors(actualSecondGenIndex);

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [all defaultColors in activeList] if [only first element of activeList is IV value]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![0] = IVColor.defColor;
      secondGenModel.resetMonsterToDefaultIVColors(actualSecondGenIndex);

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [all defaultColors in activeList] if [only second IVColor in activeList is IV value]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![1] = IVColor.defColor;
      secondGenModel.resetMonsterToDefaultIVColors(actualSecondGenIndex);

      expect(actualSecondGenMap, expectedSecondGenMap);
    });
  });

  group('Tests of SecondGenModel.resetAll()', () {
    test('Should return [all defaultColors in activeList] if [activeList contains only IV value]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![0] = IVColor.defColor;
      actualSecondGenMap[actualSecondGenIndex]![1] = IVColor.spAtkColor;
      secondGenModel.resetAll();

      actualSecondGenMap = secondGenModel.firstGenMap;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [all defaultColors in activeList] if [only first IVColor of activeList is IV value]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![0] = IVColor.defColor;
      secondGenModel.resetAll();

      actualSecondGenMap = secondGenModel.firstGenMap;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [all defaultColors in activeList] if [only second IVColors of activeList is IV value]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![1] = IVColor.defColor;
      secondGenModel.resetAll();

      actualSecondGenMap = secondGenModel.firstGenMap;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });
  });

  group('Tests of SecondGenModel.hasIVValue()', () {
    test('Should return [false] if [activeList contains only defaultColor]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      bool actualBool = secondGenModel.hasIVValue(actualSecondGenIndex);
      bool expectedBool = false;

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if [activeList contains one defaultColor]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;
      secondGenModel.firstGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;

      bool actualBool = secondGenModel.hasIVValue(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if [activeList do not contain defaultColor]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;
      secondGenModel.firstGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.firstGenMap[actualSecondGenIndex]![1] = IVColor.atkColor;

      bool actualBool = secondGenModel.hasIVValue(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });
  });

  group('Tests of SecondGenModel.hasCommonIVColor()', () {
    test('Should return [false] if [activeList has IV values and pairedList has defaultColors]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;
      FirstGenIndex pairedSecondGenIndex = FirstGenIndex.two;

      secondGenModel.firstGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.firstGenMap[actualSecondGenIndex]![1] = IVColor.atkColor;

      secondGenModel.firstGenMap[pairedSecondGenIndex]![0] = IVColor.defaultColor;
      secondGenModel.firstGenMap[pairedSecondGenIndex]![1] = IVColor.defaultColor;

      bool actualBool = secondGenModel.hasCommonIVColor(actualSecondGenIndex);
      bool expectedBool = false;

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if [activeList has IVColor from pairedList, pairedList has IV value]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;
      FirstGenIndex pairedSecondGenIndex = FirstGenIndex.two;

      secondGenModel.firstGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.firstGenMap[actualSecondGenIndex]![1] = IVColor.atkColor;

      secondGenModel.firstGenMap[pairedSecondGenIndex]![0] = IVColor.spAtkColor;

      bool actualBool = secondGenModel.hasCommonIVColor(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if [activeList has only one non defaultColor and IVColor is in pairedList, pairedList has IV value]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;
      FirstGenIndex pairedSecondGenIndex = FirstGenIndex.two;

      secondGenModel.firstGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.firstGenMap[actualSecondGenIndex]![1] = IVColor.defaultColor;

      secondGenModel.firstGenMap[pairedSecondGenIndex]![0] = IVColor.spAtkColor;

      bool actualBool = secondGenModel.hasCommonIVColor(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });

    test('Should return [false] if [activeList contains only one IV value and IVColor is in pairedList, second list has IV value]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;
      FirstGenIndex pairedSecondGenIndex = FirstGenIndex.two;

      secondGenModel.firstGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.firstGenMap[actualSecondGenIndex]![1] = IVColor.defaultColor;

      secondGenModel.firstGenMap[pairedSecondGenIndex]![0] = IVColor.spAtkColor;

      bool actualBool = secondGenModel.hasCommonIVColor(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });
  });
  group('Tests of SecondGenModel.getFemaleIndex()', () {
    test('Should return [secondGenIndex] if [secondGenIndex is femaleIndex]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      FirstGenIndex actualFemaleIndex = secondGenModel.getFemaleIndex(actualSecondGenIndex);
      FirstGenIndex expectedFemaleIndex = FirstGenIndex.one;

      expect(actualFemaleIndex, expectedFemaleIndex);
    });

    test('Should return [secondGenIndex - 1] if [secondGenIndex is femaleIndex]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.two;

      FirstGenIndex actualFemaleIndex = secondGenModel.getFemaleIndex(actualSecondGenIndex);
      FirstGenIndex expectedFemaleIndex = FirstGenIndex.one;

      expect(actualFemaleIndex, expectedFemaleIndex);
    });
  });
  group('Tests of SecondGenModel.getMaleIndex()', () {
    test('Should return [secondGenIndex] if [secondGenIndex is femaleIndex]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.two;

      FirstGenIndex actualMaleIndex = secondGenModel.getMaleIndex(actualSecondGenIndex);
      FirstGenIndex expectedMaleIndex = FirstGenIndex.two;

      expect(actualMaleIndex, expectedMaleIndex);
    });

    test('Should return [secondGenIndex - 1] if [secondGenIndex is femaleIndex]', () {
      FirstGenIndex actualSecondGenIndex = FirstGenIndex.one;

      FirstGenIndex actualMaleIndex = secondGenModel.getMaleIndex(actualSecondGenIndex);
      FirstGenIndex expectedMaleIndex = FirstGenIndex.two;

      expect(actualMaleIndex, expectedMaleIndex);
    });
  });
}
