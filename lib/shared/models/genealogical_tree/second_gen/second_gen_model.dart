class SecondGenModel {

  late List<List<List<int>>> secondGenIVList =
  List<List<List<int>>>.generate(8, (_) => List<List<int>>.generate(2, (_) => List<int>.generate(2, (_) => 0)));

  void updateListValues(int indexList, int gender, int ivValue) {
    if (secondGenIVList[indexList][gender][0] == ivValue) {
      secondGenIVList[indexList][gender][0] = 0;
    } else if (secondGenIVList[indexList][gender][1] == ivValue) {
      secondGenIVList[indexList][gender][1] = 0;
    } else if (secondGenIVList[indexList][gender][0] == 0) {
      secondGenIVList[indexList][gender][0] = ivValue;
    } else if (secondGenIVList[indexList][gender][1] == 0) {
      secondGenIVList[indexList][gender][1] = ivValue;
    }
  }

  void restartListValues(int indexList, int gender) {
    secondGenIVList[indexList][gender].fillRange(0, 2, 0);
  }

  void restartAll() {
    secondGenIVList = List<List<List<int>>>.generate(8, (_) => List<List<int>>.generate(2, (_) => List<int>.generate(2, (_) => 0)));
  }

  bool isSumPositive(int indexList, int gender) {
    return secondGenIVList[indexList][gender].fold(0, (int previousValue, int element) => previousValue + element) > 0;
  }

  bool hasCommonValue(int indexList) {
    return secondGenIVList[indexList][0].toSet().intersection(secondGenIVList[indexList][1].toSet()).isNotEmpty;
  }
}
