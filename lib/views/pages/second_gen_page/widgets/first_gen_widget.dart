import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/views/pages/second_gen_page/widgets/first_gen_female_button.dart';
import 'package:breeder/views/pages/second_gen_page/widgets/first_gen_male_button.dart';
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
