import 'package:breeder/blocks/pages/max_iv_slots_page/a_iv_slots_amount_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_page/iv_slots_amount_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_slots_page/states/iv_slots_sum_state.dart';
import 'package:breeder/views/widgets/value_limit_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaxIVSlotsTextForm extends StatefulWidget {
  final String _ivTextInfo;
  final int _maxLength;
  final int _maxSlots;
  final int _indexTextEditingControllerList;
  final int _inputWeight;

  const MaxIVSlotsTextForm({
    required String ivTextInfo,
    required int maxLength,
    required int maxSlots,
    required int indexTextEditingControllerList,
    required int inputWeight,
    Key? key,
  })  : _indexTextEditingControllerList = indexTextEditingControllerList,
        _ivTextInfo = ivTextInfo,
        _maxLength = maxLength,
        _maxSlots = maxSlots,
        _inputWeight = inputWeight,
        super(key: key);

  @override
  _MaxIVSlotsTextFormState createState() => _MaxIVSlotsTextFormState();
}

class _MaxIVSlotsTextFormState extends State<MaxIVSlotsTextForm> {
  @override
  Widget build(BuildContext context) {
    final IVSlotsAmountCubit ivSlotsAmountCubit = context.read<IVSlotsAmountCubit>();
    return BlocBuilder<IVSlotsAmountCubit, AIVTextFormsState>(
      bloc: ivSlotsAmountCubit,
      builder: (BuildContext context, AIVTextFormsState ivSlotsAmountState) {
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
                  controller: ivSlotsAmountCubit.ivSlotsAmountModel.ivSlotsDataList[widget._indexTextEditingControllerList],
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
                      helperText: '${ivSlotsAmountCubit.ivSlotsAmountModel.getSlotsLeft(widget._inputWeight)} of ${widget._maxSlots} slots remaining',
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
                    ValueLimitInputFormatter(
                      inputsSum: _textFormsSum(ivSlotsAmountState),
                      inputWeight: widget._inputWeight,
                    ),
                  ],
                  maxLines: 1,
                  onChanged: (String value) {
                    ivSlotsAmountCubit
                    ..ivSlotsSum()
                    ..updateTextFormValue(widget._indexTextEditingControllerList, value);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  int _textFormsSum(AIVTextFormsState ivTextFormsState) {
    if (ivTextFormsState is IVTextFormValueChangedState) {
      return ivTextFormsState.textFormsSum;
    }
    return 0;
  }
}
