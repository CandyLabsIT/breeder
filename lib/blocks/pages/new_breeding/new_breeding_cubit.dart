import 'package:breeder/blocks/pages/new_breeding/a_new_breeding_state.dart';
import 'package:breeder/blocks/pages/new_breeding/state/init_new_breeding_state.dart';
import 'package:breeder/blocks/pages/second_generation/second_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/new_breeding/new_breeding_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewBreedingCubit extends Cubit<ANewBreedingState> {
  SecondGenerationCubit secondGenerationCubit = globalLocator<SecondGenerationCubit>();
  NewBreedingModel newBreedingModel = NewBreedingModel();

  NewBreedingCubit() : super(InitNewBreedingState());

  void resetData() {
    newBreedingModel.clearData();
    secondGenerationCubit
      ..restoreMaleDefaultColors()
      ..restoreFemaleDefaultColors();
  }
}
