import 'package:breeder/shared/models/max_iv_form/max_iv_form_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of MaxIVFormModel.getAmountList()', () {

    final MaxIVFormModel maxIVFormModel = MaxIVFormModel();

    test('Should return [all inputs] if [all inputs are digits]', () {
      maxIVFormModel
        ..maxIVTextEditingControllersList[0].text = '2'
        ..maxIVTextEditingControllersList[1].text = '1'
        ..maxIVTextEditingControllersList[2].text = '1'
        ..maxIVTextEditingControllersList[3].text = '1'
        ..maxIVTextEditingControllersList[4].text = '1';

      List<int> actualAmountList = maxIVFormModel.getAmountList();

      List<int> expectedAmountList = <int>[2, 1, 1, 1, 1];

      expect(actualAmountList, expectedAmountList);
    });

    test('Should return [valid inputs and zeros] if [some inputs are empty]', () {
      maxIVFormModel
        ..maxIVTextEditingControllersList[0].text = '2'
        ..maxIVTextEditingControllersList[1].text = ''
        ..maxIVTextEditingControllersList[2].text = '2'
        ..maxIVTextEditingControllersList[3].text = '1'
        ..maxIVTextEditingControllersList[4].text = '';

      List<int> actualAmountList = maxIVFormModel.getAmountList();

      List<int> expectedAmountList = <int>[2, 0, 2, 1, 0];

      expect(actualAmountList, expectedAmountList);
    });

    test('Should return [list with only zeros] if [all inputs are empty]', () {
      for (TextEditingController textEditingController in maxIVFormModel.maxIVTextEditingControllersList) {
        textEditingController.text = '';
      }

      List<int> actualAmountList = maxIVFormModel.getAmountList();

      List<int> expectedAmountList = <int>[0, 0, 0, 0, 0];

      expect(actualAmountList, expectedAmountList);
    });
  });

  group('Tests of MaxIVFormModel.calculateWeightedSum()', () {

    final MaxIVFormModel maxIVFormModel = MaxIVFormModel();

    test('Should return [weighted sum of all inputs] if [all inputs are digits]', () {
      maxIVFormModel
        ..maxIVTextEditingControllersList[0].text = '2'
        ..maxIVTextEditingControllersList[1].text = '1'
        ..maxIVTextEditingControllersList[2].text = '1'
        ..maxIVTextEditingControllersList[3].text = '1'
        ..maxIVTextEditingControllersList[4].text = '1';

      int actualCalculatedWeightedSum = maxIVFormModel.calculateWeightedSum();

      int expectedCalculatedWeightedSum = 32;

      expect(actualCalculatedWeightedSum, expectedCalculatedWeightedSum);
    });

    test('Should return [weighted sum of valid inputs] if [some inputs are empty]', () {
      maxIVFormModel
        ..maxIVTextEditingControllersList[0].text = '2'
        ..maxIVTextEditingControllersList[1].text = ''
        ..maxIVTextEditingControllersList[2].text = '2'
        ..maxIVTextEditingControllersList[3].text = '1'
        ..maxIVTextEditingControllersList[4].text = '';

      int actualMaxIVSlotsWeightedSum = maxIVFormModel.calculateWeightedSum();

      int expectedMaxIVSlotsWeightedSum = 18;

      expect(actualMaxIVSlotsWeightedSum, expectedMaxIVSlotsWeightedSum);
    });

    test('Should return [zero] if [all inputs are empty]', () {
      for (TextEditingController textEditingController in maxIVFormModel.maxIVTextEditingControllersList) {
        textEditingController.text = '';
      }

      int actualCalculatedWeightedSum = maxIVFormModel.calculateWeightedSum();

      int expectedCalculatedWeightedSum = 0;

      expect(actualCalculatedWeightedSum, expectedCalculatedWeightedSum);
    });
  });

  // TODO(balladyna): Consider creating tests that include all possible IV combinations for  MaxIVSlotsModel.calculateMaxIVAmountLeft().

  group('Tests of MaxIVFormModel.calculateAmountLeft()', () {

    final MaxIVFormModel maxIVFormModel = MaxIVFormModel();

    test('Should return [CalculatedAmountLeft equal zero] if [all inputs are digits] and [weighted sum is 32]', () {
      maxIVFormModel
        ..maxIVTextEditingControllersList[0].text = '2'
        ..maxIVTextEditingControllersList[1].text = '1'
        ..maxIVTextEditingControllersList[2].text = '1'
        ..maxIVTextEditingControllersList[3].text = '1'
        ..maxIVTextEditingControllersList[4].text = '1';

      int actualInputWeight = 2;
      int actualCalculatedAmountLeft = maxIVFormModel.calculateAmountLeft(actualInputWeight);

      int expectedCalculatedAmountLeft = 0;

      expect(actualCalculatedAmountLeft, expectedCalculatedAmountLeft);
    });

    test('Should return [CalculatedAmountLeft > 0] if [some inputs are empty] and [weighted sum is greater than 0 but less than 32]', () {
      maxIVFormModel
        ..maxIVTextEditingControllersList[0].text = '2'
        ..maxIVTextEditingControllersList[1].text = ''
        ..maxIVTextEditingControllersList[2].text = '2'
        ..maxIVTextEditingControllersList[3].text = '1'
        ..maxIVTextEditingControllersList[4].text = '';

      int actualInputWeight = 2;
      int actualCalculatedAmountLeft = maxIVFormModel.calculateAmountLeft(actualInputWeight);

      int expectedCalculatedAmountLeft = 7;

      expect(actualCalculatedAmountLeft, expectedCalculatedAmountLeft);
    });

    test('Should return [CalculatedAmountLeft equal 32 divided by InputWeight] if [all inputs are empty]', () {
      for (TextEditingController textEditingController in maxIVFormModel.maxIVTextEditingControllersList) {
        textEditingController.text = '';
      }

      int actualInputWeight = 1;
      int actualCalculatedAmountLeft = maxIVFormModel.calculateAmountLeft(actualInputWeight);

      int expectedCalculatedAmountLeft = 32;

      expect(actualCalculatedAmountLeft, expectedCalculatedAmountLeft);
    });
  });
}
