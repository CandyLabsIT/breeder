import 'package:breeder/blocks/pages/genealogical_tree/first_gen/a_first_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/first_gen_cubit.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/views/pages/genealogical_tree_page/first_gen_widgets/first_gen_female_button.dart';
import 'package:breeder/views/pages/genealogical_tree_page/first_gen_widgets/first_gen_male_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstGenWidget extends StatefulWidget {
  final void Function(FirstGenIndex index, VoidCallback) _onTogglePanel;

  const FirstGenWidget({
    required void Function(FirstGenIndex, void Function()) onTogglePanel,
    Key? key,
  })  : _onTogglePanel = onTogglePanel,
        super(key: key);

  @override
  State<FirstGenWidget> createState() => _FirstGenWidgetState();
}

class _FirstGenWidgetState extends State<FirstGenWidget> {
  @override
  Widget build(BuildContext context) {
    final FirstGenCubit firstGenCubit = context.read<FirstGenCubit>();

    final Map<FirstGenIndex, VoidCallback> buttonMethods = <FirstGenIndex, VoidCallback>{
      FirstGenIndex.one: firstGenCubit.setIVStateIndexOne,
      FirstGenIndex.two: firstGenCubit.setIVStateIndexTwo,
      FirstGenIndex.three: firstGenCubit.setIVStateIndexThree,
      FirstGenIndex.four: firstGenCubit.setIVStateIndexFour,
      FirstGenIndex.five: () {},
      FirstGenIndex.six: () {},
      FirstGenIndex.seven: () {},
      FirstGenIndex.eight: () {},
      FirstGenIndex.nine: () {},
      FirstGenIndex.ten: () {},
      FirstGenIndex.eleven: () {},
      FirstGenIndex.twelve: () {},
      FirstGenIndex.thirteen: () {},
      FirstGenIndex.fourteen: () {},
      FirstGenIndex.fifteen: () {},
      FirstGenIndex.sixteen: () {},
      FirstGenIndex.seventeen: () {},
      FirstGenIndex.eighteen: () {},
      FirstGenIndex.nineteen: () {},
      FirstGenIndex.twenty: () {},
      FirstGenIndex.twentyTwo: () {},
      FirstGenIndex.twentyThree: () {},
      FirstGenIndex.twentyFour: () {},
      FirstGenIndex.twentyFive: () {},
      FirstGenIndex.twentySix: () {},
      FirstGenIndex.twentySeven: () {},
      FirstGenIndex.twentyEight: () {},
      FirstGenIndex.twentyNine: () {},
      FirstGenIndex.thirty: () {},
      FirstGenIndex.thirtyOne: () {},
      FirstGenIndex.thirtyTwo: () {},
    };

    return BlocBuilder<FirstGenCubit, AFirstGenState>(
      bloc: firstGenCubit,
      builder: (BuildContext context, AFirstGenState aFirstGenState) {
        final Map<FirstGenIndex, List<IVColor>> ivColorsMap = firstGenCubit.getIVColors();
        final Map<FirstGenIndex, bool> monsterButtonStateMap = firstGenCubit.getMonstersEnabledState();
        final int monsterAmount = firstGenCubit.getMonstersNumber();

        return SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 0; i < monsterAmount; i += 2)
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FirstGenFemaleButton(
                          ivColor: ivColorsMap[FirstGenIndex.values[i]]![0].color,
                          onPressed: () {
                            final void Function() callback = buttonMethods[FirstGenIndex.values[i]]!;
                            callback();
                            widget._onTogglePanel(FirstGenIndex.values[i], callback);
                          },
                          isEnabledBool: monsterButtonStateMap[FirstGenIndex.values[i]]!,
                        ),
                        FirstGenMaleButton(
                          ivColor: ivColorsMap[FirstGenIndex.values[i + 1]]![0].color,
                          onPressed: () {
                            final void Function() callback = buttonMethods[FirstGenIndex.values[i + 1]]!;
                            callback();
                            widget._onTogglePanel(FirstGenIndex.values[i + 1], callback);
                          },
                          isEnabledBool: monsterButtonStateMap[FirstGenIndex.values[i + 1]]!,
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
