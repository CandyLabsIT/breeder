import 'package:breeder/blocks/pages/third_generation/a_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/third_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/third_generation_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/third_generation_male_button.dart';
import 'package:breeder/views/widgets/generic/genealogical_tree/sliding_panel_widget.dart';
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

  late PanelController panelController;

  // late PanelController _malePanelController1;

  @override
  void initState() {
    super.initState();
    panelController = PanelController();
    // _malePanelController1 = PanelController();
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
      // _closePanelIfOpen(secondaryController);
      primaryController.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdGenerationCubit, AThirdGenerationState>(
      bloc: thirdGenerationCubit,
      builder: (BuildContext context, AThirdGenerationState state) {
        final List<Color> femaleColorsZero = thirdGenerationCubit.getFemaleButtonColors(0);
        final List<Color> maleColorsZero = thirdGenerationCubit.getMaleButtonColors(0);
        final Widget slidingPanel = thirdGenerationCubit.getWidget();

        return SlidingPanelWidget(
          controller: panelController,
          panel: slidingPanel,
          onTap: () => _closePanelIfOpen(panelController),
          bodyContent: SizedBox(
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
                          thirdGenerationCubit.getThirdGenerationWidget(0, 0);
                          _togglePanel(panelController);
                        }),
                    ThirdGenerationMaleButton(
                        leftColor: maleColorsZero[0],
                        middleColor: maleColorsZero[1],
                        rightColor: maleColorsZero[2],
                        onPressed: () {
                          thirdGenerationCubit.getThirdGenerationWidget(1, 0);
                          _togglePanel(panelController);
                        }),
                    ThirdGenerationFemaleButton(
                      leftColor: femaleColorsZero[3],
                      middleColor: femaleColorsZero[4],
                      rightColor: femaleColorsZero[5],
                      onPressed: () {
                        thirdGenerationCubit.getThirdGenerationWidget(0, 1);
                      _togglePanel(panelController);}
                    ),
                    ThirdGenerationMaleButton(
                      leftColor: maleColorsZero[3],
                      middleColor: maleColorsZero[4],
                      rightColor: maleColorsZero[5],
                        onPressed: () {
                          thirdGenerationCubit.getThirdGenerationWidget(1, 1);
                          _togglePanel(panelController);}
                    ),
                    ThirdGenerationFemaleButton(
                      leftColor: femaleColorsZero[6],
                      middleColor: femaleColorsZero[7],
                      rightColor: femaleColorsZero[8],
                        onPressed: () {
                          thirdGenerationCubit.getThirdGenerationWidget(0, 2);
                          _togglePanel(panelController);}
                    ),
                    ThirdGenerationMaleButton(
                      leftColor: maleColorsZero[6],
                      middleColor: maleColorsZero[7],
                      rightColor: maleColorsZero[8],
                        onPressed: () {
                          thirdGenerationCubit.getThirdGenerationWidget(1, 2);
                          _togglePanel(panelController);}
                    ),
                    ThirdGenerationFemaleButton(
                      leftColor: femaleColorsZero[9],
                      middleColor: femaleColorsZero[10],
                      rightColor: femaleColorsZero[11],
                        onPressed: () {
                          thirdGenerationCubit.getThirdGenerationWidget(0, 3);
                          _togglePanel(panelController);}
                    ),
                    ThirdGenerationMaleButton(
                      leftColor: maleColorsZero[9],
                      middleColor: maleColorsZero[10],
                      rightColor: maleColorsZero[11],
                        onPressed: () {
                          thirdGenerationCubit.getThirdGenerationWidget(1, 3);
                          _togglePanel(panelController);}
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
