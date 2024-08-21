import 'package:breeder/blocks/pages/genealogical_tree/third_generation/a_third_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/third_generation/third_gen_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_gen_index.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree/generic/reset_button.dart';
import 'package:breeder/views/widgets/genealogical_tree/generic/attribute_buttons_widget.dart';
import 'package:breeder/views/widgets/genealogical_tree/generic/close_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdGeSlidingPanel extends StatefulWidget {
  final ThirdGenIndex thirdGenIndex;

  const ThirdGeSlidingPanel({
    required this.thirdGenIndex,
    Key? key,}) : super(key: key) ;

  @override
  State<ThirdGeSlidingPanel> createState() => _ThirdGeSlidingPanelState();
}

class _ThirdGeSlidingPanelState extends State<ThirdGeSlidingPanel> {
  final ThirdGenCubit thirdGenCubit = globalLocator<ThirdGenCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdGenCubit, AThirdGenState>(
      bloc: thirdGenCubit,
      builder: (BuildContext context, AThirdGenState state) {
        Map<IVColor, bool> isEnabledList = thirdGenCubit.getButtonState(widget.thirdGenIndex);

        return Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ClosePanelWidget(),
              ),
              AttributeButtonsWidget(
                onPressedAtk: () => thirdGenCubit.setColors(widget.thirdGenIndex, IVColor.atkColor),
                onPressedHP: () => thirdGenCubit.setColors(widget.thirdGenIndex, IVColor.hpColor),
                onPressedSpAtk: () => thirdGenCubit.setColors(widget.thirdGenIndex, IVColor.spAtkColor),
                onPressedDef: () => thirdGenCubit.setColors(widget.thirdGenIndex, IVColor.defColor),
                onPressedSpDef: () => thirdGenCubit.setColors(widget.thirdGenIndex, IVColor.spDefColor),
                onPressedSpeed: () => thirdGenCubit.setColors(widget.thirdGenIndex, IVColor.speedColor),
                isEnabledAtk: isEnabledList[IVColor.atkColor]!,
                isEnabledHP: isEnabledList[IVColor.hpColor]!,
                isEnabledSpAtk: isEnabledList[IVColor.spAtkColor]!,
                isEnabledDef: isEnabledList[IVColor.defColor]!,
                isEnabledSpDef: isEnabledList[IVColor.spDefColor]!,
                isEnabledSpeed: isEnabledList[IVColor.speedColor]!,
              ),
              Expanded(
                child: ResetButton(
                  onPressed: () => thirdGenCubit.resetIVListToDefaultColors(widget.thirdGenIndex),
                  isEnabled: thirdGenCubit.isRestartButtonEnabled(widget.thirdGenIndex),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
