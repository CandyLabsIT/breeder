import 'package:breeder/blocks/pages/iv_creator_form/a_iv_creator_form_state.dart';
import 'package:breeder/blocks/pages/iv_creator_form/iv_creator_form_cubit.dart';
import 'package:breeder/blocks/pages/iv_creator_form/state/iv_creator_form_back_button_pressed_state.dart';
import 'package:breeder/blocks/pages/iv_creator_form/state/iv_creator_form_next_button_pressed_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/pages/max_iv_form_page/max_iv_form_page.dart';
import 'package:breeder/views/pages/single_iv_form_page/single_iv_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatorProcessWrapper extends StatefulWidget {
  const CreatorProcessWrapper({super.key});

  @override
  State<StatefulWidget> createState() => _CreatorProcessWrapper();
}

class _CreatorProcessWrapper extends State<CreatorProcessWrapper> {
  late IVCreatorFormCubit ivCreatorFormCubit = globalLocator<IVCreatorFormCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ivCreatorFormCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IVCreatorFormCubit, AIVCreatorFormState>(
      bloc: ivCreatorFormCubit,
      builder: (BuildContext context, AIVCreatorFormState ivCreatorFormState) {
        late Widget currentView = MaxIVFormPage();
        late int viewIndex;

        if (ivCreatorFormState is IVCreatorFormNextButtonPressedState) {
          viewIndex = ivCreatorFormState.getNextView;
          switch(viewIndex){
            case 2:
              currentView = SingleIVFormPage();
              break;
          }
        } else if (ivCreatorFormState is IVCreatorFormBackButtonPressedState){
          viewIndex = ivCreatorFormState.getPreviousView;
          switch(viewIndex){
            case 1:
              currentView = MaxIVFormPage();
          }
        } else {
          return MaxIVFormPage();
        }
        return currentView;
      },
    );
  }
}
