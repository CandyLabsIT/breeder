import 'package:breeder/blocks/pages/single_iv_form/a_single_iv_form_state.dart';
import 'package:breeder/blocks/pages/single_iv_form/single_iv_form_cubit.dart';
import 'package:breeder/blocks/pages/single_iv_form/states/single_iv_form_sum_calulated_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/pages/single_iv_form_page/single_iv_value_limit_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleIVTextFormWidget extends StatefulWidget {
  final int _indexTextEditingControllerList;
  final String _ivTextInfo;
  final int _maxLength;
  final int _maxSlots;
  final SingleIVFormCubit _singleIVFormCubit = globalLocator<SingleIVFormCubit>();

  SingleIVTextFormWidget({
    required int indexTextEditingControllerList,
    required String ivTextInfo,
    required int maxLength,
    required int maxSlots,
    Key? key,
  })  : _indexTextEditingControllerList = indexTextEditingControllerList,
        _ivTextInfo = ivTextInfo,
        _maxLength = maxLength,
        _maxSlots = maxSlots,
        super(key: key);

  @override
  State<SingleIVTextFormWidget> createState() {
    return _SingleIVTextFormWidget();
  }
}

class _SingleIVTextFormWidget extends State<SingleIVTextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleIVFormCubit, ASingleIVFormState>(
      bloc: widget._singleIVFormCubit,
      builder: (BuildContext context, ASingleIVFormState singleIVFormState) {
        return Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 44,
                    width: 50,
                    child: Text(
                      widget._ivTextInfo,
                      textAlign: TextAlign.center,
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
                      helperText: '${_calculateSingleIVAmountLeft(widget._maxSlots)} of ${widget._maxSlots} slots remaining',
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
                    SingleIVValueLimitInputFormatter(
                      formsSum: _getSingleIVFormSum(singleIVFormState),
                      maxSlots: widget._maxSlots,
                    ),
                  ],
                  maxLines: 1,
                  onChanged: (String value) {
                    widget._singleIVFormCubit.calculateSum();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  int _getSingleIVFormSum(ASingleIVFormState singleIVFormState) {
    if (singleIVFormState is SingleIVFormSumCalculatedState) {
      return singleIVFormState.singleIVFormSum;
    }
    return 0;
  }

  int _calculateSingleIVAmountLeft(int inputWeight) {
    return widget._singleIVFormCubit.singleIVFormModel.calculateAmountLeft(inputWeight);
  }

  TextEditingController _getTextEditingController(int indexTextEditingControllerList) {
    return widget._singleIVFormCubit.singleIVFormModel.singleIVTextEditingControllersList[indexTextEditingControllerList];
  }
}
