import 'package:breeder/blocks/pages/max_iv_form/a_max_iv_form_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_form/states/max_iv_form_sum_calculated_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/pages/max_iv_form_page/max_iv_value_limit_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaxIVTextFormWidget extends StatefulWidget {
  final int _indexTextEditingControllerList;
  final int _inputWeight;
  final String _ivTextInfo;
  final int _maxLength;
  final int _maxSlots;
  final MaxIVFormCubit _maxIVFormCubit = globalLocator<MaxIVFormCubit>();

  MaxIVTextFormWidget({
    required int indexTextEditingControllerList,
    required int inputWeight,
    required String ivTextInfo,
    required int maxLength,
    required int maxSlots,
    Key? key,
  })
      : _indexTextEditingControllerList = indexTextEditingControllerList,
        _inputWeight = inputWeight,
        _ivTextInfo = ivTextInfo,
        _maxLength = maxLength,
        _maxSlots = maxSlots,
        super(key: key);

  @override
  State<MaxIVTextFormWidget> createState(){
    return _MaxIVTextFormWidgetState();
  }
}

class _MaxIVTextFormWidgetState extends State<MaxIVTextFormWidget>{

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaxIVFormCubit, AMaxIVFormState>(
      bloc: widget._maxIVFormCubit,
      builder: (BuildContext context, AMaxIVFormState maxIVFormState) {

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
                  controller: _getTextEditingController(widget._indexTextEditingControllerList),
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
                      helperText: '${_calculateMaxIVAmountLeft(widget._inputWeight)} of ${widget._maxSlots} slots remaining',
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
                    MaxIVValueLimitInputFormatter(
                      formsSum: _getMaxIVFormWeightedSum(maxIVFormState),
                      inputWeight: widget._inputWeight,
                    ),
                  ],
                  maxLines: 1,
                  onChanged: (String value) {
                    widget._maxIVFormCubit.calculateSum();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // TODO(balladyna): After the MaxIVSlotsChangedState is called, the state remains unchanged thereafter, which can lead to problems in the future. Consider rewriting both the cubit and view.

  int _getMaxIVFormWeightedSum(AMaxIVFormState maxIVFormState) {
    if (maxIVFormState is MaxIVFormSumCalculatedState) {
      return maxIVFormState.maxIVFormSum;
    }
    return 0;
  }

  int _calculateMaxIVAmountLeft(int inputWeight) {
    return widget._maxIVFormCubit.maxIVFormModel.calculateAmountLeft(inputWeight);
  }

  TextEditingController _getTextEditingController(int indexTextEditingControllerList) {
    return widget._maxIVFormCubit.maxIVFormModel.maxIVTextEditingControllersList[indexTextEditingControllerList];
  }
}
