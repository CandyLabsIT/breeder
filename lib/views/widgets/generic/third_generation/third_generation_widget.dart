import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/third_generation/a_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/third_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/second_generation/female/second_generation_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/second_generation/male/second_generation_male_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/third_generation_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/third_generation_male_button.dart';
import 'package:breeder/views/widgets/generic/genealogical_tree/sliding_panel_widget.dart';
import 'package:breeder/views/widgets/second_generation_widget/second_generation_sliding_panel/second_generation_female_sliding_panel.dart';
import 'package:breeder/views/widgets/second_generation_widget/second_generation_sliding_panel/second_generation_male_sliding_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

@RoutePage()
class ThirdGenerationWidget extends StatefulWidget {
  const ThirdGenerationWidget({super.key});

  @override
  _ThirdGenerationWidgetState createState() => _ThirdGenerationWidgetState();
}

class _ThirdGenerationWidgetState extends State<ThirdGenerationWidget> {
  final ThirdGenerationCubit thirdGenerationCubit = globalLocator<ThirdGenerationCubit>();

  late PanelController _femalePanelController;
  late PanelController _malePanelController;

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

  void _togglePanel(PanelController primaryController, PanelController secondaryController) {
    if (primaryController.isPanelOpen) {
      primaryController.close();
    } else {
      _closePanelIfOpen(secondaryController);
      primaryController.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThirdGenerationCubit>(
      create: (BuildContext context) => ThirdGenerationCubit(),
      child: BlocBuilder<ThirdGenerationCubit, AThirdGenerationState>(
        bloc: thirdGenerationCubit,
        builder: (BuildContext context, AThirdGenerationState state) {
          final List<Color> femaleColorsZero = thirdGenerationCubit.getFemaleButtonColors(0);
          final List<Color> maleColorsZero = thirdGenerationCubit.getMaleButtonColors(0);
          final List<Color> femaleColorsOne = thirdGenerationCubit.getFemaleButtonColors(1);
          final List<Color> maleColorsOne = thirdGenerationCubit.getMaleButtonColors(1);
          return Scaffold(
            body: Stack(
              children: <Widget>[
                SlidingPanelWidget(
                  controller: _femalePanelController,
                  panel: const SecondGenerationFemaleSlidingPanel(),
                  onTap: () => _closePanelIfOpen(_femalePanelController),
                  bodyContent: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          ThirdGenerationFemaleButton(
                            leftColor: femaleColorsZero[0],
                            middleColor: femaleColorsZero[1],
                            rightColor: femaleColorsZero[2],
                            onPressed: () => _togglePanel(_femalePanelController, _malePanelController),
                          ),
                          ThirdGenerationMaleButton(
                            leftColor: maleColorsZero[0],
                            middleColor: maleColorsZero[1],
                            rightColor: maleColorsZero[1],
                            onPressed: () => _togglePanel(_malePanelController, _femalePanelController),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SlidingPanelWidget(
                  controller: _malePanelController,
                  panel: const SecondGenerationMaleSlidingPanel(),
                  onTap: () => _closePanelIfOpen(_malePanelController),
                  bodyContent: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          ThirdGenerationFemaleButton(
                            leftColor: femaleColorsOne[0],
                            rightColor: femaleColorsOne[1],
                            onPressed: () => _togglePanel(_femalePanelController, _malePanelController), middleColor: null,
                          ),
                          SecondGenerationMaleButton(
                            leftColor: maleColors[0],
                            rightColor: maleColors[1],
                            onPressed: () => _togglePanel(_malePanelController, _femalePanelController),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
