import 'package:breeder/blocks/pages/genealogical_tree/first_gen/a_first_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/first_gen_cubit.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/views/widgets/genealogical_tree/sliding_panel/attribute_buttons.dart';
import 'package:breeder/views/widgets/genealogical_tree/sliding_panel/buttons/reset_button.dart';
import 'package:breeder/views/widgets/genealogical_tree/sliding_panel/close_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstGenSlidingPanel extends StatefulWidget {
  final FirstGenIndex _firstGenIndex;
  final VoidCallback _setIVButtonMethod;

  const FirstGenSlidingPanel({
    required FirstGenIndex firstGenIndex,
    required void Function() setIVButtonMethod,
    Key? key,
  })  : _firstGenIndex = firstGenIndex,
        _setIVButtonMethod = setIVButtonMethod,
        super(key: key);

  @override
  State<FirstGenSlidingPanel> createState() => _FirstGenSlidingPanelState();
}

class _FirstGenSlidingPanelState extends State<FirstGenSlidingPanel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirstGenCubit firstGenCubit = context.read<FirstGenCubit>();

    return BlocBuilder<FirstGenCubit, AFirstGenState>(
      bloc: firstGenCubit,
      builder: (BuildContext context, AFirstGenState firstGenState) {
        Map<IVColor, bool> isEnabledList = firstGenCubit.getIVButtonsState();

        return Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ClosePanelWidget(),
              ),
              AttributeButtons(
                onPressedAtk: () {
                  firstGenCubit.setIVColors(widget._firstGenIndex, IVColor.atkColor);
                  widget._setIVButtonMethod();
                },
                onPressedHP: () {
                  firstGenCubit.setIVColors(widget._firstGenIndex, IVColor.hpColor);
                  widget._setIVButtonMethod();
                },
                onPressedSpAtk: () {
                  firstGenCubit.setIVColors(widget._firstGenIndex, IVColor.spAtkColor);
                  widget._setIVButtonMethod();
                },
                onPressedDef: () {
                  firstGenCubit.setIVColors(widget._firstGenIndex, IVColor.defColor);
                  widget._setIVButtonMethod();
                },
                onPressedSpDef: () {
                  firstGenCubit.setIVColors(widget._firstGenIndex, IVColor.spDefColor);
                  widget._setIVButtonMethod();
                },
                onPressedSpeed: () {
                  firstGenCubit.setIVColors(widget._firstGenIndex, IVColor.speedColor);
                  widget._setIVButtonMethod();
                },
                isEnabledAtk: isEnabledList[IVColor.atkColor]!,
                isEnabledHP: isEnabledList[IVColor.hpColor]!,
                isEnabledSpAtk: isEnabledList[IVColor.spAtkColor]!,
                isEnabledDef: isEnabledList[IVColor.defColor]!,
                isEnabledSpDef: isEnabledList[IVColor.spDefColor]!,
                isEnabledSpeed: isEnabledList[IVColor.speedColor]!,
              ),
              Expanded(
                child: ResetButton(
                  onPressed: () => firstGenCubit.resetMonsterToDefaultIVColors(widget._firstGenIndex),
                  isEnabled: firstGenCubit.isRestartButtonEnabled(widget._firstGenIndex),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
