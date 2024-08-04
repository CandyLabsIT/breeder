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

class SecondGenFemaleSlidingPanel extends StatefulWidget {
  final SecondGenIndex index;

  const SecondGenFemaleSlidingPanel({required this.index,
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
        Map<IVColor, bool> isEnabledList = secondGenCubit.getButtonsState(widget.index);
        return Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ClosePanelWidget(),
              ),
              AttributeButtonsWidget(
                onPressedAtk: () => secondGenCubit.setFemaleColors(widget.index, IVColor.atkColor),
                onPressedHP: () => secondGenCubit.setFemaleColors(widget.index, IVColor.hpColor),
                onPressedSpAtk: () => secondGenCubit.setFemaleColors(widget.index, IVColor.spAtkColor),
                onPressedDef: () => secondGenCubit.setFemaleColors(widget.index, IVColor.defColor),
                onPressedSpDef: () => secondGenCubit.setFemaleColors(widget.index, IVColor.spDefColor),
                onPressedSpeed: () => secondGenCubit.setFemaleColors(widget.index, IVColor.speedColor),
                isEnabledAtk: isEnabledList[IVColor.atkColor]!,
                isEnabledHP: isEnabledList[IVColor.hpColor]!,
                isEnabledSpAtk: isEnabledList[IVColor.spAtkColor]!,
                isEnabledDef: isEnabledList[IVColor.defColor]!,
                isEnabledSpDef: isEnabledList[IVColor.spDefColor]!,
                isEnabledSpeed: isEnabledList[IVColor.speedColor]!,
              ),
              Expanded(
                child: ResetButton(
                  onPressed: () => secondGenCubit.setFemaleListDefaultColors(widget.index),
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