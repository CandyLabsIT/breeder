import 'package:breeder/blocks/pages/max_iv_slots_page/iv_slots_amount_cubit.dart';
import 'package:breeder/blocks/pages/single_iv_page/single_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt globalLocator = GetIt.I;

Future<void> initLocator() async {
  _initControllers();
}

void _initControllers() {
  globalLocator
      ..registerLazySingleton<IVSlotsAmountCubit>(IVSlotsAmountCubit.new)
      ..registerLazySingleton<SingleCubit>(SingleCubit.new);
}