import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/second_generation/a_second_generation_state.dart';
import 'package:breeder/blocks/pages/second_generation/second_generation_cubit.dart';
import 'package:breeder/blocks/pages/third_generation/third_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/second_generation/female/second_generation_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/second_generation/male/second_generation_male_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/female/third_generation_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/male/third_generation_male_button.dart';
import 'package:breeder/views/widgets/generic/genealogical_tree/sliding_panel_widget.dart';
import 'package:breeder/views/widgets/second_generation_widget/second_generation_sliding_panel/second_generation_female_sliding_panel.dart';
import 'package:breeder/views/widgets/second_generation_widget/second_generation_sliding_panel/second_generation_male_sliding_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

@RoutePage()
class SecondGenerationWidget extends StatefulWidget {
  const SecondGenerationWidget({super.key});

  @override
  _SecondGenerationWidgetState createState() => _SecondGenerationWidgetState();
}

class _SecondGenerationWidgetState extends State<SecondGenerationWidget> {
  final SecondGenerationCubit secondGenerationCubit = globalLocator<SecondGenerationCubit>();

  late PanelController _femalePanelController;
  late PanelController _malePanelController;
  late int femaleData = 0;
  late int maleData = 0;

  @override
  void initState() {
    super.initState();
    _femalePanelController = PanelController();
    _malePanelController = PanelController();
  }

  void _closePanelIfOpen(PanelController controller) {
    if (controller.isPanelOpen) {
      controller.close();
    }
  }

  void _togglePanel(PanelController primaryController) {
    if (primaryController.isPanelOpen) {
      primaryController.close();
    } else {
      primaryController.open();
    }
  }

  void _onButtonPressed(int data, int panel) {
    setState(() {
      if (panel == 1) {
        femaleData = data;
        _femalePanelController.open();
      } else {
        maleData = data;
        _malePanelController.open();
      }
    });
  }

