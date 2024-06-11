import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/second_generation/a_second_generation_cubit.dart';
import 'package:breeder/blocks/pages/second_generation/second_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/second_generation/female/second_generation_female_button.dart';
import 'package:breeder/views/widgets/buttons/genealogical_tree_button/second_generation/male/second_generation_male_button.dart';
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
    return BlocProvider<SecondGenerationCubit>(
      create: (BuildContext context) => SecondGenerationCubit(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildSlidingPanel(
                controller: _femalePanelController,
                panel: const SecondGenerationFemaleSlidingPanel(),
                onTap: () => _closePanelIfOpen(_femalePanelController)),
            _buildSlidingPanel(
                controller: _malePanelController,
                panel: const SecondGenerationMaleSlidingPanel(),
                onTap: () => _closePanelIfOpen(_malePanelController)),
          ],
        ),
      ),
    );
  }

  Widget _buildSlidingPanel({
    required PanelController controller,
    required Widget panel,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          SlidingUpPanel(
            controller: controller,
            color: const Color(0xffffbc77),
            panel: panel,
            body: _bodyContent(),
            collapsed: Container(),
            minHeight: 0,
            maxHeight: MediaQuery.of(context).size.height * 0.5,
            backdropEnabled: true,
            backdropTapClosesPanel: false,
          ),
        ],
      ),
    );
  }

  Widget _bodyContent() {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: BlocBuilder<SecondGenerationCubit, ASecondGenerationState>(
          bloc: secondGenerationCubit,
          builder: (BuildContext context, ASecondGenerationState state) {
            final List<Color> femaleColors = secondGenerationCubit.getFemaleButtonColors();
            final List<Color> maleColors = secondGenerationCubit.getMaleButtonColors();

            return Column(
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
      ),
    );
  }
}
