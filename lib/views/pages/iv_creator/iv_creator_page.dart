import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/views/pages/iv_creator/wrapper/creator_process_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class IVCreatorPage extends StatelessWidget {
  const IVCreatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MaxIVFormCubit>(
      create: (BuildContext context) => MaxIVFormCubit(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(child: CreatorProcessWrapper()),
        ),
      ),
    );
  }
}
