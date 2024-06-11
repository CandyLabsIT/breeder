import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:breeder/views/pages/genealogical_tree_page/second_gen_widgets/second_gen_female_button.dart';
import 'package:breeder/views/pages/genealogical_tree_page/second_gen_widgets/second_gen_male_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenWidget extends StatelessWidget {
  const SecondGenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SecondGenCubit secondGenCubit = context.read<SecondGenCubit>();

    return BlocBuilder<SecondGenCubit, ASecondGenState>(
      bloc: secondGenCubit,
      builder: (BuildContext context, ASecondGenState aSecondGenState) {
        final Map<SecondGenIndex, List<IVColor>> ivColorsMap = secondGenCubit.getIVColor();
        final Map<SecondGenIndex, bool> monsterButtonStateMap = secondGenCubit.getMonstersState();
        final int monsterAmount = secondGenCubit.getInheritedMonsterAmount();

        return SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (int i = 0; i < monsterAmount; i++)
                Padding(
                  padding: EdgeInsets.only(top: i == 0 ? 0 : 120.0),
                  child: i.isEven
                      ? SecondGenFemaleButton(
                          leftColor: ivColorsMap[SecondGenIndex.values[i]]![0].color,
                          rightColor: ivColorsMap[SecondGenIndex.values[i]]![1].color,
                          onPressed: () {},
                          isEnabledBool: monsterButtonStateMap[SecondGenIndex.values[i]]!,
                        )
                      : SecondGenMaleButton(
                          leftColor: ivColorsMap[SecondGenIndex.values[i]]![0].color,
                          rightColor: ivColorsMap[SecondGenIndex.values[i]]![1].color,
                          onPressed: () {},
                          isEnabledBool: monsterButtonStateMap[SecondGenIndex.values[i]]!,
                        ),
                ),
            ],
          ),
        );
      },
    );
  }
}
