class ThirdGenerationModel {
  late List<List<List<int>>> thirdGenerationIVList =
      List<List<List<int>>>.generate(4, (_) => List<List<int>>.generate(2, (_) => List<int>.generate(3, (_) => 0)));

  void updateValues(List<int> ivList, int value) {

    for (int i = 0; i < 3; i++) {
      if (ivList[i] == value) {
        ivList[i] = 0;
      }
      if (ivList[i] == 0) {
        ivList[i] = value;
      }
    }
  }

  void restartListValues(List<int> list) {
    list.fillRange(0, list.length, 0);
  }

  bool isSumPositive(List<int> list) {
    return list.fold(0, (int previousValue, int element) => previousValue + element) > 0;
  }

  bool hasCommonValue(List<int> primaryList, List<int> secondaryList) {
    return primaryList.toSet().intersection(secondaryList.toSet()).isNotEmpty;
  }
}
