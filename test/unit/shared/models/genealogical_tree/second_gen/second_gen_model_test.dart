import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final SecondGenModel secondGenModel = SecondGenModel();

  Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
    for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
  };
  Map<SecondGenIndex, List<IVColor>> actualSecondGenMap = secondGenModel.secondGenMap;

  group('Tests of SecondGenModel.updateValues()', () {
    test('Should return [defaultColor and IV value] if [activeList both values are defaultColors and actualIVColor is IV value]', () {
      IVColor actualIVColor = IVColor.atkColor;
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.updateIVColor(actualSecondGenIndex, actualIVColor);
      expectedSecondGenMap[SecondGenIndex.one]![0] = IVColor.atkColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [only IV values in activeList] if [activeList first element is IV value and second is defaultColor and actualIVColor is IV value]', () {
      IVColor actualIVColor = IVColor.defColor;
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.updateIVColor(actualSecondGenIndex, actualIVColor);

      expectedSecondGenMap[SecondGenIndex.one]![0] = IVColor.atkColor;
      expectedSecondGenMap[SecondGenIndex.one]![1] = IVColor.defColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [not changed map] if [activeList is filled with IV value] and if [activeList not contain actualIVColor]', () {
      IVColor actualIVColor = IVColor.spAtkColor;
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.updateIVColor(actualSecondGenIndex, actualIVColor);
      expectedSecondGenMap[SecondGenIndex.one]![0] = IVColor.atkColor;
      expectedSecondGenMap[SecondGenIndex.one]![1] = IVColor.defColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [defaultColor and IV value in activeList] if [activeList is filled] and if [activeList contain actualIVColor]', () {
      IVColor actualIVColor = IVColor.atkColor;
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.updateIVColor(actualSecondGenIndex, actualIVColor);
      expectedSecondGenMap[SecondGenIndex.one]![0] = IVColor.defaultColor;
      expectedSecondGenMap[SecondGenIndex.one]![1] = IVColor.defColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [defaultColor] if [activeList is filled with one IV value] and if [activeList contain actualIVColor]', () {
      IVColor actualIVColor = IVColor.defColor;
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      secondGenModel.updateIVColor(actualSecondGenIndex, actualIVColor);
      expectedSecondGenMap[SecondGenIndex.one]![0] = IVColor.defaultColor;
      expectedSecondGenMap[SecondGenIndex.one]![1] = IVColor.defaultColor;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });
  });
  group('Tests of SecondGenModel.resetIVLisToDefaultIVColors()', () {
    test('Should return [all defaultColors in activeList] if [activeList contains only IV values]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![0] = IVColor.defColor;
      actualSecondGenMap[actualSecondGenIndex]![1] = IVColor.spAtkColor;
      secondGenModel.resetMonsterToDefaultIVColors(actualSecondGenIndex);

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [all defaultColors in activeList] if [only first element of activeList is IV value]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![0] = IVColor.defColor;
      secondGenModel.resetMonsterToDefaultIVColors(actualSecondGenIndex);

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [all defaultColors in activeList] if [only second IVColor in activeList is IV value]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![1] = IVColor.defColor;
      secondGenModel.resetMonsterToDefaultIVColors(actualSecondGenIndex);

      expect(actualSecondGenMap, expectedSecondGenMap);
    });
  });

  group('Tests of SecondGenModel.resetAll()', () {
    test('Should return [all defaultColors in activeList] if [activeList contains only IV value]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![0] = IVColor.defColor;
      actualSecondGenMap[actualSecondGenIndex]![1] = IVColor.spAtkColor;
      secondGenModel.resetAll();

      actualSecondGenMap = secondGenModel.secondGenMap;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [all defaultColors in activeList] if [only first IVColor of activeList is IV value]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![0] = IVColor.defColor;
      secondGenModel.resetAll();

      actualSecondGenMap = secondGenModel.secondGenMap;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });

    test('Should return [all defaultColors in activeList] if [only second IVColors of activeList is IV value]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      actualSecondGenMap[actualSecondGenIndex]![1] = IVColor.defColor;
      secondGenModel.resetAll();

      actualSecondGenMap = secondGenModel.secondGenMap;

      expect(actualSecondGenMap, expectedSecondGenMap);
    });
  });

  group('Tests of SecondGenModel.hasIVValue()', () {
    test('Should return [false] if [activeList contains only defaultColor]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      bool actualBool = secondGenModel.hasIVValue(actualSecondGenIndex);
      bool expectedBool = false;

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if [activeList contains one defaultColor]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;
      secondGenModel.secondGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;

      bool actualBool = secondGenModel.hasIVValue(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if [activeList do not contain defaultColor]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;
      secondGenModel.secondGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.secondGenMap[actualSecondGenIndex]![1] = IVColor.atkColor;

      bool actualBool = secondGenModel.hasIVValue(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });
  });

  group('Tests of SecondGenModel.hasCommonIVColor()', () {
    test('Should return [false] if [activeList has IV values and pairedList has defaultColors]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;
      SecondGenIndex pairedSecondGenIndex = SecondGenIndex.two;
      

      secondGenModel.secondGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.secondGenMap[actualSecondGenIndex]![1] = IVColor.atkColor;

      secondGenModel.secondGenMap[pairedSecondGenIndex]![0] = IVColor.defaultColor;
      secondGenModel.secondGenMap[pairedSecondGenIndex]![1] = IVColor.defaultColor;
      

      bool actualBool = secondGenModel.hasCommonIVColor(actualSecondGenIndex);
      bool expectedBool = false;

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if [activeList has IVColor from pairedList, pairedList has IV value]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;
      SecondGenIndex pairedSecondGenIndex = SecondGenIndex.two;
      

      secondGenModel.secondGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.secondGenMap[actualSecondGenIndex]![1] = IVColor.atkColor;

      secondGenModel.secondGenMap[pairedSecondGenIndex]![0] = IVColor.spAtkColor;

      bool actualBool = secondGenModel.hasCommonIVColor(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if [activeList has only one non defaultColor and IVColor is in pairedList, pairedList has IV value]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;
      SecondGenIndex pairedSecondGenIndex = SecondGenIndex.two;
      

      secondGenModel.secondGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.secondGenMap[actualSecondGenIndex]![1] = IVColor.defaultColor;

      secondGenModel.secondGenMap[pairedSecondGenIndex]![0] = IVColor.spAtkColor;

      bool actualBool = secondGenModel.hasCommonIVColor(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });

    test('Should return [false] if [activeList contains only one IV value and IVColor is in pairedList, second list has IV value]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;
      SecondGenIndex pairedSecondGenIndex = SecondGenIndex.two;
      

      secondGenModel.secondGenMap[actualSecondGenIndex]![0] = IVColor.spAtkColor;
      secondGenModel.secondGenMap[actualSecondGenIndex]![1] = IVColor.defaultColor;

      secondGenModel.secondGenMap[pairedSecondGenIndex]![0] = IVColor.spAtkColor;

      bool actualBool = secondGenModel.hasCommonIVColor(actualSecondGenIndex);
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });
  });
  group('Tests of SecondGenModel.getFemaleIndex()', () {
    test('Should return [secondGenIndex] if [secondGenIndex is femaleIndex]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      SecondGenIndex actualFemaleIndex = secondGenModel.getFemaleIndex(actualSecondGenIndex);
      SecondGenIndex expectedFemaleIndex = SecondGenIndex.one;

      expect(actualFemaleIndex, expectedFemaleIndex);
    });

    test('Should return [secondGenIndex - 1] if [secondGenIndex is femaleIndex]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.two;

      SecondGenIndex actualFemaleIndex = secondGenModel.getFemaleIndex(actualSecondGenIndex);
      SecondGenIndex expectedFemaleIndex = SecondGenIndex.one;

      expect(actualFemaleIndex, expectedFemaleIndex);
    });
  });
  group('Tests of SecondGenModel.getMaleIndex()', () {
    test('Should return [secondGenIndex] if [secondGenIndex is femaleIndex]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.two;

      SecondGenIndex actualMaleIndex = secondGenModel.getMaleIndex(actualSecondGenIndex);
      SecondGenIndex expectedMaleIndex = SecondGenIndex.two;

      expect(actualMaleIndex, expectedMaleIndex);
    });

    test('Should return [secondGenIndex - 1] if [secondGenIndex is femaleIndex]', () {
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.one;

      SecondGenIndex actualMaleIndex = secondGenModel.getMaleIndex(actualSecondGenIndex);
      SecondGenIndex expectedMaleIndex = SecondGenIndex.two;

      expect(actualMaleIndex, expectedMaleIndex);
    });
  });
}
