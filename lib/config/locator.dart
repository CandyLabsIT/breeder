import 'package:breeder/blocks/pages/iv_creator_form/iv_creator_form_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/blocks/pages/single_iv_form/single_iv_form_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt globalLocator = GetIt.I;

Future<void> initLocator() async {
  _initControllers();
}

void _initControllers() {
  globalLocator
    ..registerLazySingleton<MaxIVFormCubit>(MaxIVFormCubit.new)
    ..registerLazySingleton<IVCreatorFormCubit>(IVCreatorFormCubit.new)
    ..registerLazySingleton<SingleIVFormCubit>(SingleIVFormCubit.new);
}