  void _onWillPop(bool didPop) {
    if (_femalePanelController.isPanelOpen) {
      _femalePanelController.close();
    } else if (_malePanelController.isPanelOpen) {
      _malePanelController.close();
    } else {
      AutoRouter.of(context).push(const NewBreedingRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThirdGenerationCubit>(
      create: (BuildContext context) => ThirdGenerationCubit(),
      child: BlocBuilder<SecondGenerationCubit, ASecondGenerationState>(
        bloc: secondGenerationCubit,
        builder: (BuildContext context, ASecondGenerationState state) {
              final List<Color> femaleColors = secondGenerationCubit.getFemaleButtonColors();
              final List<Color> maleColors = secondGenerationCubit.getMaleButtonColors();
              return PopScope(
                canPop: false,
                onPopInvoked: _onWillPop,
                child: Scaffold(
                  body: Scrollbar(
                    thickness: 5,
                    thumbVisibility: true,
                    child: Stack(children: <Widget>[
                      SizedBox(
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
                                                  child: Column(children: <Widget>[
                                                    SecondGenerationFemaleButton(
                                                      leftColor: femaleColors[0],
                                                      rightColor: femaleColors[1],
                                                      onPressed: () {
                                                        _onButtonPressed(0, 1);
                                                        _togglePanel(_femalePanelController);
                                                      },
                                                    ),
                                                    SecondGenerationMaleButton(
                                                      leftColor: maleColors[0],
                                                      rightColor: maleColors[1],
                                                      onPressed: () {
                                                        _onButtonPressed(0, 0);
                                                        _togglePanel(_malePanelController);
                                                      },
                                                    ),
                                                  ]),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    children: <Widget>[
                                                      ThirdGenerationFemaleButton(
                                                        leftColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[0][0],
                                                        middleColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[0][1],
                                                        rightColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[0][2],
                                                        onPressed:  () => AutoRouter.of(context).push(ThirdGenerationRoute()),
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
                                                  child: Column(children: <Widget>[
                                                    SecondGenerationFemaleButton(
                                                      leftColor: femaleColors[2],
                                                      rightColor: femaleColors[3],
                                                      onPressed: () {
                                                        _onButtonPressed(1, 1);
                                                        _togglePanel(_femalePanelController);
                                                      },
                                                    ),
                                                    SecondGenerationMaleButton(
                                                      leftColor: maleColors[2],
                                                      rightColor: maleColors[3],
                                                      onPressed: () {
                                                        _onButtonPressed(1, 0);
                                                        _togglePanel(_malePanelController);
                                                      },
                                                    ),
                                                  ]),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    children: <Widget>[
                                                      ThirdGenerationMaleButton(
                                                        leftColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[1][0],
                                                        middleColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[1][1],
                                                        rightColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[1][2],
                                                        onPressed:  () => AutoRouter.of(context).push(ThirdGenerationRoute()),
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
                                                  child: Column(children: <Widget>[
                                                    SecondGenerationFemaleButton(
                                                      leftColor: femaleColors[4],
                                                      rightColor: femaleColors[5],
                                                      onPressed: () {
                                                        _onButtonPressed(2, 1);
                                                        _togglePanel(_femalePanelController);
                                                      },
                                                    ),
                                                    SecondGenerationMaleButton(
                                                      leftColor: maleColors[4],
                                                      rightColor: maleColors[5],
                                                      onPressed: () {
                                                        _onButtonPressed(2, 0);
                                                        _togglePanel(_malePanelController);
                                                      },
                                                    ),
                                                  ]),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    children: <Widget>[
                                                      ThirdGenerationFemaleButton(
                                                        leftColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[2][0],
                                                        middleColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[2][1],
                                                        rightColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[2][2],
                                                        onPressed:  () => AutoRouter.of(context).push(ThirdGenerationRoute()),
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
                                                  child: Column(children: <Widget>[
                                                    SecondGenerationFemaleButton(
                                                      leftColor: femaleColors[6],
                                                      rightColor: femaleColors[7],
                                                      onPressed: () {
                                                        _onButtonPressed(3, 1);
                                                        _togglePanel(_femalePanelController);
                                                      },
                                                    ),
                                                    SecondGenerationMaleButton(
                                                      leftColor: maleColors[6],
                                                      rightColor: maleColors[7],
                                                      onPressed: () {
                                                        _onButtonPressed(3, 0);
                                                        _togglePanel(_malePanelController);
                                                      },
                                                    ),
                                                  ]),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    children: <Widget>[
                                                      ThirdGenerationMaleButton(
                                                        leftColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[3][0],
                                                        middleColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[3][1],
                                                        rightColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[3][2],
                                                        onPressed:  () => AutoRouter.of(context).push(ThirdGenerationRoute()),
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
                                                  child: Column(children: <Widget>[
                                                    SecondGenerationFemaleButton(
                                                      leftColor: femaleColors[8],
                                                      rightColor: femaleColors[9],
                                                      onPressed: () {
                                                        _onButtonPressed(2, 1);
                                                        _togglePanel(_femalePanelController);
                                                      },
                                                    ),
                                                    SecondGenerationMaleButton(
                                                      leftColor: maleColors[8],
                                                      rightColor: maleColors[9],
                                                      onPressed: () {
                                                        _onButtonPressed(2, 0);
                                                        _togglePanel(_malePanelController);
                                                      },
                                                    ),
                                                  ]),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    children: <Widget>[
                                                      ThirdGenerationFemaleButton(
                                                        leftColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[4][0],
                                                        middleColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[4][1],
                                                        rightColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[4][2],
                                                        onPressed:  () => AutoRouter.of(context).push(ThirdGenerationRoute()),
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
                                                  child: Column(children: <Widget>[
                                                    SecondGenerationFemaleButton(
                                                      leftColor: femaleColors[10],
                                                      rightColor: femaleColors[11],
                                                      onPressed: () {
                                                        _onButtonPressed(3, 1);
                                                        _togglePanel(_femalePanelController);
                                                      },
                                                    ),
                                                    SecondGenerationMaleButton(
                                                      leftColor: maleColors[10],
                                                      rightColor: maleColors[11],
                                                      onPressed: () {
                                                        _onButtonPressed(3, 0);
                                                        _togglePanel(_malePanelController);
                                                      },
                                                    ),
                                                  ]),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    children: <Widget>[
                                                      ThirdGenerationMaleButton(
                                                        leftColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[5][0],
                                                        middleColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[5][1],
                                                        rightColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[5][2],
                                                        onPressed:  () => AutoRouter.of(context).push(ThirdGenerationRoute()),
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
                                                  child: Column(children: <Widget>[
                                                    SecondGenerationFemaleButton(
                                                      leftColor: femaleColors[12],
                                                      rightColor: femaleColors[13],
                                                      onPressed: () {
                                                        _onButtonPressed(2, 1);
                                                        _togglePanel(_femalePanelController);
                                                      },
                                                    ),
                                                    SecondGenerationMaleButton(
                                                      leftColor: maleColors[12],
                                                      rightColor: maleColors[13],
                                                      onPressed: () {
                                                        _onButtonPressed(2, 0);
                                                        _togglePanel(_malePanelController);
                                                      },
                                                    ),
                                                  ]),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    children: <Widget>[
                                                      ThirdGenerationFemaleButton(
                                                        leftColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[6][0],
                                                        middleColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[6][1],
                                                        rightColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[6][2],
                                                        onPressed:  () => AutoRouter.of(context).push(ThirdGenerationRoute()),
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
                                                  child: Column(children: <Widget>[
                                                    SecondGenerationFemaleButton(
                                                      leftColor: femaleColors[14],
                                                      rightColor: femaleColors[15],
                                                      onPressed: () {
                                                        _onButtonPressed(3, 1);
                                                        _togglePanel(_femalePanelController);
                                                      },
                                                    ),
                                                    SecondGenerationMaleButton(
                                                      leftColor: maleColors[14],
                                                      rightColor: maleColors[15],
                                                      onPressed: () {
                                                        _onButtonPressed(3, 0);
                                                        _togglePanel(_malePanelController);
                                                      },
                                                    ),
                                                  ]),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    children: <Widget>[
                                                      ThirdGenerationMaleButton(
                                                        leftColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[7][0],
                                                        middleColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[7][1],
                                                        rightColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[7][2],
                                                        onPressed:  () => AutoRouter.of(context).push(ThirdGenerationRoute()),
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
                      ),
                      SlidingPanelWidget(
                        controller: _femalePanelController,
                        panel: SecondGenerationFemaleSlidingPanel(listIndex: femaleData),
                        onTap: () => _closePanelIfOpen(_femalePanelController),
                        bodyContent: Container(),
                      ),
                      SlidingPanelWidget(
                        controller: _malePanelController,
                        panel: SecondGenerationMaleSlidingPanel(listIndex: maleData),
                        onTap: () => _closePanelIfOpen(_malePanelController),
                        bodyContent: Container(),
                      ),
                    ]),
                  ),
                ),
              );
            },
      ),
    );
  }
}
