import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/a_max_iv_slots_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/max_iv_slots_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/states/max_iv_slots_amount_change_state.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/pages/max_iv_slots/max_iv_value_limit_input_formatter.dart';
import 'package:breeder/views/widgets/buttons/custom_text_button.dart';
import 'package:breeder/views/widgets/generic/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// @RoutePage()
class SingleIVCreatorPage extends StatefulWidget {
  const SingleIVCreatorPage({Key? key}) : super(key: key);

  @override
  _SingleIVCreatorState createState() => _SingleIVCreatorState();
}


class _SingleIVCreatorState extends State<SingleIVCreatorPage>{
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaxIVSlotsCubit, AMaxIVSlotsState>(
        builder: (BuildContext context, AMaxIVSlotsState maxIVSlotsState) {
          return CustomContainer(
              containerHeight: 450,
              containerWidth: 350,
              columnItems: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
                  child: const Text(
                    'Input the number of monsters with one IVs',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    controller: textEditingController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                      MaxIVValueLimitInputFormatter(
                        inputsSum: _value(maxIVSlotsState),
                        inputWeight: 1,
                      ),
                    ],
                    onChanged: (_) {
                      context.read<MaxIVSlotsCubit>().maxIVSlotsAmountList();
                    },
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        const CustomTextButton(
                          buttonText: 'Back',
                          icon: Icons.navigate_before,
                          leftMargin: 25,
                          // onPressed: () => AutoRouter.of(context).push(const MaxIVSlotsCreatorRoute()),
                        ),
                        CustomTextButton(
                          buttonText: 'Cancel',
                          icon: Icons.cancel,
                          leftMargin: 25,
                          onPressed: () => AutoRouter.of(context).push(const MainMenuRoute()),
                        ),
                        const CustomTextButton(
                          buttonText: 'Next',
                          icon: Icons.navigate_next,
                          leftMargin: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
          );
        },
    );
  }

  int _value(AMaxIVSlotsState maxIVSlotsState) {
    if (maxIVSlotsState is MaxIVSlotsAmountChangedState) {
      int value = maxIVSlotsState.maxIVSlotsAmountList[0];
      return value;
    }
    return 0;
  }
}