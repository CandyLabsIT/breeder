import 'package:breeder/shared/cubit/input_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputCubit extends Cubit<InputState> {
  InputCubit() : super(InputInitial());

  void getUserInput(int userInput){
    emit(GetUserInput(userInput));
  }

  void getInputsSum(int sum) {
    emit(GetInputsSum(sum));
  }
}
