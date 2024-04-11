import 'package:breeder/blocks/pages/max_iv_form/a_max_iv_form_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_form/states/max_iv_form_list_parsed_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/states/max_iv_form_sum_calculated_state.dart';
import 'package:breeder/views/pages/max_iv_form_page/max_iv_form_page.dart';
import 'package:breeder/views/pages/single_iv_creator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatorProcessWrapper extends StatefulWidget {
  const CreatorProcessWrapper({super.key});

  @override
  State<StatefulWidget> createState() => _CreatorProcessWrapper();
}

class _CreatorProcessWrapper extends State<CreatorProcessWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MaxIVFormCubit>(
      create: (BuildContext context) => MaxIVFormCubit(),
      child: BlocBuilder<MaxIVFormCubit, AMaxIVFormState>(
        builder: (BuildContext context, AMaxIVFormState ivTextFormsState) {
          late Widget currentView = MaxIVFormPage();

          if (ivTextFormsState is MaxIVFormSumCalculatedState) {
            if (ivTextFormsState.maxIVFormSum == 0) {
              currentView = MaxIVFormPage();
            }
          } else if (ivTextFormsState is MaxIVFormListParsedState) {
            if (ivTextFormsState.maxIVList[0] != 0) {
              currentView = const SingleIVCreatorPage();
            }
          }
          return currentView;
        },
      ),
    );
  }
}
