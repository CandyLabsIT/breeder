import 'package:breeder/blocks/pages/genealogical_tree/first_gen/a_first_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/first_gen_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/views/widgets/genealogical_tree/attribute_buttons_widget.dart';
import 'package:breeder/views/widgets/genealogical_tree/buttons/reset_button.dart';
import 'package:breeder/views/widgets/genealogical_tree/close_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstGenSlidingPanel extends StatefulWidget {
  final FirstGenIndex firstGenIndex;

  const FirstGenSlidingPanel({
    required this.firstGenIndex,
    Key? key,
  }) : super(key: key);

  @override
  State<FirstGenSlidingPanel> createState() => _FirstGenSlidingPanelState();
}

class _FirstGenSlidingPanelState extends State<FirstGenSlidingPanel> {
  final FirstGenCubit firsGenCubit = globalLocator<FirstGenCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstGenCubit, ASecondGenState>(
      bloc: firsGenCubit,
      builder: (BuildContext context, ASecondGenState state) {
        Map<IVColor, bool> isEnabledList = firsGenCubit.getIVButtonsState(widget.firstGenIndex);
        return Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ClosePanelWidget(),
              ),
              AttributeButtonsWidget(
                onPressedAtk: () => firsGenCubit.setColors(widget.firstGenIndex, IVColor.atkColor),
                onPressedHP: () => firsGenCubit.setColors(widget.firstGenIndex, IVColor.hpColor),
                onPressedSpAtk: () => firsGenCubit.setColors(widget.firstGenIndex, IVColor.spAtkColor),
                onPressedDef: () => firsGenCubit.setColors(widget.firstGenIndex, IVColor.defColor),
                onPressedSpDef: () => firsGenCubit.setColors(widget.firstGenIndex, IVColor.spDefColor),
                onPressedSpeed: () => firsGenCubit.setColors(widget.firstGenIndex, IVColor.speedColor),
                isEnabledAtk: isEnabledList[IVColor.atkColor]!,
                isEnabledHP: isEnabledList[IVColor.hpColor]!,
                isEnabledSpAtk: isEnabledList[IVColor.spAtkColor]!,
                isEnabledDef: isEnabledList[IVColor.defColor]!,
                isEnabledSpDef: isEnabledList[IVColor.spDefColor]!,
                isEnabledSpeed: isEnabledList[IVColor.speedColor]!,
              ),
              Expanded(
                child: ResetButton(
                  onPressed: () => firsGenCubit.resetMonsterToDefaultIVColors(widget.firstGenIndex),
                  isEnabled: firsGenCubit.isRestartButtonEnabled(widget.firstGenIndex),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
