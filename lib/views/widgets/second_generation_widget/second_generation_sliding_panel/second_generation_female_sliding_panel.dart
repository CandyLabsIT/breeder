import 'package:breeder/blocks/pages/second_generation/a_second_generation_state.dart';
import 'package:breeder/blocks/pages/second_generation/second_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/second_generation/reset_button.dart';
import 'package:breeder/views/widgets/generic/genealogical_tree/attribute_buttons_widget.dart';
import 'package:breeder/views/widgets/generic/genealogical_tree/close_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenerationFemaleSlidingPanel extends StatefulWidget {
  const SecondGenerationFemaleSlidingPanel({super.key});

  @override
  State<SecondGenerationFemaleSlidingPanel> createState() => _SecondGenerationFemaleSlidingPanelState();
}

class _SecondGenerationFemaleSlidingPanelState extends State<SecondGenerationFemaleSlidingPanel> {
  final SecondGenerationCubit secondGenerationCubit = globalLocator<SecondGenerationCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondGenerationCubit, ASecondGenerationState>(
      bloc: secondGenerationCubit,
      builder: (BuildContext context, ASecondGenerationState state) {
        List<bool> isEnabledList = secondGenerationCubit.isFemaleButtonsEnabled();

        return Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ClosePanelWidget(),
              ),
              AttributeButtonsWidget(
                onPressedAtk: () => secondGenerationCubit.getIVFemaleColors(1),
                onPressedHP: () => secondGenerationCubit.getIVFemaleColors(2),
                onPressedSpAtk: () => secondGenerationCubit.getIVFemaleColors(3),
                onPressedDef: () => secondGenerationCubit.getIVFemaleColors(4),
                onPressedSpDef: () => secondGenerationCubit.getIVFemaleColors(5),
                onPressedSpeed: () => secondGenerationCubit.getIVFemaleColors(6),
                isEnabledAtk: isEnabledList[1],
                isEnabledHP: isEnabledList[2],
                isEnabledSpAtk: isEnabledList[3],
                isEnabledDef: isEnabledList[4],
                isEnabledSpDef: isEnabledList[5],
                isEnabledSpeed: isEnabledList[6],
              ),
              Expanded(
                child: ResetButton(
                  onPressed: secondGenerationCubit.restoreFemaleDefaultColors,
                  isEnabled: secondGenerationCubit.isFemaleRestartButtonEnabled(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}