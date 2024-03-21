import 'package:breeder/blocks/pages/max_iv_slots_page/a_iv_slots_amount_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_page/iv_slots_amount_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_slots_page/states/iv_slots_sum_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/pages/max_iv_slots/max_iv_slots_creator_page.dart';
import 'package:breeder/views/pages/single_iv_creator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatorProcessWrapper extends StatefulWidget {
  final IVSlotsAmountCubit ivSlotsAmountCubit = globalLocator<IVSlotsAmountCubit>();

  CreatorProcessWrapper({super.key});

  @override
  State<StatefulWidget> createState() => _CreatorProcessWrapper();
}

class _CreatorProcessWrapper extends State<CreatorProcessWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IVSlotsAmountCubit, AIVTextFormsState>(
      builder: (BuildContext context, AIVTextFormsState ivTextFormsState) {
        late Widget currentView;

        if (ivTextFormsState is IVTextFormValueChangedState) {
          if (ivTextFormsState.textFormsSum == 0) {
            currentView = const MaxIVSlotsCreatorPage();
          } else {
            currentView = const SingleIVCreatorPage();
          }
        } else{

          currentView = const MaxIVSlotsCreatorPage();
        }
        return currentView;
      }
    );
  }
}
