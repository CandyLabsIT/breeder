import 'package:breeder/blocks/pages/max_iv_slots_creator_page/a_max_iv_slots_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/max_iv_slots_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/states/max_iv_slots_sum_changed_state.dart';
import 'package:breeder/views/pages/max_iv_slots/max_iv_value_limit_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaxIVSlotsTextForm extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final MaxIVSlotsCubit ivSlotsAmountCubit = context.read<MaxIVSlotsCubit>();
    return BlocBuilder<MaxIVSlotsCubit, AMaxIVSlotsState>(
      bloc: ivSlotsAmountCubit,
      builder: (BuildContext context, AMaxIVSlotsState maxIVTextEditingControllersState) {
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
                      _ivTextInfo,
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
                  controller: ivSlotsAmountCubit.maxIVSlotsModel.maxIVTextEditingControllersList[_indexTextEditingControllerList],
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
                      helperText: '${ivSlotsAmountCubit.maxIVSlotsModel.calculateMaxIVAmountLeft(_inputWeight)} of ${_maxSlots} slots remaining',
                      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(_maxLength),
                    MaxIVValueLimitInputFormatter(
                      inputsSum: _textFormsSum(maxIVTextEditingControllersState),
                      inputWeight: _inputWeight,
                    ),
                  ],
                  maxLines: 1,
                  onChanged: (String value) {
                    ivSlotsAmountCubit.calculateMaxIVSlotsSum();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  int _textFormsSum(AMaxIVSlotsState maxIVTextEditingControllersState) {
    if (maxIVTextEditingControllersState is MaxIVSlotsSumChangedState) {
      return maxIVTextEditingControllersState.maxIVSlotsSum;
    }
    return 0;
  }
}
