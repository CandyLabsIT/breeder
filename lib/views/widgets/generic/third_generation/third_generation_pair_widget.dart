import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_gen_index.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/female/third_generation_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/male/third_generation_male_button.dart';
import 'package:flutter/material.dart';

class ThirdGenPairWidget extends StatelessWidget {
  final Map<ThirdGenIndex, List<IVColor>> colorsMap;
  final void Function(ThirdGenIndex index) onTogglePanel;

  const ThirdGenPairWidget({
    required this.colorsMap,
    required this.onTogglePanel,
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
                                    ThirdGenerationFemaleButton(
                                        leftColor: colorsMap[ThirdGenIndex.one]![0].color,
                                        middleColor: colorsMap[ThirdGenIndex.one]![1].color,
                                        rightColor: colorsMap[ThirdGenIndex.one]![2].color,
                                        onPressed: () {
                                          onTogglePanel(ThirdGenIndex.one);
                                        }),
                                    ThirdGenerationMaleButton(
                                        leftColor: colorsMap[ThirdGenIndex.two]![0].color,
                                        middleColor: colorsMap[ThirdGenIndex.two]![1].color,
                                        rightColor: colorsMap[ThirdGenIndex.two]![2].color,
                                        onPressed: () {
                                          onTogglePanel(ThirdGenIndex.two);
                                        }),
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
                                    ThirdGenerationFemaleButton(
                                        leftColor: colorsMap[ThirdGenIndex.three]![0].color,
                                        middleColor: colorsMap[ThirdGenIndex.three]![1].color,
                                        rightColor: colorsMap[ThirdGenIndex.three]![2].color,
                                        onPressed: () {
                                          onTogglePanel(ThirdGenIndex.three);
                                        }),
                                    ThirdGenerationMaleButton(
                                        leftColor: colorsMap[ThirdGenIndex.four]![0].color,
                                        middleColor: colorsMap[ThirdGenIndex.four]![1].color,
                                        rightColor: colorsMap[ThirdGenIndex.four]![2].color,
                                        onPressed: () {
                                          onTogglePanel(ThirdGenIndex.four);
                                        }),
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
                                    ThirdGenerationFemaleButton(
                                        leftColor: colorsMap[ThirdGenIndex.five]![0].color,
                                        middleColor: colorsMap[ThirdGenIndex.five]![1].color,
                                        rightColor: colorsMap[ThirdGenIndex.five]![2].color,
                                        onPressed: () {
                                          onTogglePanel(ThirdGenIndex.five);
                                        }),
                                    ThirdGenerationMaleButton(
                                        leftColor: colorsMap[ThirdGenIndex.six]![0].color,
                                        middleColor: colorsMap[ThirdGenIndex.six]![1].color,
                                        rightColor: colorsMap[ThirdGenIndex.six]![2].color,
                                        onPressed: () {
                                          onTogglePanel(ThirdGenIndex.six);
                                        }),
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
                                    ThirdGenerationFemaleButton(
                                        leftColor: colorsMap[ThirdGenIndex.seven]![0].color,
                                        middleColor: colorsMap[ThirdGenIndex.seven]![1].color,
                                        rightColor: colorsMap[ThirdGenIndex.seven]![2].color,
                                        onPressed: () {
                                          onTogglePanel(ThirdGenIndex.seven);
                                        }),
                                    ThirdGenerationMaleButton(
                                        leftColor: colorsMap[ThirdGenIndex.eight]![0].color,
                                        middleColor: colorsMap[ThirdGenIndex.eight]![1].color,
                                        rightColor: colorsMap[ThirdGenIndex.eight]![2].color,
                                        onPressed: () {
                                          onTogglePanel(ThirdGenIndex.eight);
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
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
