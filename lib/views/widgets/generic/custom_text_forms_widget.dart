import 'package:breeder/shared/cubit/input_cubit.dart';
import 'package:breeder/shared/models/monsters_model.dart';
import 'package:breeder/views/widgets/generic/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextFormsWidget extends StatefulWidget {
  final MonstersModel _model;

  const CustomTextFormsWidget({
    required MonstersModel model,
    Key? key,
  })  : _model = model,
        super(key: key);

  @override
  _CustomTextFormsWidgetState createState() => _CustomTextFormsWidgetState();
}

class _CustomTextFormsWidgetState extends State<CustomTextFormsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputCubit, int>(
      builder: (BuildContext context, int state) {
        return SizedBox(
          width: 200,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 40),
                child: CustomTextForm(
                  controller: widget._model.monstersNumber[0],
                  ivTextInfo: '1 IV',
                  maxLength: 2,
                  maxSlots: 32,
                  onChanged: (_) {
                    int sum = widget._model.calculateMonstersSum();
                    context.read<InputCubit>().getInputsSum(sum);
                  },
                  inputsSum: state,
                  inputWeight: 1,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: CustomTextForm(
                  controller: widget._model.monstersNumber[1],
                  ivTextInfo: '2 IVs',
                  maxLength: 2,
                  maxSlots: 16,
                  onChanged: (_) {
                    int sum = widget._model.calculateMonstersSum();
                    context.read<InputCubit>().getInputsSum(sum);
                  },
                  inputsSum: state,
                  inputWeight: 2,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: CustomTextForm(
                  controller: widget._model.monstersNumber[2],
                  ivTextInfo: '3 IVs',
                  maxLength: 1,
                  maxSlots: 8,
                  onChanged: (_) {
                    int sum = widget._model.calculateMonstersSum();
                    context.read<InputCubit>().getInputsSum(sum);
                  },
                  inputsSum: state,
                  inputWeight: 4,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: CustomTextForm(
                  controller: widget._model.monstersNumber[3],
                  ivTextInfo: '4 IVs',
                  maxLength: 1,
                  maxSlots: 4,
                  onChanged: (_) {
                    int sum = widget._model.calculateMonstersSum();
                    context.read<InputCubit>().getInputsSum(sum);
                  },
                  inputsSum: state,
                  inputWeight: 8,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: CustomTextForm(
                  controller: widget._model.monstersNumber[4],
                  ivTextInfo: '5 IVs',
                  maxLength: 1,
                  maxSlots: 2,
                  onChanged: (_) {
                    int sum = widget._model.calculateMonstersSum();
                    context.read<InputCubit>().getInputsSum(sum);
                  },
                  inputsSum: state,
                  inputWeight: 16,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
