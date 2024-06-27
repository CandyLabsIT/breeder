import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/third_generation/a_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/third_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/widgets/generic/third_generation/third_generation_pair_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ThirdGenerationPage extends StatelessWidget {
  ThirdGenerationPage({super.key});

  final ThirdGenerationCubit thirdGenerationCubit = globalLocator<ThirdGenerationCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThirdGenerationCubit>(
      create: (BuildContext context) => ThirdGenerationCubit(),
      child: BlocBuilder<ThirdGenerationCubit, AThirdGenerationState>(
          bloc: thirdGenerationCubit,
          builder: (BuildContext context, AThirdGenerationState state) {
            return const Scaffold(
              body: Column(
                children: <Widget>[
                  ThirdGenerationPairWidget(listIndex: 0),
                  ThirdGenerationPairWidget(listIndex: 1),
                ],
              ),
            );
          }),
    );
  }
}
