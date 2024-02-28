abstract class InputState{
  final int monsterValue;

  InputState(this.monsterValue);
}


class InputInitial extends InputState{
  InputInitial() : super(0);
}

class GetInputsSum extends InputState{
  GetInputsSum(super.monsterValue);
}

class GetUserInput extends InputState{
  GetUserInput(super.monsterValue);
}