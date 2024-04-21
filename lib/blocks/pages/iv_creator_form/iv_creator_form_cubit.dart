import 'package:breeder/blocks/pages/iv_creator_form/a_iv_creator_form_state.dart';
import 'package:breeder/blocks/pages/iv_creator_form/state/iv_creator_form_back_button_pressed_state.dart';
import 'package:breeder/blocks/pages/iv_creator_form/state/iv_creator_form_init_state.dart';
import 'package:breeder/blocks/pages/iv_creator_form/state/iv_creator_form_next_button_pressed_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/iv_creator_form_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IVCreatorFormCubit extends Cubit<AIVCreatorFormState> {
  final MaxIVFormCubit maxIVFormCubit = globalLocator<MaxIVFormCubit>();
  late IVCreatorFormModel ivCreatorFormModel;

  IVCreatorFormCubit() : super(IVCreatorFormInitState());

  void getNextView() {
    ivCreatorFormModel = IVCreatorFormModel(maxIVFormCubit.maxIVFormModel.getAmountList());
    emit(IVCreatorFormNextButtonPressedState(getNextView: ivCreatorFormModel.getNextWidget()));
  }

  void getPreviousView() {
    ivCreatorFormModel = IVCreatorFormModel(maxIVFormCubit.maxIVFormModel.getAmountList());
    emit(IVCreatorFormBackButtonPressedState(getPreviousView: ivCreatorFormModel.getPreviousWidget()));
  }
}
