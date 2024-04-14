import 'package:breeder/blocks/pages/max_iv_form/a_max_iv_form_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_form/states/max_iv_form_list_parsed_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/pages/max_iv_form_page/max_iv_form_page.dart';
import 'package:breeder/views/pages/single_iv_form_page/single_iv_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatorProcessWrapper extends StatefulWidget {
  final MaxIVFormCubit _maxIVFormCubit = globalLocator<MaxIVFormCubit>();

  CreatorProcessWrapper({super.key});

  @override
  State<StatefulWidget> createState() => _CreatorProcessWrapper();
}

class _CreatorProcessWrapper extends State<CreatorProcessWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaxIVFormCubit, AMaxIVFormState>(
      bloc: widget._maxIVFormCubit,
      builder: (BuildContext context, AMaxIVFormState ivTextFormsState) {
        late Widget currentView = MaxIVFormPage();

        if (ivTextFormsState is MaxIVFormListParsedState) {
          if (ivTextFormsState.maxIVList.isNotEmpty && ivTextFormsState.maxIVList[0] > 0) {
            currentView = SingleIVFormPage();
          }
         else {
            currentView = MaxIVFormPage();
          }
        }
        return currentView;
      },
    );
  }
}
