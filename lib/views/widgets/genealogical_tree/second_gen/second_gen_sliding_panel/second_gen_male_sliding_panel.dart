import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_values.dart';
import 'package:breeder/shared/models/genealogical_tree/pairs_value.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree/generic/reset_button.dart';
import 'package:breeder/views/widgets/genealogical_tree/generic/attribute_buttons_widget.dart';
import 'package:breeder/views/widgets/genealogical_tree/generic/close_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenMaleSlidingPanel extends StatefulWidget {
  final PairsValues pairValue;

  const SecondGenMaleSlidingPanel({
    required this.pairValue,
    Key? key,
  }) : super(key: key);

  @override
  State<SecondGenMaleSlidingPanel> createState() => _SecondGenMaleSlidingPanelState();
}

class _SecondGenMaleSlidingPanelState extends State<SecondGenMaleSlidingPanel> {
  final SecondGenCubit secondGenCubit = globalLocator<SecondGenCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondGenCubit, ASecondGenState>(
      bloc: secondGenCubit,
      builder: (BuildContext context, ASecondGenState state) {
        List<bool> isEnabledList = secondGenCubit.getMaleButtonsState(widget.pairValue,);

        return Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ClosePanelWidget(),
              ),
              AttributeButtonsWidget(
                onPressedAtk: () => secondGenCubit.setMaleColors(widget.pairValue, IVValues.atkValue),
                onPressedHP: () => secondGenCubit.setMaleColors(widget.pairValue, IVValues.hpValue),
                onPressedSpAtk: () => secondGenCubit.setMaleColors(widget.pairValue, IVValues.spAtkValue),
                onPressedDef: () => secondGenCubit.setMaleColors(widget.pairValue, IVValues.defValue),
                onPressedSpDef: () => secondGenCubit.setMaleColors(widget.pairValue, IVValues.spDefValue),
                onPressedSpeed: () => secondGenCubit.setMaleColors(widget.pairValue, IVValues.speedValue),
                isEnabledAtk: isEnabledList[IVValues.atkValue.value],
                isEnabledHP: isEnabledList[IVValues.hpValue.value],
                isEnabledSpAtk: isEnabledList[IVValues.spAtkValue.value],
                isEnabledDef: isEnabledList[IVValues.defValue.value],
                isEnabledSpDef: isEnabledList[IVValues.spDefValue.value],
                isEnabledSpeed: isEnabledList[IVValues.speedValue.value],
              ),
              Expanded(
                child: ResetButton(
                  onPressed: () => secondGenCubit.setMaleDefaultColors(widget.pairValue),
                  isEnabled: secondGenCubit.isMaleRestartButtonEnabled(widget.pairValue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
