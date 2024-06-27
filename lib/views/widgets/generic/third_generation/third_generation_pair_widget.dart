import 'package:breeder/blocks/pages/third_generation/a_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/third_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/third_generation_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/third_generation/third_generation_male_button.dart';
import 'package:breeder/views/widgets/generic/genealogical_tree/sliding_panel_widget.dart';
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
          final List<Color> femaleColorsZero = thirdGenerationCubit.getFemaleButtonColors(widget.listIndex);
          final List<Color> maleColorsZero = thirdGenerationCubit.getMaleButtonColors(widget.listIndex);

          return Stack(
            children: <Widget>[
              SlidingPanelWidget(
                controller: _femalePanelController,
                panel: ThirdGenerationFemaleSlidingPanel(listIndex: widget.listIndex),
                onTap: () => _closePanelIfOpen(_femalePanelController),
                bodyContent: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
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
                            rightColor: maleColorsZero[2],
                            onPressed: () => _togglePanel(_malePanelController, _femalePanelController),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SlidingPanelWidget(
                controller: _malePanelController,
                panel: ThirdGenerationMaleSlidingPanel(listIndex: widget.listIndex),
                onTap: () => _closePanelIfOpen(_malePanelController),
                bodyContent: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
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
                            rightColor: maleColorsZero[2],
                            onPressed: () => _togglePanel(_malePanelController, _femalePanelController),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
