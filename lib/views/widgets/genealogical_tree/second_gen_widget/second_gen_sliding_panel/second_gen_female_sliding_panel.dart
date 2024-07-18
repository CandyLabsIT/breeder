import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/second_gen/reset_button.dart';
import 'package:breeder/views/widgets/generic/genealogical_tree/attribute_buttons_widget.dart';
import 'package:breeder/views/widgets/generic/genealogical_tree/close_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenFemaleSlidingPanel extends StatefulWidget {
  const SecondGenFemaleSlidingPanel({super.key});

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
        List<bool> isEnabledList = secondGenCubit.isFemaleButtonsEnabled();

        return Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ClosePanelWidget(),
              ),
              AttributeButtonsWidget(
                onPressedAtk: () => secondGenCubit.getIVFemaleColors(1),
                onPressedHP: () => secondGenCubit.getIVFemaleColors(2),
                onPressedSpAtk: () => secondGenCubit.getIVFemaleColors(3),
                onPressedDef: () => secondGenCubit.getIVFemaleColors(4),
                onPressedSpDef: () => secondGenCubit.getIVFemaleColors(5),
                onPressedSpeed: () => secondGenCubit.getIVFemaleColors(6),
                isEnabledAtk: isEnabledList[1],
                isEnabledHP: isEnabledList[2],
                isEnabledSpAtk: isEnabledList[3],
                isEnabledDef: isEnabledList[4],
                isEnabledSpDef: isEnabledList[5],
                isEnabledSpeed: isEnabledList[6],
              ),
              Expanded(
                child: ResetButton(
                  onPressed: secondGenCubit.restoreFemaleDefaultColors,
                  isEnabled: secondGenCubit.isFemaleRestartButtonEnabled(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}