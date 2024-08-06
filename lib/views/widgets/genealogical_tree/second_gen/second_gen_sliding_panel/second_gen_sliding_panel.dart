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

class SecondGenSlidingPanel extends StatefulWidget {
  final SecondGenIndex secondGenIndex;

  const SecondGenSlidingPanel({required this.secondGenIndex,
    Key? key,
  }) : super(key: key);

  @override
  State<SecondGenSlidingPanel> createState() => _SecondGenSlidingPanelState();
}

class _SecondGenSlidingPanelState extends State<SecondGenSlidingPanel> {
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
        Map<IVColor, bool> isEnabledList = secondGenCubit.getButtonsState(widget.secondGenIndex);
        return Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ClosePanelWidget(),
              ),
              AttributeButtonsWidget(
                onPressedAtk: () => secondGenCubit.setColors(widget.secondGenIndex, IVColor.atkColor),
                onPressedHP: () => secondGenCubit.setColors(widget.secondGenIndex, IVColor.hpColor),
                onPressedSpAtk: () => secondGenCubit.setColors(widget.secondGenIndex, IVColor.spAtkColor),
                onPressedDef: () => secondGenCubit.setColors(widget.secondGenIndex, IVColor.defColor),
                onPressedSpDef: () => secondGenCubit.setColors(widget.secondGenIndex, IVColor.spDefColor),
                onPressedSpeed: () => secondGenCubit.setColors(widget.secondGenIndex, IVColor.speedColor),
                isEnabledAtk: isEnabledList[IVColor.atkColor]!,
                isEnabledHP: isEnabledList[IVColor.hpColor]!,
                isEnabledSpAtk: isEnabledList[IVColor.spAtkColor]!,
                isEnabledDef: isEnabledList[IVColor.defColor]!,
                isEnabledSpDef: isEnabledList[IVColor.spDefColor]!,
                isEnabledSpeed: isEnabledList[IVColor.speedColor]!,
              ),
              Expanded(
                child: ResetButton(
                  onPressed: () => secondGenCubit.setListDefaultColors(widget.secondGenIndex),
                  isEnabled: secondGenCubit.isRestartButtonEnabled(widget.secondGenIndex),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}