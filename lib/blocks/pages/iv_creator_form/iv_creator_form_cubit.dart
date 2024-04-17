import 'package:breeder/blocks/pages/iv_creator_form/a_iv_creator_form_state.dart';
import 'package:breeder/blocks/pages/iv_creator_form/state/iv_creator_form_back_button_pressed_state.dart';
import 'package:breeder/blocks/pages/iv_creator_form/state/iv_creator_form_init_state.dart';
import 'package:breeder/blocks/pages/iv_creator_form/state/iv_creator_form_next_button_pressed_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaxIVFormCubit extends Cubit<AIVCreatorFormState> {

  MaxIVFormCubit() : super(IVCreatorFormInitState());

  void nextView(){

  }

  void backButton(){
    emit(IVCreatorFormBackButtonPressedState(backView: backView));
  }

  void nextButton(){
    emit(IVCreatorFormNextButtonPressedState(nextView: nextView));
  }

}
