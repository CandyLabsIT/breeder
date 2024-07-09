import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/second_generation/a_second_generation_state.dart';
import 'package:breeder/blocks/pages/second_generation/second_generation_cubit.dart';
import 'package:breeder/blocks/pages/third_generation/a_third_generation_state.dart';
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
import 'package:nested/nested.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

@RoutePage()
class SecondGenerationWidget extends StatefulWidget {
  const SecondGenerationWidget({super.key});

  @override
  _SecondGenerationWidgetState createState() => _SecondGenerationWidgetState();
}

class _SecondGenerationWidgetState extends State<SecondGenerationWidget> {
  final SecondGenerationCubit secondGenerationCubit = globalLocator<SecondGenerationCubit>();
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
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<SecondGenerationCubit>(create: (BuildContext context) => secondGenerationCubit),
        BlocProvider<ThirdGenerationCubit>(create: (BuildContext context) => ThirdGenerationCubit()),
      ],
      child: PopScope(
        canPop: false,
        onPopInvoked: _onWillPop,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SlidingPanelWidget(
                controller: _femalePanelController,
                panel: const SecondGenerationFemaleSlidingPanel(),
                onTap: () {},
                bodyContent: Container(),
              ),
              SlidingPanelWidget(
                controller: _malePanelController,
                panel: const SecondGenerationMaleSlidingPanel(),
                onTap: () {},
                bodyContent: Container(),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      BlocBuilder<SecondGenerationCubit, ASecondGenerationState>(
                        bloc: secondGenerationCubit,
                        builder: (BuildContext context, ASecondGenerationState state) {
                          final List<Color> femaleColors = secondGenerationCubit.getFemaleButtonColors();
                          final List<Color> maleColors = secondGenerationCubit.getMaleButtonColors();
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SecondGenerationFemaleButton(
                                leftColor: femaleColors[0],
                                rightColor: femaleColors[1],
                                onPressed: () => _togglePanel(_femalePanelController, _malePanelController),
                              ),
                              SecondGenerationMaleButton(
                                leftColor: maleColors[0],
                                rightColor: maleColors[1],
                                onPressed: () => _togglePanel(_malePanelController, _femalePanelController),
                              ),
                            ],
                          );
                        },
                      ),
                      BlocBuilder<ThirdGenerationCubit, AThirdGenerationState>(
                        bloc: thirdGenerationCubit,
                        builder: (BuildContext context, AThirdGenerationState state) {
                          print('ThirdGenerationCubit state updated: $state');
                          final List<Color> maleColorsZero = thirdGenerationCubit.getMaleButtonColors();
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ThirdGenerationFemaleButton(
                                leftColor: thirdGenerationCubit.getFemaleChildColor(0, 0),
                                middleColor: thirdGenerationCubit.getFemaleChildColor(0, 1),
                                rightColor: thirdGenerationCubit.getFemaleChildColor(0, 2),
                                onPressed: () {},
                              ),
                              ThirdGenerationMaleButton(
                                leftColor: maleColorsZero[0],
                                middleColor: maleColorsZero[1],
                                rightColor: maleColorsZero[2],
                                onPressed: () {},
                              ),
                            ],
                          );
                        },
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