import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/pairs_value.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree/second_gen/female/second_gen_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree/second_gen/male/second_gen_male_button.dart';
import 'package:breeder/views/widgets/genealogical_tree/generic/sliding_panel_widget.dart';
import 'package:breeder/views/widgets/genealogical_tree/second_gen/second_gen_sliding_panel/second_gen_female_sliding_panel.dart';
import 'package:breeder/views/widgets/genealogical_tree/second_gen/second_gen_sliding_panel/second_gen_male_sliding_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

@RoutePage()
class SecondGenWidget extends StatefulWidget {
  const SecondGenWidget({super.key});

  @override
  _SecondGenWidgetState createState() => _SecondGenWidgetState();
}

class _SecondGenWidgetState extends State<SecondGenWidget> {
  final SecondGenCubit secondGenCubit = globalLocator<SecondGenCubit>();

  late PanelController _femalePanelController;
  late PanelController _malePanelController;
  late PairsValues femaleData = PairsValues.pairZero;
  late PairsValues maleData = PairsValues.pairZero;
  bool _isPanelActionInProgress = false;

  @override
  void initState() {
    super.initState();
    _femalePanelController = PanelController();
    _malePanelController = PanelController();
  }

  Future<void> _closePanelIfOpen(PanelController controller) async {
    if (controller.isPanelOpen) {
      await controller.close();
    }
  }

  Future<void> _togglePanel(PanelController primaryController, PanelController secondaryController) async {
    if (_isPanelActionInProgress) {
      return;
    }
    setState(() {
      _isPanelActionInProgress = true;
    });

    if (primaryController.isPanelOpen) {
      await primaryController.close();
    } else {
      await _closePanelIfOpen(secondaryController);
      await primaryController.open();
    }

    setState(() {
      _isPanelActionInProgress = false;
    });
  }

  void _onButtonPressed(PairsValues data, int panel) {
    setState(() {
      if (panel == 0) {
        femaleData = data;
      } else if (panel == 1) {
        maleData = data;
      }
    });
  }

  void _onPopInvoked(bool didPop) {
    if (_femalePanelController.isPanelOpen) {
      _femalePanelController.close();
    } else if (_malePanelController.isPanelOpen) {
      _malePanelController.close();
    } else if (_femalePanelController.isPanelClosed && _malePanelController.isPanelClosed) {
      AutoRouter.of(context).push(const NewBreedingRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SecondGenCubit>(
      create: (BuildContext context) => SecondGenCubit(),
      child: BlocBuilder<SecondGenCubit, ASecondGenState>(
        bloc: secondGenCubit,
        builder: (BuildContext context, ASecondGenState state) {
          final List<Color> femaleColors = secondGenCubit.getFemaleButtonColors();
          final List<Color> maleColors = secondGenCubit.getMaleButtonColors();
          return PopScope(
            canPop: false,
            onPopInvoked: _onPopInvoked,
            child: Scaffold(
              body: Stack(
                children: <Widget>[
                  SlidingPanelWidget(
                    controller: _femalePanelController,
                    panel: SecondGenFemaleSlidingPanel(pairValue: femaleData),
                    onTap: () {},
                    bodyContent: Container(),
                  ),
                  SlidingPanelWidget(
                    controller: _malePanelController,
                    panel: SecondGenMaleSlidingPanel(pairValue: maleData),
                    onTap: () {},
                    bodyContent: Container(),
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SecondGenFemaleButton(
                            leftColor: femaleColors[0],
                            rightColor: femaleColors[1],
                            onPressed: () {
                              _onButtonPressed(PairsValues.pairZero, 0);
                              _togglePanel(_femalePanelController, _malePanelController);
                            },
                          ),
                          SecondGenMaleButton(
                            leftColor: maleColors[0],
                            rightColor: maleColors[1],
                            onPressed: () {
                              _togglePanel(_malePanelController, _femalePanelController);
                              _onButtonPressed(PairsValues.pairZero, 1);
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
