import 'package:breeder/blocks/pages/max_iv_slots_creator_page/a_max_iv_slots_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/max_iv_slots_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/states/max_iv_slots_amount_change_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/pages/max_iv_slots/max_iv_slots_creator_page.dart';
import 'package:breeder/views/pages/single_iv_creator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatorProcessWrapper extends StatefulWidget {
  final MaxIVSlotsCubit maxIVSlotsAmountCubit = globalLocator<MaxIVSlotsCubit>();

  CreatorProcessWrapper({super.key});

  @override
  State<StatefulWidget> createState() => _CreatorProcessWrapper();
}

class _CreatorProcessWrapper extends State<CreatorProcessWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaxIVSlotsCubit, AMaxIVSlotsState>(
      builder: (BuildContext context, AMaxIVSlotsState ivTextFormsState) {
        late Widget currentView;

        if (ivTextFormsState is MaxIVSlotsAmountChangedState) {
          if (ivTextFormsState.maxIVSlotsAmountList[0] == 0) {
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
