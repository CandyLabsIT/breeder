import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/cubit/input_cubit.dart';
import 'package:breeder/shared/cubit/single_iv_page/a_single_iv_amount_state.dart';
import 'package:breeder/shared/cubit/single_iv_page/state/single_iv_amount_initial.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SingleIVAmountCubit extends Cubit<ASingleIVAmountState> {
  final InputCubit inputCubit = globalLocator<InputCubit>();

  SingleIVAmountCubit() : super(SingleIVAmountInitial());

}