
import 'package:flutter/services.dart';

class SingleIVValueLimitInputFormatter extends TextInputFormatter {
  final int _maxSlots;
  final int _formsSum;

  SingleIVValueLimitInputFormatter({required int formsSum, required int maxSlots})
      : _maxSlots = maxSlots,
        _formsSum = formsSum;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int? newInputValue = int.tryParse(newValue.text);

    if (newInputValue == null) {
      return TextEditingValue.empty;
    }

    int oldInputValue = int.tryParse(oldValue.text) ?? 0 ;
    int slotsRemaining = (_maxSlots + oldInputValue) - (_formsSum + newInputValue);

    if (slotsRemaining >= 0) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
