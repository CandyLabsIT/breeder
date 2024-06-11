import 'package:breeder/blocks/pages/second_generation/a_second_generation_cubit.dart';
import 'package:breeder/blocks/pages/second_generation/second_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/widgets/buttons/attribute_value/attribute_value_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenerationMaleSlidingPanel extends StatefulWidget {
  const SecondGenerationMaleSlidingPanel({super.key});

  @override
  State<SecondGenerationMaleSlidingPanel> createState() => _SecondGenerationMaleSlidingPanelState();
}

class _SecondGenerationMaleSlidingPanelState extends State<SecondGenerationMaleSlidingPanel> {
  final SecondGenerationCubit secondGenerationCubit = globalLocator<SecondGenerationCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondGenerationCubit, ASecondGenerationState>(
      bloc: secondGenerationCubit,
      builder: (BuildContext context, ASecondGenerationState state) {
        return Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _closePanelRow(),
              ),
              ..._buildAttributeButtons(),
              _buildResetButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _closePanelRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Close',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8),
        Icon(
          Icons.arrow_drop_down,
          size: 24,
        ),
      ],
    );
  }

  List<Widget> _buildAttributeButtons() {
    final List<Map<String, dynamic>> attributes = <Map<String, dynamic>>[
      <String, dynamic>{'text': 'Atk.', 'color': const Color(0xFFFA4A78), 'index': 1},
      <String, dynamic>{'text': 'HP', 'color': const Color(0xFF7AE3FC), 'index': 2},
      <String, dynamic>{'text': 'Sp.Atk.', 'color': const Color(0xFFFDFB8E), 'index': 3},
      <String, dynamic>{'text': 'Def.', 'color': const Color(0xFFFFDAD6), 'index': 4},
      <String, dynamic>{'text': 'Sp.Def', 'color': const Color(0xFFCFA9F2), 'index': 5},
      <String, dynamic>{'text': 'Speed', 'color': const Color(0xFF96EF9E), 'index': 6},
    ];

    return <Widget>[
      for (int i = 0; i < attributes.length; i += 2)
        Row(
          children: <Widget>[
            _buildAttributeButton(
              attributes[i]['text'] as String,
              attributes[i]['color'] as Color,
              attributes[i]['index'] as int,
            ),
            if (i + 1 < attributes.length)
              _buildAttributeButton(
                attributes[i + 1]['text'] as String,
                attributes[i + 1]['color'] as Color,
                attributes[i + 1]['index'] as int,
              ),
          ],
        ),
    ];
  }

  Widget _buildAttributeButton(String text, Color color, int index) {
    return AttributeValueButton(
      buttonText: text,
      onPressed: () => secondGenerationCubit.getMaleColors(index),
      buttonColor: color,
      isEnabled: secondGenerationCubit.secondGenerationModel.isMaleButtonEnable()[index],
    );
  }

  Widget _buildResetButton() {
    return BlocBuilder<SecondGenerationCubit, ASecondGenerationState>(
      bloc: secondGenerationCubit,
      builder: (BuildContext context, ASecondGenerationState secondGenerationState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AttributeValueButton(
              buttonText: 'Reset',
              onPressed: secondGenerationCubit.resetMaleValues,
              isEnabled: secondGenerationCubit.secondGenerationModel.isMaleRestartButtonEnabled(),
              buttonColor: const Color(0xF095A5BF),
            ),
          ],
        );
      },
    );
  }
}
