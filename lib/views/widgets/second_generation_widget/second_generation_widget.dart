import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/second_generation/a_second_generation_state.dart';
import 'package:breeder/blocks/pages/second_generation/second_generation_cubit.dart';
import 'package:breeder/blocks/pages/third_generation/third_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/second_generation/female/second_generation_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/second_generation/male/second_generation_male_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/female/third_generation_female_button.dart';
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
          return BlocBuilder<SecondGenerationCubit, ASecondGenerationState>(
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
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
                                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Column(children: <Widget>[
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
                                            Column(
                                              children: <Widget>[
                                                ThirdGenerationFemaleButton(
                                                  leftColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[0][0],
                                                  middleColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[0][1],
                                                  rightColor: secondGenerationCubit.secondGenerationModel.childrenColorsList[0][2],
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ]),
                                    ]),
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
          );
        },
      ),
    );
  }
}
