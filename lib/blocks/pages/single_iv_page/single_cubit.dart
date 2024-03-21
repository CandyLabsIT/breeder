import 'package:breeder/blocks/pages/max_iv_slots_page/iv_slots_amount_cubit.dart';
import 'package:breeder/blocks/pages/single_iv_page/a_single_iv_amount_state.dart';
import 'package:breeder/blocks/pages/single_iv_page/state/list_state.dart';
import 'package:breeder/blocks/pages/single_iv_page/state/single_iv_amount_initial.dart';
import 'package:breeder/config/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleCubit extends Cubit<ASingleIVAmountState>{
  final IVSlotsAmountCubit ivSlotsAmountCubit = globalLocator<IVSlotsAmountCubit>();

  SingleCubit() : super(SingleIVAmountInitial());

  void fetchData(){
    emit(SlotsList(slotValue: ivSlotsAmountCubit.ivSlotsAmountModel.getAmountList()[0]));
  }
}