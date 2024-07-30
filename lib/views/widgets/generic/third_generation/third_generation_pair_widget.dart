import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/third_generation/a_third_generation_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/third_generation/third_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/female/third_generation_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/male/third_generation_male_button.dart';
import 'package:breeder/views/widgets/genealogical_tree/generic/sliding_panel_widget.dart';
import 'package:breeder/views/widgets/generic/third_generation/third_generation_sliding_panel/third_generation_female_sliding_panel.dart';
import 'package:breeder/views/widgets/generic/third_generation/third_generation_sliding_panel/third_generation_male_sliding_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ThirdGenerationPairWidget extends StatefulWidget {
  final int listIndex;

  const ThirdGenerationPairWidget({
    required this.listIndex,
    Key? key,
  }) : super(key: key);

  @override
  _ThirdGenerationPairWidgetState createState() => _ThirdGenerationPairWidgetState();
}

class _ThirdGenerationPairWidgetState extends State<ThirdGenerationPairWidget> {
  final ThirdGenerationCubit thirdGenerationCubit = globalLocator<ThirdGenerationCubit>();

  late PanelController femalePanelController;
  late PanelController malePanelController;
  late int femaleData = 0;
  late int maleData = 0;

  @override
  void initState() {
    super.initState();
    femalePanelController = PanelController();
    malePanelController = PanelController();
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
        femalePanelController.open();
      } else {
        maleData = data;
        malePanelController.open();
      }
    });
  }

  void _onWillPop(bool didPop) {
    if (femalePanelController.isPanelOpen) {
      femalePanelController.close();
    } else if (malePanelController.isPanelOpen) {
      malePanelController.close();
    } else {
      AutoRouter.of(context).push(const SecondGenWidget());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdGenerationCubit, AThirdGenerationState>(
      bloc: thirdGenerationCubit,
      builder: (BuildContext context, AThirdGenerationState state) {
        final List<Color> femaleColorsZero = thirdGenerationCubit.getFemaleButtonColors();
        final List<Color> maleColorsZero = thirdGenerationCubit.getMaleButtonColors();

        return PopScope(
          canPop: false,
          onPopInvoked: _onWillPop,
          child: Scrollbar(
            thickness: 5,
            thumbVisibility: true,
            child: Stack(children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ThirdGenerationFemaleButton(
                            leftColor: femaleColorsZero[0],
                            middleColor: femaleColorsZero[1],
                            rightColor: femaleColorsZero[2],
                            onPressed: () {
                              _onButtonPressed(0, 1);
                              _togglePanel(femalePanelController);
                            }),
                        ThirdGenerationMaleButton(
                            leftColor: maleColorsZero[0],
                            middleColor: maleColorsZero[1],
                            rightColor: maleColorsZero[2],
                            onPressed: () {
                              _onButtonPressed(0, 0);
                              _togglePanel(malePanelController);
                            }),
                        ThirdGenerationFemaleButton(
                            leftColor: femaleColorsZero[3],
                            middleColor: femaleColorsZero[4],
                            rightColor: femaleColorsZero[5],
                            onPressed: () {
                              _onButtonPressed(1, 1);
                              _togglePanel(femalePanelController);
                            }),
                        ThirdGenerationMaleButton(
                            leftColor: maleColorsZero[3],
                            middleColor: maleColorsZero[4],
                            rightColor: maleColorsZero[5],
                            onPressed: () {
                              _onButtonPressed(1, 0);
                              _togglePanel(malePanelController);
                            }),
                        ThirdGenerationFemaleButton(
                            leftColor: femaleColorsZero[6],
                            middleColor: femaleColorsZero[7],
                            rightColor: femaleColorsZero[8],
                            onPressed: () {
                              _onButtonPressed(2, 1);
                              _togglePanel(femalePanelController);
                            }),
                        ThirdGenerationMaleButton(
                            leftColor: maleColorsZero[6],
                            middleColor: maleColorsZero[7],
                            rightColor: maleColorsZero[8],
                            onPressed: () {
                              _onButtonPressed(2, 0);
                              _togglePanel(malePanelController);
                            }),
                        ThirdGenerationFemaleButton(
                            leftColor: femaleColorsZero[9],
                            middleColor: femaleColorsZero[10],
                            rightColor: femaleColorsZero[11],
                            onPressed: () {
                              _onButtonPressed(3, 1);
                              _togglePanel(femalePanelController);
                            }),
                        ThirdGenerationMaleButton(
                            leftColor: maleColorsZero[9],
                            middleColor: maleColorsZero[10],
                            rightColor: maleColorsZero[11],
                            onPressed: () {
                              _onButtonPressed(3, 0);
                              _togglePanel(malePanelController);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              SlidingPanelWidget(
                controller: femalePanelController,
                panel: ThirdGenerationFemaleSlidingPanel(listIndex: femaleData),
                onTap: () => _closePanelIfOpen(femalePanelController),
                bodyContent: Container(),
              ),
              SlidingPanelWidget(
                controller: malePanelController,
                panel: ThirdGenerationMaleSlidingPanel(listIndex: maleData),
                onTap: () => _closePanelIfOpen(malePanelController),
                bodyContent: Container(),
              ),
            ]),
          ),
        );
      },
    );
  }
}
