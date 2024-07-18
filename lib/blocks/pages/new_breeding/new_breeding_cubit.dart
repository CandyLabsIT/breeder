import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/blocks/pages/new_breeding/states/new_breeding_init_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/new_breeding/new_breeding_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewBreedingCubit extends Cubit<NewBreedingInitState> {
  SecondGenCubit secondGenCubit = globalLocator<SecondGenCubit>();
  NewBreedingModel newBreedingModel = NewBreedingModel();

  NewBreedingCubit() : super(const NewBreedingInitState());

  void resetData() {
    newBreedingModel.clearData();
    secondGenCubit
      ..restoreMaleDefaultColors()
      ..restoreFemaleDefaultColors();
  }
}