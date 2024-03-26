import 'package:breeder/blocks/pages/max_iv_slots_creator_page/max_iv_slots_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt globalLocator = GetIt.I;

Future<void> initLocator() async {
  _initControllers();
}

void _initControllers() {
  globalLocator.registerLazySingleton<MaxIVSlotsCubit>(MaxIVSlotsCubit.new);
}
