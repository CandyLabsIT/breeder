import 'package:breeder/shared/models/max_iv_slots_amount_model/max_iv_slots_model.dart';
import 'package:breeder/shared/models/max_iv_slots_amount_model/max_iv_text_editing_controllers_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of MaxIVSlotsModel', () {
    final MaxIVTextEditingControllersList maxIVTextEditingControllersList = MaxIVTextEditingControllersList();
    final MaxIVSlotsModel maxIVSlotsModel = MaxIVSlotsModel()
      ..maxIVTextEditingControllersList = maxIVTextEditingControllersList.maxIVTextEditingControllersList;

    test('Should return [all inputs] if [all inputs are digits]', () {
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[0].text = '2';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[1].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[2].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[3].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[4].text = '1';

      expect(maxIVSlotsModel.getMaxIVSlotsAmountList(), <int>[2, 1, 1, 1, 1]);
    });

    test('Should return [all inputs] if [all inputs are digits]', () {
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[0].text = '2';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[1].text = '';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[2].text = '2';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[3].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[4].text = '';

      expect(maxIVSlotsModel.getMaxIVSlotsAmountList(), <int>[2, 0, 2, 1, 0]);
    });

    test('Should return [0 (zero)] if [all inputs are empty]', () {
      for (TextEditingController textEditingController in maxIVTextEditingControllersList.maxIVTextEditingControllersList) {
        textEditingController.text = '';
      }

      expect(maxIVSlotsModel.getMaxIVSlotsAmountList(), <int>[0, 0, 0, 0, 0]);
    });

    test('Should return [sum of all inputs] if [all inputs are digits]', () {
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[0].text = '2';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[1].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[2].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[3].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[4].text = '1';

      expect(maxIVSlotsModel.calculateMaxIVSlotsSum(), 32);
    });

    test('Should return [sum of valid inputs] if [some inputs are empty]', () {
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[0].text = '2';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[1].text = '';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[2].text = '2';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[3].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[4].text = '';

      expect(maxIVSlotsModel.calculateMaxIVSlotsSum(), 18);
    });

    test('Should return [0 (zero)] if [all inputs are empty]', () {
      for (TextEditingController textEditingController in maxIVTextEditingControllersList.maxIVTextEditingControllersList) {
        textEditingController.text = '';
      }

      expect(maxIVSlotsModel.calculateMaxIVSlotsSum(), 0);
    });

    test('Should return [sum of all inputs] if [all inputs are digits]', () {
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[0].text = '2';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[1].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[2].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[3].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[4].text = '1';

      expect(maxIVSlotsModel.calculateMaxIVAmountLeft(2), 0);
    });

    test('Should return [sum of valid inputs] if [some inputs are empty]', () {
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[0].text = '2';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[1].text = '';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[2].text = '2';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[3].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[4].text = '';

      expect(maxIVSlotsModel.calculateMaxIVAmountLeft(2), 7);
    });

    test('Should return [sum of valid inputs] if [some inputs are empty]', () {
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[0].text = '2';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[1].text = '';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[2].text = '2';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[3].text = '1';
      maxIVTextEditingControllersList.maxIVTextEditingControllersList[4].text = '';

      expect(maxIVSlotsModel.calculateMaxIVAmountLeft(2), 7);
    });

    test('Should return [0 (zero)] if [all inputs are empty]', () {
      for (TextEditingController textEditingController in maxIVTextEditingControllersList.maxIVTextEditingControllersList) {
        textEditingController.text = '';
      }

      expect(maxIVSlotsModel.calculateMaxIVAmountLeft(4), 8);
    });
  });
}
