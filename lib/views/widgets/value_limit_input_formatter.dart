import 'package:flutter/services.dart';

class ValueLimitInputFormatter extends TextInputFormatter {
  final int _maxSlots = 32;
  final int _inputWeight;
  final int _slotsSum;

  ValueLimitInputFormatter({required int inputsSum, required int inputWeight})
      : _inputWeight = inputWeight,
        _slotsSum = inputsSum;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int? newInputValue = int.tryParse(newValue.text);
    if (newInputValue == null) {
      return TextEditingValue.empty;
    }
    newInputValue *= _inputWeight;
    int oldInputValue = (int.tryParse(oldValue.text) ?? 0) * _inputWeight;
    int slotsRemaining = (_maxSlots + oldInputValue) - (_slotsSum + newInputValue);
    if (slotsRemaining >= 0) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}