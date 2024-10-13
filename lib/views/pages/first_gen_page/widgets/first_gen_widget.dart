import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/views/pages/first_gen_page/widgets/first_gen_female_button.dart';
import 'package:breeder/views/pages/first_gen_page/widgets/first_gen_male_button.dart';
import 'package:flutter/material.dart';

class FirstGenWidget extends StatelessWidget {
  final Map<FirstGenIndex, List<IVColor>> colorsMap;
  final Map<FirstGenIndex, bool> monsterButtonsMap;
  final void Function(FirstGenIndex index) onTogglePanel;

  const FirstGenWidget({
    required this.colorsMap,
    required this.onTogglePanel,
    required this.monsterButtonsMap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.one]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.one);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.one]!),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.two]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.two);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.two]!,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  children: <Widget>[
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.three]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.three);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.three]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.four]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.four);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.four]!,
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.five]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.five);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.five]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.six]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.six);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.six]!,
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.seven]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.seven);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.seven]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.eight]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.eight);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.eight]!,

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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.nine]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.nine);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.nine]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.ten]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.ten);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.ten]!,

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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.eleven]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.eleven);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.eleven]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.twelve]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.twelve);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.twelve]!,
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.thirteen]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.thirteen);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.thirteen]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.fourteen]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.fourteen);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.fourteen]!,
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.fifteen]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.fifteen);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.fifteen]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.sixteen]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.sixteen);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.sixteen]!,
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.seventeen]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.seventeen);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.seventeen]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.eighteen]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.eighteen);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.eighteen]!,
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.nineteen]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.nineteen);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.nineteen]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.twenty]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.twenty);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.twenty]!,
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.twentyOne]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.twentyOne);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.twentyOne]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.twentyTwo]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.twentyTwo);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.twentyTwo]!,
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.twentyThree]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.twentyThree);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.twentyThree]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.twentyFour]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.twentyFour);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.twentyFour]!,
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.twentyFive]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.twentyFive);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.twentyFive]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.twentySix]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.twentySix);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.twentySix]!,
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.twentySeven]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.twentySeven);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.twentySeven]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.twentyEight]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.twentyEight);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.twentyEight]!,
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.twentyNine]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.twentyNine);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.twentyNine]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.thirty]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.thirty);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.thirty]!,
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
                                    FirstGenFemaleButton(
                                      ivColor: colorsMap[FirstGenIndex.thirtyOne]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.thirtyOne);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.thirtyOne]!,
                                    ),
                                    FirstGenMaleButton(
                                      ivColor: colorsMap[FirstGenIndex.thirtyTwo]![0].color,
                                      onPressed: () {
                                        onTogglePanel(FirstGenIndex.thirtyTwo);
                                      },
                                      isEnabled: monsterButtonsMap[FirstGenIndex.thirtyTwo]!,
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
  }
}
