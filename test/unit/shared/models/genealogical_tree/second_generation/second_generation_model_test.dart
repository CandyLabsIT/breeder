import 'package:breeder/shared/models/genealogical_tree/second_generation/second_generation_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final SecondGenerationModel secondGenerationModel = SecondGenerationModel();

  group('Tests of SecondGenerationModel.updateValues()', () {
    test('Should return [0, 0] if [both values in secondGenerationFemaleIVList == 0 and value is equal 0]', () {
      int actualValue = 0;
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 0
        ..secondGenerationFemaleIVList[1] = 0
        ..updateValues(secondGenerationModel.secondGenerationFemaleIVList, actualValue);

      List<int> actualColorsList = secondGenerationModel.secondGenerationFemaleIVList;

      List<int> expectedList = <int>[0, 0];

      expect(actualColorsList, expectedList);
    });

    test('Should return [0, value] if [both values in secondGenerationFemaleIVList == 0 and value is > 0]', () {
      int actualValue = 3;
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 0
        ..secondGenerationFemaleIVList[1] = 0
        ..updateValues(secondGenerationModel.secondGenerationFemaleIVList, actualValue);

      List<int> actualColorsList = secondGenerationModel.secondGenerationFemaleIVList;

      List<int> expectedList = <int>[3, 0];

      expect(actualColorsList, expectedList);
    });

    test(
        'Should return [secondGenerationFemaleIVList[0], value] if [secondGenerationFemaleIVList[0] > 0 and secondGenerationFemaleIVList[1] == 0 and value is > 0]',
        () {
      int actualValue = 5;
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 3
        ..secondGenerationFemaleIVList[1] = 0
        ..updateValues(secondGenerationModel.secondGenerationFemaleIVList, actualValue);

      List<int> actualColorsList = secondGenerationModel.secondGenerationFemaleIVList;

      List<int> expectedList = <int>[3, 5];

      expect(actualColorsList, expectedList);
    });

    test(
        'Should return [secondGenerationFemaleIVList[0], 0] if [both values in secondGenerationFemaleIVList > 0 and value == secondGenerationFemaleIVList[1]]',
        () {
      int actualValue = 5;
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 3
        ..secondGenerationFemaleIVList[1] = 5
        ..updateValues(secondGenerationModel.secondGenerationFemaleIVList, actualValue);

      List<int> actualColorsList = secondGenerationModel.secondGenerationFemaleIVList;

      List<int> expectedList = <int>[3, 0];

      expect(actualColorsList, expectedList);
    });

    test(
        'Should return [0, secondGenerationFemaleIVList[1]] if [both values in secondGenerationFemaleIVList > 0 and value is == secondGenerationFemaleIVList[0]',
        () {
      int actualValue = 3;
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 3
        ..secondGenerationFemaleIVList[1] = 4
        ..updateValues(secondGenerationModel.secondGenerationFemaleIVList, actualValue);

      List<int> actualColorsList = secondGenerationModel.secondGenerationFemaleIVList;

      List<int> expectedList = <int>[0, 4];

      expect(actualColorsList, expectedList);
    });

    test('Should return [0, 0] if [secondGenerationFemaleIVList[0] == 0 and and value > 0 and value == secondGenerationFemaleIVList[1]]', () {
      int actualValue = 3;
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 0
        ..secondGenerationFemaleIVList[1] = 3
        ..updateValues(secondGenerationModel.secondGenerationFemaleIVList, actualValue);

      List<int> actualColorsList = secondGenerationModel.secondGenerationFemaleIVList;

      List<int> expectedList = <int>[0, 0];

      expect(actualColorsList, expectedList);
    });

    test('Should return [0, 0] if [both values in secondGenerationMaleIVList == 0 and value is equal 0]', () {
      int actualValue = 0;
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 0
        ..secondGenerationMaleIVList[1] = 0
        ..updateValues(secondGenerationModel.secondGenerationMaleIVList, actualValue);

      List<int> actualColorsList = secondGenerationModel.secondGenerationMaleIVList;

      List<int> expectedList = <int>[0, 0];

      expect(actualColorsList, expectedList);
    });

    test('Should return [0, value] if [both values in secondGenerationMaleIVList == 0 and value is > 0]', () {
      int actualValue = 3;
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 0
        ..secondGenerationMaleIVList[1] = 0
        ..updateValues(secondGenerationModel.secondGenerationMaleIVList, actualValue);

      List<int> actualColorsList = secondGenerationModel.secondGenerationMaleIVList;

      List<int> expectedList = <int>[3, 0];

      expect(actualColorsList, expectedList);
    });

    test(
        'Should return [secondGenerationMaleIVList[0], value] if [secondGenerationMaleIVList[0] > 0 and secondGenerationMaleIVList[1] == 0 and value is > 0]',
        () {
      int actualValue = 5;
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 3
        ..secondGenerationFemaleIVList[1] = 0
        ..updateValues(secondGenerationModel.secondGenerationMaleIVList, actualValue);

      List<int> actualColorsList = secondGenerationModel.secondGenerationMaleIVList;

      List<int> expectedList = <int>[3, 5];

      expect(actualColorsList, expectedList);
    });

    test(
        'Should return [secondGenerationMaleIVList[0], 0] if [both values in secondGenerationMaleIVList > 0 and value == secondGenerationMaleIVList[1]',
        () {
      int actualValue = 5;
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 3
        ..secondGenerationMaleIVList[1] = 5
        ..updateValues(secondGenerationModel.secondGenerationMaleIVList, actualValue);

      List<int> actualColorsList = secondGenerationModel.secondGenerationMaleIVList;

      List<int> expectedList = <int>[3, 0];

      expect(actualColorsList, expectedList);
    });

    test(
        'Should return [0, secondGenerationMaleIVList[1]] if [both values in secondGenerationMaleIVList > 0 and 0 and value is equal to secondGenerationMaleIVList[0]',
        () {
      int actualValue = 3;
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 3
        ..secondGenerationMaleIVList[1] = 4
        ..updateValues(secondGenerationModel.secondGenerationMaleIVList, actualValue);

      List<int> actualColorsList = secondGenerationModel.secondGenerationMaleIVList;

      List<int> expectedList = <int>[0, 4];

      expect(actualColorsList, expectedList);
    });

    test('Should return [0, 0] if [secondGenerationMaleIVList == 0 and and value > 0 and value == and value is == secondGenerationMaleIVList[1]',
        () {
      int actualValue = 3;
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 0
        ..secondGenerationMaleIVList[1] = 3
        ..updateValues(secondGenerationModel.secondGenerationMaleIVList, actualValue);

      List<int> actualColorsList = secondGenerationModel.secondGenerationMaleIVList;

      List<int> expectedList = <int>[0, 0];

      expect(actualColorsList, expectedList);
    });
  });

  group('Tests of SecondGenerationModel.isSumPositive()', () {
    test('Should return [false] if [both values in secondGenerationFemaleIVList == 0]', () {
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 0
        ..secondGenerationFemaleIVList[1] = 0;

      bool actualValue = secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationFemaleIVList);
      bool expectedValue = false;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenerationFemaleIVList[0] > 0 and secondGenerationFemaleIVList[1] == 0]', () {
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 3
        ..secondGenerationFemaleIVList[1] = 0;

      bool actualValue = secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationFemaleIVList);
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenerationFemaleIVList[0] == 0 and secondGenerationFemaleIVList[1] > 0]', () {
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 0
        ..secondGenerationFemaleIVList[1] = 4;

      bool actualValue = secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationFemaleIVList);
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [both values in secondGenerationFemaleIVList > 0]', () {
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 5
        ..secondGenerationFemaleIVList[1] = 4;

      bool actualValue = secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationFemaleIVList);
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [false] if [both values in secondGenerationMaleIVList == 0]', () {
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 0
        ..secondGenerationMaleIVList[1] = 0;

      bool actualValue = secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationMaleIVList);
      bool expectedValue = false;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenerationMaleIVList[0] > 0 and secondGenerationMaleIVList[0] == 0]', () {
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 3
        ..secondGenerationMaleIVList[1] = 0;

      bool actualValue = secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationMaleIVList);
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenerationMaleIVList[0] == 0 and secondGenerationMaleIVList[0] > 0', () {
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 0
        ..secondGenerationMaleIVList[1] = 4;

      bool actualValue = secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationMaleIVList);
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [both values in secondGenerationMaleIVList > 0', () {
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 5
        ..secondGenerationMaleIVList[1] = 4;

      bool actualValue = secondGenerationModel.isSumPositive(secondGenerationModel.secondGenerationMaleIVList);
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });
  });

  group('Tests of SecondGenerationModel.restartListValues()', () {
    test('Should return [0, 0] if [both values in secondGenerationFemaleIVList > 0]', () {
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 3
        ..secondGenerationFemaleIVList[1] = 2;

      List<int> actualList = secondGenerationModel.restartListValues(secondGenerationModel.secondGenerationFemaleIVList);
      List<int> expectedList = <int>[0, 0];

      expect(actualList, expectedList);
    });

    test('Should return [0, 0] if [secondGenerationFemaleIVList[0] > 0 and secondGenerationFemaleIVList[1] == 0', () {
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 1
        ..secondGenerationFemaleIVList[1] = 0;

      List<int> actualList = secondGenerationModel.restartListValues(secondGenerationModel.secondGenerationFemaleIVList);
      List<int> expectedList = <int>[0, 0];

      expect(actualList, expectedList);
    });

    test('Should return [0, 0] if [secondGenerationFemaleIVList[0] == 0 and secondGenerationFemaleIVList[1] > 0', () {
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 0
        ..secondGenerationFemaleIVList[1] = 4;

      List<int> actualList = secondGenerationModel.restartListValues(secondGenerationModel.secondGenerationFemaleIVList);
      List<int> expectedList = <int>[0, 0];

      expect(actualList, expectedList);
    });

    test('Should return [0, 0] if [both values in secondGenerationMaleIVList > 0]', () {
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 3
        ..secondGenerationMaleIVList[1] = 2;

      List<int> actualList = secondGenerationModel.restartListValues(secondGenerationModel.secondGenerationMaleIVList);
      List<int> expectedList = <int>[0, 0];

      expect(actualList, expectedList);
    });

    test('Should return [0, 0] if [secondGenerationMaleIVList[0] > 0 and secondGenerationMaleIVList[1] == 0]', () {
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 1
        ..secondGenerationMaleIVList[1] = 0;

      List<int> actualList = secondGenerationModel.restartListValues(secondGenerationModel.secondGenerationFemaleIVList);
      List<int> expectedList = <int>[0, 0];

      expect(actualList, expectedList);
    });

    test('Should return [0, 0] if [secondGenerationMaleIVList[0] == 0 and secondGenerationMaleIVList[1] > 0]', () {
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 0
        ..secondGenerationMaleIVList[1] = 4;

      List<int> actualList = secondGenerationModel.restartListValues(secondGenerationModel.secondGenerationFemaleIVList);
      List<int> expectedList = <int>[0, 0];

      expect(actualList, expectedList);
    });
  });

  group('Tests of SecondGenerationModel.hasCommonValue()', () {
    test('Should return [false] if [both values in secondGenerationFemaleIVList are different from both values in secondGenerationMaleIVList]', () {
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 1
        ..secondGenerationFemaleIVList[1] = 2
        ..secondGenerationMaleIVList[0] = 0
        ..secondGenerationMaleIVList[1] = 4;

      bool actualValue = secondGenerationModel.hasCommonValue(
        secondGenerationModel.secondGenerationFemaleIVList,
        secondGenerationModel.secondGenerationMaleIVList,
      );
      bool expectedValue = false;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenerationFemaleIVList[1] == secondGenerationMaleIVList[1]]', () {
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 2
        ..secondGenerationFemaleIVList[1] = 4
        ..secondGenerationMaleIVList[0] = 0
        ..secondGenerationMaleIVList[1] = 4;

      bool actualValue = secondGenerationModel.hasCommonValue(
        secondGenerationModel.secondGenerationFemaleIVList,
        secondGenerationModel.secondGenerationMaleIVList,
      );
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenerationFemaleIVList[0] == secondGenerationMaleIVList[1]]', () {
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 4
        ..secondGenerationFemaleIVList[1] = 7
        ..secondGenerationMaleIVList[0] = 0
        ..secondGenerationMaleIVList[1] = 4;

      bool actualValue = secondGenerationModel.hasCommonValue(
        secondGenerationModel.secondGenerationFemaleIVList,
        secondGenerationModel.secondGenerationMaleIVList,
      );
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenerationFemaleIVList[1] == secondGenerationMaleIVList[0]]', () {
      secondGenerationModel
        ..secondGenerationFemaleIVList[0] = 3
        ..secondGenerationFemaleIVList[1] = 4
        ..secondGenerationMaleIVList[0] = 4
        ..secondGenerationMaleIVList[1] = 2;

      bool actualValue = secondGenerationModel.hasCommonValue(
        secondGenerationModel.secondGenerationFemaleIVList,
        secondGenerationModel.secondGenerationMaleIVList,
      );
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [false] if [both values in secondGenerationMaleIVList are different from both values in secondGenerationFemaleIVList]', () {
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 1
        ..secondGenerationMaleIVList[1] = 2
        ..secondGenerationFemaleIVList[0] = 0
        ..secondGenerationFemaleIVList[1] = 4;

      bool actualValue = secondGenerationModel.hasCommonValue(
        secondGenerationModel.secondGenerationMaleIVList,
        secondGenerationModel.secondGenerationFemaleIVList,
      );
      bool expectedValue = false;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenerationMaleIVList[1] == secondGenerationFemaleIVList[1]]', () {
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 2
        ..secondGenerationMaleIVList[1] = 4
        ..secondGenerationFemaleIVList[0] = 0
        ..secondGenerationFemaleIVList[1] = 4;

      bool actualValue = secondGenerationModel.hasCommonValue(
        secondGenerationModel.secondGenerationMaleIVList,
        secondGenerationModel.secondGenerationFemaleIVList,
      );
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenerationMaleIVList[0] == secondGenerationFemaleIVList[1]]', () {
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 4
        ..secondGenerationMaleIVList[1] = 7
        ..secondGenerationFemaleIVList[0] = 0
        ..secondGenerationFemaleIVList[1] = 4;

      bool actualValue = secondGenerationModel.hasCommonValue(
        secondGenerationModel.secondGenerationMaleIVList,
        secondGenerationModel.secondGenerationFemaleIVList,
      );
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });

    test('Should return [true] if [secondGenerationMaleIVList[1] == secondGenerationFemaleIVList[0]]', () {
      secondGenerationModel
        ..secondGenerationMaleIVList[0] = 3
        ..secondGenerationMaleIVList[1] = 4
        ..secondGenerationFemaleIVList[0] = 4
        ..secondGenerationFemaleIVList[1] = 2;

      bool actualValue = secondGenerationModel.hasCommonValue(
        secondGenerationModel.secondGenerationMaleIVList,
        secondGenerationModel.secondGenerationFemaleIVList,
      );
      bool expectedValue = true;

      expect(actualValue, expectedValue);
    });
  });
}
