class ThirdGenerationModel {
  late List<List<List<int>>> thirdGenerationIVList =
      List<List<List<int>>>.generate(4, (_) => List<List<int>>.generate(2, (_) => List<int>.generate(3, (_) => 0)));

  List<int> updateValues(List<int> ivList, int value) {
    if (ivList.contains(value)) {
      int index = ivList.indexOf(value);
      ivList[index] = 0;
      return ivList;
    } else {
      for (int i = 0; i < 3; i++) {
        if (ivList[i] == value) {
          ivList[i] = 0;
          break;
        }
        if (ivList[i] == 0) {
          ivList[i] = value;
          break;
        }
      }
    }
    return ivList;
  }

  void restartListValues(List<int> list) {
    list.fillRange(0, list.length, 0);
  }



  bool isSumPositive(List<int> list) {
    return list.fold(0, (int previousValue, int element) => previousValue + element) > 0;
  }

  int hasCommonValue(List<int> primaryList, List<int> secondaryList) {
    Set<int> secondarySet = secondaryList.toSet();
    int commonElements = 0;

    for (int element in primaryList) {
      if (element > 0 && secondarySet.contains(element)) {
        commonElements++;
      }
    }

    return commonElements;
  }
}
