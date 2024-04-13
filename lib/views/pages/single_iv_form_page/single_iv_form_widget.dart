import 'package:breeder/blocks/pages/max_iv_form/a_max_iv_form_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_form/states/max_iv_form_list_parsed_state.dart';
import 'package:breeder/shared/models/single_iv_form/single_iv_form_model.dart';
import 'package:breeder/views/pages/single_iv_form_page/single_iv_value_limit_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleIVTextFormWidget extends StatefulWidget {
  final int _indexTextEditingControllerList;
  final String _ivTextInfo;
  final int _maxLength;
  final int _maxSlots;
  final SingleIVFormModel _singleIVFormModel = SingleIVFormModel();
  final MaxIVFormCubit _maxIVFormCubit = MaxIVFormCubit();

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
                    width: 80,
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
                      helperText: '${_calculateSingleIVAmountLeft(_getSingleIVValue(maxIVFormState))} of ${widget._maxSlots} slots remaining',
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
                      formsSum: widget._singleIVFormModel.calculateSum(),
                      maxSlots: _getSingleIVValue(maxIVFormState),
                    ),
                  ],
                  maxLines: 1,
                  onChanged: (String value) {
                    widget._maxIVFormCubit.getListAmount();
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

  int _getSingleIVValue(AMaxIVFormState maxIVFormState) {
    if (maxIVFormState is MaxIVFormListParsedState) {
      return maxIVFormState.maxIVList[0];
    }
    return 0;
  }

  int _calculateSingleIVAmountLeft(int inputWeight) {
    return widget._singleIVFormModel.calculateAmountLeft(inputWeight);
  }

  TextEditingController _getTextEditingController(int indexTextEditingControllerList) {
    return widget._singleIVFormModel.singleIVTextEditingControllersList[indexTextEditingControllerList];
  }
}
