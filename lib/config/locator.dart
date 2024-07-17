import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/blocks/pages/new_breeding/new_breeding_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt globalLocator = GetIt.I;

Future<void> initLocator() async {
  _initControllers();
}

void _initControllers() {
  globalLocator
    ..registerLazySingleton<NewBreedingCubit>(NewBreedingCubit.new)
    ..registerLazySingleton<MaxIVFormCubit>(MaxIVFormCubit.new)
  ..registerLazySingleton<SecondGenCubit>(SecondGenCubit.new);
}
