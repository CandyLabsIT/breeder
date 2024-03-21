import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/max_iv_slots_page/iv_slots_amount_cubit.dart';
import 'package:breeder/views/pages/iv_creator/wrapper/creator_process_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class IVCreatorPage extends StatelessWidget {
  const IVCreatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IVSlotsAmountCubit>(
      create: (BuildContext context) => IVSlotsAmountCubit(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(child: CreatorProcessWrapper()),
        ),
      ),
    );
  }
}
