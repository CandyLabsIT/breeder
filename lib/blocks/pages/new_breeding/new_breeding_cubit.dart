import 'package:breeder/blocks/pages/genealogical_tree/second_gen/first_gen_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/blocks/pages/new_breeding/states/new_breeding_init_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/new_breeding/new_breeding_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewBreedingCubit extends Cubit<NewBreedingInitState> {
  NewBreedingModel newBreedingModel = NewBreedingModel();
  MaxIVFormCubit maxIVFormCubit = globalLocator<MaxIVFormCubit>();
  FirstGenCubit firstGenCubit = globalLocator<FirstGenCubit>();

  NewBreedingCubit() : super(const NewBreedingInitState());

  void resetData() {
    newBreedingModel.clearData();
    firstGenCubit.resetAllToDefaultColors();
  }
}
