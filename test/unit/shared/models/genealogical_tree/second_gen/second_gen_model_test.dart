import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final SecondGenModel secondGenModel = SecondGenModel();

  group('Tests of SecondGenModel.updateValues()', () {
    test('Should return [0, 0] if [both values in secondGenFemaleIVList == 0 and value is equal 0]', () {
      int actualValue = 0;
      secondGenModel
        ..secondGenFemaleIVList[0] = 0
        ..secondGenFemaleIVList[1] = 0
        ..updateValues(secondGenModel.secondGenFemaleIVList, actualValue);

      List<int> actualColorsList = secondGenModel.secondGenFemaleIVList;

      List<int> expectedList = <int>[0, 0];

      expect(actualColorsList, expectedList);
    });

    test('Should return [0, value] if [both values in secondGenFemaleIVList == 0 and value is > 0]', () {
      int actualValue = 3;
      secondGenModel
        ..secondGenFemaleIVList[0] = 0
        ..secondGenFemaleIVList[1] = 0
        ..updateValues(secondGenModel.secondGenFemaleIVList, actualValue);

      List<int> actualColorsList = secondGenModel.secondGenFemaleIVList;

      List<int> expectedList = <int>[3, 0];

      expect(actualColorsList, expectedList);
    });

    test(
        'Should return [secondGenFemaleIVList[0], value] if [secondGenerationFemaleIVList[0] > 0 and secondGenerationFemaleIVList[1] == 0 and value is > 0]',
        () {
      int actualValue = 5;
      secondGenModel
        ..secondGenFemaleIVList[0] = 3
        ..secondGenFemaleIVList[1] = 0
        ..updateValues(secondGenModel.secondGenFemaleIVList, actualValue);

      List<int> actualColorsList = secondGenModel.secondGenFemaleIVList;

      List<int> expectedList = <int>[3, 5];

      expect(actualColorsList, expectedList);
    });

    test('Should return [secondGenFemaleIVList[0], 0] if [both values in secondGenFemaleIVList > 0 and value == secondGenFemaleIVList[1]]', () {
      int actualValue = 5;
      secondGenModel
        ..secondGenFemaleIVList[0] = 3
        ..secondGenFemaleIVList[1] = 5
        ..updateValues(secondGenModel.secondGenFemaleIVList, actualValue);

      List<int> actualColorsList = secondGenModel.secondGenFemaleIVList;

      List<int> expectedList = <int>[3, 0];

      expect(actualColorsList, expectedList);
    });

    test('Should return [0, secondGenFemaleIVList[1]] if [both values in secondGenFemaleIVList > 0 and value is == secondGenFemaleIVList[0]', () {
      int actualValue = 3;
      secondGenModel
        ..secondGenFemaleIVList[0] = 3
        ..secondGenFemaleIVList[1] = 4
        ..updateValues(secondGenModel.secondGenFemaleIVList, actualValue);

      List<int> actualColorsList = secondGenModel.secondGenFemaleIVList;

      List<int> expectedList = <int>[0, 4];

      expect(actualColorsList, expectedList);
    });

    test('Should return [0, 0] if [secondGenFemaleIVList[0] == 0 and and value > 0 and value == secondGenFemaleIVList[1]]', () {
      int actualValue = 3;
      secondGenModel
        ..secondGenFemaleIVList[0] = 0
        ..secondGenFemaleIVList[1] = 3
        ..updateValues(secondGenModel.secondGenFemaleIVList, actualValue);

      List<int> actualColorsList = secondGenModel.secondGenFemaleIVList;

      List<int> expectedList = <int>[0, 0];

      expect(actualColorsList, expectedList);
    });

    test('Should return [0, 0] if [both values in secondGenMaleIVList == 0 and value is equal 0]', () {
      int actualValue = 0;
      secondGenModel
        ..secondGenMaleIVList[0] = 0
        ..secondGenMaleIVList[1] = 0
        ..updateValues(secondGenModel.secondGenMaleIVList, actualValue);

      List<int> actualColorsList = secondGenModel.secondGenMaleIVList;

      List<int> expectedList = <int>[0, 0];

      expect(actualColorsList, expectedList);
    });

    test('Should return [0, value] if [both values in secondGenMaleIVList == 0 and value is > 0]', () {
      int actualValue = 3;
      secondGenModel
        ..secondGenMaleIVList[0] = 0
        ..secondGenMaleIVList[1] = 0
        ..updateValues(secondGenModel.secondGenMaleIVList, actualValue);

      List<int> actualColorsList = secondGenModel.secondGenMaleIVList;

      List<int> expectedList = <int>[3, 0];

      expect(actualColorsList, expectedList);
    });

    test('Should return [secondGenMaleIVList[0], value] if [secondGenMaleIVList[0] > 0 and secondGenMaleIVList[1] == 0 and value is > 0]', () {
      int actualValue = 5;
      secondGenModel
        ..secondGenMaleIVList[0] = 3
        ..secondGenFemaleIVList[1] = 0
        ..updateValues(secondGenModel.secondGenMaleIVList, actualValue);

      List<int> actualColorsList = secondGenModel.secondGenMaleIVList;

      List<int> expectedList = <int>[3, 5];

      expect(actualColorsList, expectedList);
    });

    test('Should return [secondGenMaleIVList[0], 0] if [both values in secondGenMaleIVList > 0 and value == secondGenMaleIVList[1]', () {
      int actualValue = 5;
      secondGenModel
        ..secondGenMaleIVList[0] = 3
        ..secondGenMaleIVList[1] = 5
        ..updateValues(secondGenModel.secondGenMaleIVList, actualValue);

      List<int> actualColorsList = secondGenModel.secondGenMaleIVList;

      List<int> expectedList = <int>[3, 0];

      expect(actualColorsList, expectedList);
    });

    test('Should return [0, secondGenMaleIVList[1]] if [both values in secondGenMaleIVList > 0 and 0 and value is equal to secondGenMaleIVList[0]',
        () {
      int actualValue = 3;
      secondGenModel
        ..secondGenMaleIVList[0] = 3
        ..secondGenMaleIVList[1] = 4
        ..updateValues(secondGenModel.secondGenMaleIVList, actualValue);

      List<int> actualColorsList = secondGenModel.secondGenMaleIVList;

      List<int> expectedList = <int>[0, 4];

      expect(actualColorsList, expectedList);
    });

    test('Should return [0, 0] if [secondGenMaleIVList == 0 and and value > 0 and value == and value is == secondGenMaleIVList[1]', () {
      int actualValue = 3;
      secondGenModel
        ..secondGenMaleIVList[0] = 0
        ..secondGenMaleIVList[1] = 3
        ..updateValues(secondGenModel.secondGenMaleIVList, actualValue);

      List<int> actualColorsList = secondGenModel.secondGenMaleIVList;

      List<int> expectedList = <int>[0, 0];

      expect(actualColorsList, expectedList);
    });
  });

  group('Tests of SecondGenModel.isSumPositive()', () {
    test('Should return [false] if [both values in secondGenFemaleIVList == 0]', () {
      secondGenModel
        ..secondGenFemaleIVList[0] = 0
        ..secondGenFemaleIVList[1] = 0;

      bool actualValue = secondGenModel.isSumPositive(secondGenModel.secondGenFemaleIVList);
      bool expectedValue = false;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenFemaleIVList[0] > 0 and secondGenFemaleIVList[1] == 0]', () {
      secondGenModel
        ..secondGenFemaleIVList[0] = 3
        ..secondGenFemaleIVList[1] = 0;

      bool actualValue = secondGenModel.isSumPositive(secondGenModel.secondGenFemaleIVList);
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenFemaleIVList[0] == 0 and secondGenFemaleIVList[1] > 0]', () {
      secondGenModel
        ..secondGenFemaleIVList[0] = 0
        ..secondGenFemaleIVList[1] = 4;

      bool actualValue = secondGenModel.isSumPositive(secondGenModel.secondGenFemaleIVList);
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [both values in secondGenFemaleIVList > 0]', () {
      secondGenModel
        ..secondGenFemaleIVList[0] = 5
        ..secondGenFemaleIVList[1] = 4;

      bool actualValue = secondGenModel.isSumPositive(secondGenModel.secondGenFemaleIVList);
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [false] if [both values in secondGenMaleIVList == 0]', () {
      secondGenModel
        ..secondGenMaleIVList[0] = 0
        ..secondGenMaleIVList[1] = 0;

      bool actualValue = secondGenModel.isSumPositive(secondGenModel.secondGenMaleIVList);
      bool expectedValue = false;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenMaleIVList[0] > 0 and secondGenMaleIVList[0] == 0]', () {
      secondGenModel
        ..secondGenMaleIVList[0] = 3
        ..secondGenMaleIVList[1] = 0;

      bool actualValue = secondGenModel.isSumPositive(secondGenModel.secondGenMaleIVList);
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenMaleIVList[0] == 0 and secondGenMaleIVList[0] > 0', () {
      secondGenModel
        ..secondGenMaleIVList[0] = 0
        ..secondGenMaleIVList[1] = 4;

      bool actualValue = secondGenModel.isSumPositive(secondGenModel.secondGenMaleIVList);
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [both values in secondGenMaleIVList > 0', () {
      secondGenModel
        ..secondGenMaleIVList[0] = 5
        ..secondGenMaleIVList[1] = 4;

      bool actualValue = secondGenModel.isSumPositive(secondGenModel.secondGenMaleIVList);
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });
  });

  group('Tests of SecondGenModel.restartListValues()', () {
    test('Should return [0, 0] if [both values in secondGenFemaleIVList > 0]', () {
      secondGenModel
        ..secondGenFemaleIVList[0] = 3
        ..secondGenFemaleIVList[1] = 2;

      List<int> actualList = secondGenModel.restartListValues(secondGenModel.secondGenFemaleIVList);
      List<int> expectedList = <int>[0, 0];

      expect(actualList, expectedList);
    });

    test('Should return [0, 0] if [secondGenFemaleIVList[0] > 0 and secondGenFemaleIVList[1] == 0', () {
      secondGenModel
        ..secondGenFemaleIVList[0] = 1
        ..secondGenFemaleIVList[1] = 0;

      List<int> actualList = secondGenModel.restartListValues(secondGenModel.secondGenFemaleIVList);
      List<int> expectedList = <int>[0, 0];

      expect(actualList, expectedList);
    });

    test('Should return [0, 0] if [secondGenFemaleIVList[0] == 0 and secondGenFemaleIVList[1] > 0', () {
      secondGenModel
        ..secondGenFemaleIVList[0] = 0
        ..secondGenFemaleIVList[1] = 4;

      List<int> actualList = secondGenModel.restartListValues(secondGenModel.secondGenFemaleIVList);
      List<int> expectedList = <int>[0, 0];

      expect(actualList, expectedList);
    });

    test('Should return [0, 0] if [both values in secondGenMaleIVList > 0]', () {
      secondGenModel
        ..secondGenMaleIVList[0] = 3
        ..secondGenMaleIVList[1] = 2;

      List<int> actualList = secondGenModel.restartListValues(secondGenModel.secondGenMaleIVList);
      List<int> expectedList = <int>[0, 0];

      expect(actualList, expectedList);
    });

    test('Should return [0, 0] if [secondGenMaleIVList[0] > 0 and secondGenMaleIVList[1] == 0]', () {
      secondGenModel
        ..secondGenMaleIVList[0] = 1
        ..secondGenMaleIVList[1] = 0;

      List<int> actualList = secondGenModel.restartListValues(secondGenModel.secondGenFemaleIVList);
      List<int> expectedList = <int>[0, 0];

      expect(actualList, expectedList);
    });

    test('Should return [0, 0] if [secondGenMaleIVList[0] == 0 and secondGenMaleIVList[1] > 0]', () {
      secondGenModel
        ..secondGenMaleIVList[0] = 0
        ..secondGenMaleIVList[1] = 4;

      List<int> actualList = secondGenModel.restartListValues(secondGenModel.secondGenFemaleIVList);
      List<int> expectedList = <int>[0, 0];

      expect(actualList, expectedList);
    });
  });

  group('Tests of SecondGenModel.hasCommonValue()', () {
    test('Should return [false] if [both values in secondGenFemaleIVList are different from both values in secondGenMaleIVList]', () {
      secondGenModel
        ..secondGenFemaleIVList[0] = 1
        ..secondGenFemaleIVList[1] = 2
        ..secondGenMaleIVList[0] = 0
        ..secondGenMaleIVList[1] = 4;

      bool actualValue = secondGenModel.hasCommonValue(
        secondGenModel.secondGenFemaleIVList,
        secondGenModel.secondGenMaleIVList,
      );
      bool expectedValue = false;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenFemaleIVList[1] == secondGenMaleIVList[1]]', () {
      secondGenModel
        ..secondGenFemaleIVList[0] = 2
        ..secondGenFemaleIVList[1] = 4
        ..secondGenMaleIVList[0] = 0
        ..secondGenMaleIVList[1] = 4;

      bool actualValue = secondGenModel.hasCommonValue(
        secondGenModel.secondGenFemaleIVList,
        secondGenModel.secondGenMaleIVList,
      );
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenFemaleIVList[0] == secondGenMaleIVList[1]]', () {
      secondGenModel
        ..secondGenFemaleIVList[0] = 4
        ..secondGenFemaleIVList[1] = 7
        ..secondGenMaleIVList[0] = 0
        ..secondGenMaleIVList[1] = 4;

      bool actualValue = secondGenModel.hasCommonValue(
        secondGenModel.secondGenFemaleIVList,
        secondGenModel.secondGenMaleIVList,
      );
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenFemaleIVList[1] == secondGenMaleIVList[0]]', () {
      secondGenModel
        ..secondGenFemaleIVList[0] = 3
        ..secondGenFemaleIVList[1] = 4
        ..secondGenMaleIVList[0] = 4
        ..secondGenMaleIVList[1] = 2;

      bool actualValue = secondGenModel.hasCommonValue(
        secondGenModel.secondGenFemaleIVList,
        secondGenModel.secondGenMaleIVList,
      );
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [false] if [both values in secondGenMaleIVList are different from both values in secondGenFemaleIVList]', () {
      secondGenModel
        ..secondGenMaleIVList[0] = 1
        ..secondGenMaleIVList[1] = 2
        ..secondGenFemaleIVList[0] = 0
        ..secondGenFemaleIVList[1] = 4;

      bool actualValue = secondGenModel.hasCommonValue(
        secondGenModel.secondGenMaleIVList,
        secondGenModel.secondGenFemaleIVList,
      );
      bool expectedValue = false;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenMaleIVList[1] == secondGenFemaleIVList[1]]', () {
      secondGenModel
        ..secondGenMaleIVList[0] = 2
        ..secondGenMaleIVList[1] = 4
        ..secondGenFemaleIVList[0] = 0
        ..secondGenFemaleIVList[1] = 4;

      bool actualValue = secondGenModel.hasCommonValue(
        secondGenModel.secondGenMaleIVList,
        secondGenModel.secondGenFemaleIVList,
      );
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenMaleIVList[0] == secondGenFemaleIVList[1]]', () {
      secondGenModel
        ..secondGenMaleIVList[0] = 4
        ..secondGenMaleIVList[1] = 7
        ..secondGenFemaleIVList[0] = 0
        ..secondGenFemaleIVList[1] = 4;

      bool actualValue = secondGenModel.hasCommonValue(
        secondGenModel.secondGenMaleIVList,
        secondGenModel.secondGenFemaleIVList,
      );
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenMaleIVList[1] == secondGenFemaleIVList[0]]', () {
      secondGenModel
        ..secondGenMaleIVList[0] = 3
        ..secondGenMaleIVList[1] = 4
        ..secondGenFemaleIVList[0] = 4
        ..secondGenFemaleIVList[1] = 2;

      bool actualValue = secondGenModel.hasCommonValue(
        secondGenModel.secondGenMaleIVList,
        secondGenModel.secondGenFemaleIVList,
      );
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });
  });
}
