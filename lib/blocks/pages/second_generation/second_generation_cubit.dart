import 'dart:ui';

import 'package:breeder/blocks/pages/second_generation/a_second_generation_cubit.dart';
import 'package:breeder/blocks/pages/second_generation/state/female_colors_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/init_second_generation_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/male_colors_state.dart.dart';
import 'package:breeder/blocks/pages/second_generation/state/restarted_female_values_state.dart';
import 'package:breeder/blocks/pages/second_generation/state/restarted_male_values_state.dart';
import 'package:breeder/shared/models/second_generation_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondGenerationCubit extends Cubit<ASecondGenerationState> {
  SecondGenerationModel secondGenerationModel = SecondGenerationModel();

  SecondGenerationCubit() : super(InitSecondGenerationState());

  void getFemaleColors(int femaleValue) {
    emit(FemaleColorsState(valuesList: secondGenerationModel.getFemaleColors(femaleValue)));
  }

  void getMaleColors(int maleValue) {
    emit(MaleColorsState(valuesList: secondGenerationModel.getMaleColors(maleValue)));
  }

  void resetFemaleValues() {
    emit(RestartedFemaleValuesState(valuesList: secondGenerationModel.restartFemaleValues()));
  }

  void resetMaleValues() {
    emit(RestartedMaleValuesState(valuesList: secondGenerationModel.restartMaleValues()));
  }

  List<Color> getFemaleButtonColors() {
    if (state is FemaleColorsState) {
      return (state as FemaleColorsState).valuesList;
    } else if (state is RestartedFemaleValuesState) {
      return (state as RestartedFemaleValuesState).valuesList;
    }
    return secondGenerationModel.getFemaleColors(0);
  }

  List<Color> getMaleButtonColors() {
    if (state is MaleColorsState) {
      return (state as MaleColorsState).valuesList;
    } else if (state is RestartedMaleValuesState) {
      return (state as RestartedMaleValuesState).valuesList;
    }
    return secondGenerationModel.getMaleColors(0);
  }
}
