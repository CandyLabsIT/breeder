import 'package:breeder/shared/cubit/input_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.I;

Future<void> initLocator() async {
  serviceLocator.registerLazySingleton<InputCubit>(InputCubit.new);
}
