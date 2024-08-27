import 'package:breeder/blocks/pages/genealogical_tree/third_generation/a_third_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/third_generation/third_gen_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_gen_index.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree/third_gen/female/third_gen_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree/third_gen/male/third_gen_male_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdGenWidget extends StatelessWidget {
  final ThirdGenCubit thirdGenCubit = globalLocator<ThirdGenCubit>();
  final Map<ThirdGenIndex, List<IVColor>> colorsMap;
  final void Function(ThirdGenIndex index) onTogglePanel;

  ThirdGenWidget({
    required this.colorsMap,
    required this.onTogglePanel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdGenCubit, AThirdGenState>(
      bloc: thirdGenCubit,
      builder: (BuildContext context, AThirdGenState state) {
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
                                        ThirdGenFemaleButton(
                                          leftColor: colorsMap[ThirdGenIndex.one]![0].color,
                                          middleColor: colorsMap[ThirdGenIndex.one]![1].color,
                                          rightColor: colorsMap[ThirdGenIndex.one]![2].color,
                                          onPressed: () => handleButtonPress(ThirdGenIndex.one),
                                        ),
                                        ThirdGenMaleButton(
                                          leftColor: colorsMap[ThirdGenIndex.two]![0].color,
                                          middleColor: colorsMap[ThirdGenIndex.two]![1].color,
                                          rightColor: colorsMap[ThirdGenIndex.two]![2].color,
                                          onPressed: () => handleButtonPress(ThirdGenIndex.two),
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
                                        ThirdGenFemaleButton(
                                          leftColor: colorsMap[ThirdGenIndex.three]![0].color,
                                          middleColor: colorsMap[ThirdGenIndex.three]![1].color,
                                          rightColor: colorsMap[ThirdGenIndex.three]![2].color,
                                          onPressed: () => handleButtonPress(ThirdGenIndex.three),
                                        ),
                                        ThirdGenMaleButton(
                                          leftColor: colorsMap[ThirdGenIndex.four]![0].color,
                                          middleColor: colorsMap[ThirdGenIndex.four]![1].color,
                                          rightColor: colorsMap[ThirdGenIndex.four]![2].color,
                                          onPressed: () => handleButtonPress(ThirdGenIndex.four),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(children: <Widget>[
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    children: <Widget>[
                                      ThirdGenFemaleButton(
                                        leftColor: colorsMap[ThirdGenIndex.five]![0].color,
                                        middleColor: colorsMap[ThirdGenIndex.five]![1].color,
                                        rightColor: colorsMap[ThirdGenIndex.five]![2].color,
                                        onPressed: () => handleButtonPress(ThirdGenIndex.five),
                                      ),
                                      ThirdGenMaleButton(
                                          leftColor: colorsMap[ThirdGenIndex.six]![0].color,
                                          middleColor: colorsMap[ThirdGenIndex.six]![1].color,
                                          rightColor: colorsMap[ThirdGenIndex.six]![2].color,
                                          onPressed: () => handleButtonPress(ThirdGenIndex.six)),
                                    ],
                                  ),
                                )
                              ]),
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      children: <Widget>[
                                        ThirdGenFemaleButton(
                                          leftColor: colorsMap[ThirdGenIndex.seven]![0].color,
                                          middleColor: colorsMap[ThirdGenIndex.seven]![1].color,
                                          rightColor: colorsMap[ThirdGenIndex.seven]![2].color,
                                          onPressed: () => handleButtonPress(ThirdGenIndex.seven),
                                        ),
                                        ThirdGenMaleButton(
                                          leftColor: colorsMap[ThirdGenIndex.eight]![0].color,
                                          middleColor: colorsMap[ThirdGenIndex.eight]![1].color,
                                          rightColor: colorsMap[ThirdGenIndex.eight]![2].color,
                                          onPressed: () => handleButtonPress(ThirdGenIndex.eight),
                                        ),
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
      },
    );
  }

  void handleButtonPress(ThirdGenIndex thirdGenIndex) {
    List<IVColor> parentsList = thirdGenCubit.secondGenCubit.secondGenModel.getParentsList(thirdGenIndex);
    if (!thirdGenCubit.isParentsListFilled(parentsList)) {
      onTogglePanel(thirdGenIndex);
    }
  }
}
