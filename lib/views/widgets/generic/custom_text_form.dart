import 'package:breeder/views/widgets/limit_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextForm extends StatefulWidget {
  final TextEditingController _controller;
  final String _ivTextInfo;
  final int _maxLength;
  final int _maxSlots;
  final int _inputsSum;
  final int _inputWeight;
  final ValueChanged<String> _onChanged;

  const CustomTextForm({
    required TextEditingController controller,
    required String ivTextInfo,
    required int maxLength,
    required int maxSlots,
    required int inputsSum,
    required int inputWeight,
    required void Function(String) onChanged,
    Key? key,
  })  : _onChanged = onChanged,
        _controller = controller,
        _ivTextInfo = ivTextInfo,
        _maxLength = maxLength,
        _maxSlots = maxSlots,
        _inputsSum = inputsSum,
        _inputWeight = inputWeight,
        super(key: key);

  @override
  _CustomTextFormState createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    int slotsLeft = ((32 - widget._inputsSum) / widget._inputWeight).truncate();

    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 44,
                width: 40,
                child: Text(
                  widget._ivTextInfo,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
            width: 150,
            child: TextFormField(
              controller: widget._controller,
              decoration: InputDecoration(
                  isCollapsed: true,
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.zero,
                  labelStyle: const TextStyle(
                    color: Color(0xFF727272),
                    fontSize: 15,
                    height: 0,
                  ),
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  helperText: '$slotsLeft of ${widget._maxSlots} slots remaining',
                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  floatingLabelBehavior: FloatingLabelBehavior.never),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget._maxLength),
                LimitInputFormatter(inputsSum: widget._inputsSum, inputWeight: widget._inputWeight),
              ],
              maxLines: 1,
              onChanged: widget._onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
