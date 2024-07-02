import 'package:breeder/blocks/pages/third_generation/a_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/third_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/second_generation/reset_button.dart';
import 'package:breeder/views/widgets/generic/genealogical_tree/attribute_buttons_widget.dart';
import 'package:breeder/views/widgets/generic/genealogical_tree/close_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdGenerationMaleSlidingPanel extends StatefulWidget {
  final int listIndex;

  const ThirdGenerationMaleSlidingPanel({
    required this.listIndex,
    Key? key,}) : super(key: key) ;

  @override
  State<ThirdGenerationMaleSlidingPanel> createState() => _ThirdGenerationMaleSlidingPanelState();
}

class _ThirdGenerationMaleSlidingPanelState extends State<ThirdGenerationMaleSlidingPanel> {
  final ThirdGenerationCubit thirdGenerationCubit = globalLocator<ThirdGenerationCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdGenerationCubit, AThirdGenerationState>(
      bloc: thirdGenerationCubit,
      builder: (BuildContext context, AThirdGenerationState state) {
        // List<bool> isEnabledList = thirdGenerationCubit.isFemaleButtonsEnabled();

        return Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ClosePanelWidget(),
              ),
              AttributeButtonsWidget(
                onPressedAtk: () => thirdGenerationCubit.getMaleColors(widget.listIndex, 1),
                onPressedHP: () => thirdGenerationCubit.getMaleColors(widget.listIndex, 2),
                onPressedSpAtk: () => thirdGenerationCubit.getMaleColors(widget.listIndex, 3),
                onPressedDef: () => thirdGenerationCubit.getMaleColors(widget.listIndex, 4),
                onPressedSpDef: () => thirdGenerationCubit.getMaleColors(widget.listIndex, 5),
                onPressedSpeed: () => thirdGenerationCubit.getMaleColors(widget.listIndex, 6),
                isEnabledAtk: true,
                isEnabledHP: true,
                isEnabledSpAtk: true,
                isEnabledDef: true,
                isEnabledSpDef: true,
                isEnabledSpeed: true,
              ),
              Expanded(
                child: ResetButton(
                  onPressed: () => thirdGenerationCubit.resetThirdMaleValues(widget.listIndex),
                  isEnabled: thirdGenerationCubit.isMaleRestartButtonEnabled(widget.listIndex),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
