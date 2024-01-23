import 'package:breeder/views/pages/max_iv_form_page/max_iv_value_limit_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of MaxIVValueLimitInputFormatter.formatEditUpdate()', () {
    test('Should return [new value] if [old value is empty] and [new value does not exceed the limit]', () {
      const int formsSum = 16;
      const int inputWeight = 1;

      MaxIVValueLimitInputFormatter actualMaxIVValueLimitInputFormatter =
          MaxIVValueLimitInputFormatter(formsSum: formsSum, inputWeight: inputWeight);
      TextEditingValue actualOldTextEditingValue = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );

      TextEditingValue actualNewTextEditingValue = const TextEditingValue(
        text: '2',
        selection: TextSelection.collapsed(offset: 1),
      );

      TextEditingValue actualTextEditingValue = actualMaxIVValueLimitInputFormatter.formatEditUpdate(
        actualOldTextEditingValue,
        actualNewTextEditingValue,
      );

      TextEditingValue expectedTextEditingValue = const TextEditingValue(
        text: '2',
        selection: TextSelection.collapsed(offset: 1),
      );

      expect(actualTextEditingValue, expectedTextEditingValue);
    });

    test('Should return [new value] if [new value does not exceed the limit]', () {
      const int formsSum = 12;
      const int inputWeight = 2;

      MaxIVValueLimitInputFormatter actualMaxIVValueLimitInputFormatter =
          MaxIVValueLimitInputFormatter(formsSum: formsSum, inputWeight: inputWeight);

      TextEditingValue actualOldTextEditingValue = const TextEditingValue(
        text: '2',
        selection: TextSelection.collapsed(offset: 1),
      );

      TextEditingValue actualNewTextEditingValue = const TextEditingValue(
        text: '7',
        selection: TextSelection.collapsed(offset: 1),
      );

      TextEditingValue actualTextEditingValue = actualMaxIVValueLimitInputFormatter.formatEditUpdate(
        actualOldTextEditingValue,
        actualNewTextEditingValue,
      );

      TextEditingValue expectedTextEditingValue = const TextEditingValue(
        text: '7',
        selection: TextSelection.collapsed(offset: 1),
      );

      expect(actualTextEditingValue, expectedTextEditingValue);
    });

    test('Should return [new value] if [new value does not exceed the limit] and [cursor at the end]', () {
      const int formsSum = 12;
      const int inputWeight = 2;

      MaxIVValueLimitInputFormatter actualMaxIVValueLimitInputFormatter =
          MaxIVValueLimitInputFormatter(formsSum: formsSum, inputWeight: inputWeight);

      TextEditingValue actualOldTextEditingValue = const TextEditingValue(
        text: '2',
        selection: TextSelection.collapsed(offset: 1),
      );

      TextEditingValue actualNewTextEditingValue = const TextEditingValue(
        text: '10',
        selection: TextSelection.collapsed(offset: 2),
      );

      TextEditingValue actualTextEditingValue = actualMaxIVValueLimitInputFormatter.formatEditUpdate(
        actualOldTextEditingValue,
        actualNewTextEditingValue,
      );

      TextEditingValue expectedTextEditingValue = const TextEditingValue(
        text: '10',
        selection: TextSelection.collapsed(offset: 2),
      );

      expect(actualTextEditingValue, expectedTextEditingValue);
    });

    test('Should return [new value] if [new value does not exceed the limit] and [cursor at the beginning]', () {
      const int formsSum = 12;
      const int inputWeight = 4;

      MaxIVValueLimitInputFormatter actualMaxIVValueLimitInputFormatter =
          MaxIVValueLimitInputFormatter(formsSum: formsSum, inputWeight: inputWeight);
      TextEditingValue actualOldTextEditingValue = const TextEditingValue(
        text: '2',
        selection: TextSelection.collapsed(offset: 1),
      );

      TextEditingValue actualNewTextEditingValue = const TextEditingValue(
        text: '4',
        selection: TextSelection.collapsed(offset: 0),
      );

      TextEditingValue actualTextEditingValue = actualMaxIVValueLimitInputFormatter.formatEditUpdate(
        actualOldTextEditingValue,
        actualNewTextEditingValue,
      );

      TextEditingValue expectedTextEditingValue = const TextEditingValue(
        text: '4',
        selection: TextSelection.collapsed(offset: 0),
      );

      expect(actualTextEditingValue, expectedTextEditingValue);
    });

    test('Should return [old value] if [new value exceed the limit]', () {
      const int formsSum = 12;
      const int inputWeight = 16;

      MaxIVValueLimitInputFormatter actualMaxIVValueLimitInputFormatter =
          MaxIVValueLimitInputFormatter(formsSum: formsSum, inputWeight: inputWeight);
      TextEditingValue actualOldTextEditingValue = const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );

      TextEditingValue actualNewTextEditingValue = const TextEditingValue(
        text: '24',
        selection: TextSelection.collapsed(offset: 1),
      );

      TextEditingValue actualTextEditingValue = actualMaxIVValueLimitInputFormatter.formatEditUpdate(
        actualOldTextEditingValue,
        actualNewTextEditingValue,
      );

      TextEditingValue expectedTextEditingValue = const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );

      expect(actualTextEditingValue, expectedTextEditingValue);
    });

    test('Should return [an empty field] if [new value is empty]', () {
      const int formsSum = 12;
      const int inputWeight = 16;

      MaxIVValueLimitInputFormatter actualMaxIVValueLimitInputFormatter =
          MaxIVValueLimitInputFormatter(formsSum: formsSum, inputWeight: inputWeight);
      TextEditingValue actualOldTextEditingValue = const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );

      TextEditingValue actualNewTextEditingValue = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );

      TextEditingValue actualTextEditingValue = actualMaxIVValueLimitInputFormatter.formatEditUpdate(
        actualOldTextEditingValue,
        actualNewTextEditingValue,
      );

      TextEditingValue expectedTextEditingValue = TextEditingValue.empty;

      expect(actualTextEditingValue, expectedTextEditingValue);
    });

    test('Should return [an empty field] if [new value is not composed of digits]', () {
      const int formsSum = 12;
      const int inputWeight = 16;

      MaxIVValueLimitInputFormatter actualMaxIVValueLimitInputFormatter =
          MaxIVValueLimitInputFormatter(formsSum: formsSum, inputWeight: inputWeight);
      TextEditingValue actualOldTextEditingValue = const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );

      TextEditingValue actualNewTextEditingValue = const TextEditingValue(
        text: 'asd',
        selection: TextSelection.collapsed(offset: 3),
      );

      TextEditingValue actualTextEditingValue = actualMaxIVValueLimitInputFormatter.formatEditUpdate(
        actualOldTextEditingValue,
        actualNewTextEditingValue,
      );

      TextEditingValue expectedTextEditingValue = TextEditingValue.empty;

      expect(actualTextEditingValue, expectedTextEditingValue);
    });
  });
}
