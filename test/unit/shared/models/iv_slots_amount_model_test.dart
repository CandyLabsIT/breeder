import 'package:breeder/config/controllers/maxi_iv_text_formatter_cotrollers.dart';
import 'package:breeder/shared/models/iv_slots_amount_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of IVSlotsAmountModel.calculateSlotsSum', () {
    final IVTextEditingControllersList textEditingControllerList = IVTextEditingControllersList();
    final IVSlotsAmountModel monstersModel = IVSlotsAmountModel()..ivSlotsDataList = textEditingControllerList.textEditingControllerList;

    test('Should return [sum of all inputs] if [all inputs are digits]', () {
      textEditingControllerList.textEditingControllerList[0].text = '2';
      textEditingControllerList.textEditingControllerList[1].text = '1';
      textEditingControllerList.textEditingControllerList[2].text = '1';
      textEditingControllerList.textEditingControllerList[3].text = '1';
      textEditingControllerList.textEditingControllerList[4].text = '1';

      expect(monstersModel.calculateSlotsSum(), 32);
    });
    test('Should return [sum of valid inputs] if [some inputs are empty]', () {
      textEditingControllerList.textEditingControllerList[0].text = '2';
      textEditingControllerList.textEditingControllerList[1].text = '';
      textEditingControllerList.textEditingControllerList[2].text = '2';
      textEditingControllerList.textEditingControllerList[3].text = '1';
      textEditingControllerList.textEditingControllerList[4].text = '';

      expect(monstersModel.calculateSlotsSum(), 18);
    });
    test('Should return [0 (zero)] if [all inputs are empty]', () {
      for (TextEditingController textEditingController in textEditingControllerList.textEditingControllerList) {
        textEditingController.text = '';
      }

      expect(monstersModel.calculateSlotsSum(), 0);
    });
  });
}