import 'package:flutter/services.dart';

class MaxIVValueLimitInputFormatter extends TextInputFormatter {
  final int _maxSlots = 32;
  final int _inputWeight;
  final int _formsSum;

  MaxIVValueLimitInputFormatter({required int formsSum, required int inputWeight})
      : _inputWeight = inputWeight,
        _formsSum = formsSum;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int? newInputValue = int.tryParse(newValue.text);

    if (newInputValue == null) {
      return TextEditingValue.empty;
    }

    newInputValue *= _inputWeight;
    int oldInputValue = (int.tryParse(oldValue.text) ?? 0) * _inputWeight;
    int slotsRemaining = (_maxSlots + oldInputValue) - (_formsSum + newInputValue);

    if (slotsRemaining >= 0) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
