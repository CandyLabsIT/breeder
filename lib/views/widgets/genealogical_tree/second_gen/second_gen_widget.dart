import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_gen_index.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree/second_gen/female/second_gen_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree/second_gen/male/second_gen_male_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree/third_gen/female/third_gen_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree/third_gen/male/third_gen_male_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenWidget extends StatelessWidget {
  final SecondGenCubit secondGenCubit = SecondGenCubit();
  final Map<SecondGenIndex, List<IVColor>> colorsMap;
  final void Function(SecondGenIndex index) onTogglePanel;

  SecondGenWidget({
    required this.colorsMap,
    required this.onTogglePanel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondGenCubit, ASecondGenState>(
      bloc: secondGenCubit,
      builder: (BuildContext context, ASecondGenState state) {
        final Map<ThirdGenIndex, List<IVColor>> childrenMap = secondGenCubit.getChildren();
        print("widget ${childrenMap[ThirdGenIndex.one]}");
        return SizedBox(
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      children: <Widget>[
                                        SecondGenFemaleButton(
                                          leftColor: colorsMap[SecondGenIndex.one]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.one]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.one);
                                          },
                                        ),
                                        SecondGenMaleButton(
                                          leftColor: colorsMap[SecondGenIndex.two]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.two]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.two);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: <Widget>[
                                        ThirdGenFemaleButton(
                                          leftColor: childrenMap[ThirdGenIndex.one]![0].color,
                                          middleColor: childrenMap[ThirdGenIndex.one]![1].color,
                                          rightColor: childrenMap[ThirdGenIndex.one]![2].color,
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      children: <Widget>[
                                        SecondGenFemaleButton(
                                          leftColor: colorsMap[SecondGenIndex.three]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.three]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.three);
                                          },
                                        ),
                                        SecondGenMaleButton(
                                          leftColor: colorsMap[SecondGenIndex.four]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.four]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.four);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: <Widget>[
                                        ThirdGenMaleButton(
                                          leftColor: childrenMap[ThirdGenIndex.two]![0].color,
                                          middleColor: childrenMap[ThirdGenIndex.two]![1].color,
                                          rightColor: childrenMap[ThirdGenIndex.two]![2].color,
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      children: <Widget>[
                                        SecondGenFemaleButton(
                                          leftColor: colorsMap[SecondGenIndex.five]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.five]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.five);
                                          },
                                        ),
                                        SecondGenMaleButton(
                                          leftColor: colorsMap[SecondGenIndex.six]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.six]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.six);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      children: <Widget>[
                                        SecondGenFemaleButton(
                                          leftColor: colorsMap[SecondGenIndex.seven]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.seven]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.seven);
                                          },
                                        ),
                                        SecondGenMaleButton(
                                          leftColor: colorsMap[SecondGenIndex.eight]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.eight]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.eight);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      children: <Widget>[
                                        SecondGenFemaleButton(
                                          leftColor: colorsMap[SecondGenIndex.nine]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.nine]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.nine);
                                          },
                                        ),
                                        SecondGenMaleButton(
                                          leftColor: colorsMap[SecondGenIndex.ten]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.ten]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.ten);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      children: <Widget>[
                                        SecondGenFemaleButton(
                                          leftColor: colorsMap[SecondGenIndex.eleven]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.eleven]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.eleven);
                                          },
                                        ),
                                        SecondGenMaleButton(
                                          leftColor: colorsMap[SecondGenIndex.twelve]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.twelve]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.twelve);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      children: <Widget>[
                                        SecondGenFemaleButton(
                                          leftColor: colorsMap[SecondGenIndex.thirteen]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.thirteen]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.thirteen);
                                          },
                                        ),
                                        SecondGenMaleButton(
                                          leftColor: colorsMap[SecondGenIndex.fourteen]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.fourteen]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.fourteen);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      children: <Widget>[
                                        SecondGenFemaleButton(
                                          leftColor: colorsMap[SecondGenIndex.fifteen]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.fifteen]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.fifteen);
                                          },
                                        ),
                                        SecondGenMaleButton(
                                          leftColor: colorsMap[SecondGenIndex.sixteen]![0].color,
                                          rightColor: colorsMap[SecondGenIndex.sixteen]![1].color,
                                          onPressed: () {
                                            onTogglePanel(SecondGenIndex.sixteen);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
