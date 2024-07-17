import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/second_generation/reset_button.dart';
import 'package:breeder/views/widgets/generic/genealogical_tree/attribute_buttons_widget.dart';
import 'package:breeder/views/widgets/generic/genealogical_tree/close_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenMaleSlidingPanel extends StatefulWidget {
  const SecondGenMaleSlidingPanel({super.key});

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
        List<bool> isEnabledList = secondGenCubit.isMaleButtonsEnabled();

        return Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ClosePanelWidget(),
              ),
              AttributeButtonsWidget(
                onPressedAtk: () => secondGenCubit.getIVMaleColors(1),
                onPressedHP: () => secondGenCubit.getIVMaleColors(2),
                onPressedSpAtk: () => secondGenCubit.getIVMaleColors(3),
                onPressedDef: () => secondGenCubit.getIVMaleColors(4),
                onPressedSpDef: () => secondGenCubit.getIVMaleColors(5),
                onPressedSpeed: () => secondGenCubit.getIVMaleColors(6),
                isEnabledAtk: isEnabledList[1],
                isEnabledHP: isEnabledList[2],
                isEnabledSpAtk: isEnabledList[3],
                isEnabledDef: isEnabledList[4],
                isEnabledSpDef: isEnabledList[5],
                isEnabledSpeed: isEnabledList[6],
              ),
              Expanded(
                child: ResetButton(
                  onPressed: secondGenCubit.restoreMaleDefaultColors,
                  isEnabled: secondGenCubit.isMaleRestartButtonEnabled(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}