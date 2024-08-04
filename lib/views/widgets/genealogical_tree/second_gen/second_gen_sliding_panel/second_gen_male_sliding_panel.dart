import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen_index.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree/generic/reset_button.dart';
import 'package:breeder/views/widgets/genealogical_tree/generic/attribute_buttons_widget.dart';
import 'package:breeder/views/widgets/genealogical_tree/generic/close_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenMaleSlidingPanel extends StatefulWidget {
  final SecondGenIndex index;

  const SecondGenMaleSlidingPanel({
    required this.index,
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
        Map<IVColor, bool> isEnabledList = secondGenCubit.getButtonsState(widget.index,);
        return Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ClosePanelWidget(),
              ),
              AttributeButtonsWidget(
                onPressedAtk: () => secondGenCubit.setColors(widget.index, IVColor.atkColor),
                onPressedHP: () => secondGenCubit.setColors(widget.index, IVColor.hpColor),
                onPressedSpAtk: () => secondGenCubit.setColors(widget.index, IVColor.spAtkColor),
                onPressedDef: () => secondGenCubit.setColors(widget.index, IVColor.defColor),
                onPressedSpDef: () => secondGenCubit.setColors(widget.index, IVColor.spDefColor),
                onPressedSpeed: () => secondGenCubit.setColors(widget.index, IVColor.speedColor),
                isEnabledAtk: isEnabledList[IVColor.atkColor]!,
                isEnabledHP: isEnabledList[IVColor.hpColor]!,
                isEnabledSpAtk: isEnabledList[IVColor.spAtkColor]!,
                isEnabledDef: isEnabledList[IVColor.defColor]!,
                isEnabledSpDef: isEnabledList[IVColor.spDefColor]!,
                isEnabledSpeed: isEnabledList[IVColor.speedColor]!,
              ),
              Expanded(
                child: ResetButton(
                  onPressed: () => secondGenCubit.setListDefaultColors(widget.index),
                  isEnabled: secondGenCubit.isRestartButtonEnabled(widget.index),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
