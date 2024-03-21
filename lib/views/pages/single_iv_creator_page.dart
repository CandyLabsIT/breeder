import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/max_iv_slots_page/a_iv_slots_amount_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_page/iv_slots_amount_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_slots_page/states/iv_slots_amount_list.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/widgets/buttons/custom_text_button.dart';
import 'package:breeder/views/widgets/generic/custom_container.dart';
import 'package:breeder/views/widgets/value_limit_input_formatter.dart';
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
    return BlocBuilder<IVSlotsAmountCubit, AIVTextFormsState>(
        builder: (BuildContext context, AIVTextFormsState ivTextFormsState) {
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
                      ValueLimitInputFormatter(
                        inputsSum: _value(ivTextFormsState),
                        inputWeight: 1,
                      ),
                    ],
                    onChanged: (_) {
                      context.read<IVSlotsAmountCubit>().ivSlotsAmountList();
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

  int _value(AIVTextFormsState ivTextFormsState) {
    if (ivTextFormsState is IVSlotsAmountListState) {
      int value = ivTextFormsState.slotsList[0];
      return value;
    }
    return 0;
  }
}