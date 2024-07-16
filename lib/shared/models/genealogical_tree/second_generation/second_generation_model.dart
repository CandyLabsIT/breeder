import 'dart:ui';

class SecondGenerationModel {
  late List<List<List<int>>> secondGenerationIVList =
      List<List<List<int>>>.generate(8, (_) => List<List<int>>.generate(2, (_) => List<int>.generate(2, (_) => 0)));

  late List<List<Color>> childrenColorsList = List<List<Color>>.generate(16, (_) => List<Color>.generate(3, (_) => const Color(0xFFD9D9D9)));

  void updateValues(List<int> list, int value) {
    if (list[0] == value) {
      list[0] = 0;
    } else if (list[1] == value) {
      list[1] = 0;
    } else if (list[0] == 0) {
      list[0] = value;
    } else if (list[1] == 0) {
      list[1] = value;
    }
  }

  List<int> restartListValues(List<int> valueList) {
    valueList[0] = 0;
    valueList[1] = 0;

    return valueList;
  }

  void restartAll() {
    secondGenerationIVList = List<List<List<int>>>.generate(8, (_) => List<List<int>>.generate(2, (_) => List<int>.generate(2, (_) => 0)));
    childrenColorsList = List<List<Color>>.generate(16, (_) => List<Color>.generate(3, (_) => const Color(0xFFD9D9D9)));
  }

  bool isSumPositive(List<int> list) {
    return list.fold(0, (int previousValue, int element) => previousValue + element) > 0;
  }

  bool hasCommonValue(List<int> primaryList, List<int> secondaryList) {
    return primaryList.toSet().intersection(secondaryList.toSet()).isNotEmpty;
  }

  bool isPairFilled(int pairIndex) {
    bool isFilled = true;
    bool female = secondGenerationIVList[pairIndex][0].contains(0);
    bool male = secondGenerationIVList[pairIndex][1].contains(0);

    if (female || male) {
      return false;
    }
    return isFilled;
  }
}