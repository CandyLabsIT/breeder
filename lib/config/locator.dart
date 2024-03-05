import 'package:breeder/shared/cubit/input_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt globalLocator = GetIt.I;

Future<void> initLocator() async {
  globalLocator.registerLazySingleton<InputCubit>(InputCubit.new);
}
