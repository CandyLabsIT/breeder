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

class SecondGenFemaleSlidingPanel extends StatefulWidget {
  final PairsValues pairValue;

  const SecondGenFemaleSlidingPanel({required this.pairValue,
    Key? key,
  }) : super(key: key);

  @override
  State<SecondGenFemaleSlidingPanel> createState() => _SecondGenFemaleSlidingPanelState();
}

class _SecondGenFemaleSlidingPanelState extends State<SecondGenFemaleSlidingPanel> {
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
        List<bool> isEnabledList = secondGenCubit.getFemaleButtonsState(widget.pairValue);

        return Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ClosePanelWidget(),
              ),
              AttributeButtonsWidget(
                onPressedAtk: () => secondGenCubit.setFemaleColors(widget.pairValue, IVValues.atkValue),
                onPressedHP: () => secondGenCubit.setFemaleColors(widget.pairValue, IVValues.hpValue),
                onPressedSpAtk: () => secondGenCubit.setFemaleColors(widget.pairValue, IVValues.spAtkValue),
                onPressedDef: () => secondGenCubit.setFemaleColors(widget.pairValue, IVValues.defValue),
                onPressedSpDef: () => secondGenCubit.setFemaleColors(widget.pairValue, IVValues.spDefValue),
                onPressedSpeed: () => secondGenCubit.setFemaleColors(widget.pairValue, IVValues.speedValue),
                isEnabledAtk: isEnabledList[IVValues.atkValue.value],
                isEnabledHP: isEnabledList[IVValues.hpValue.value],
                isEnabledSpAtk: isEnabledList[IVValues.spAtkValue.value],
                isEnabledDef: isEnabledList[IVValues.defValue.value],
                isEnabledSpDef: isEnabledList[IVValues.spDefValue.value],
                isEnabledSpeed: isEnabledList[IVValues.speedValue.value],
              ),
              Expanded(
                child: ResetButton(
                  onPressed: () => secondGenCubit.setFemaleDefaultColors(widget.pairValue),
                  isEnabled: secondGenCubit.isFemaleRestartButtonEnabled(widget.pairValue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}