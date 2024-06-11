import 'dart:ui';

class SecondGenerationModel {
  late List<int> secondGenerationFemaleIVList = <int>[0, 0];
  late List<int> secondGenerationMaleIVList = <int>[0, 0];

  static const Color defaultColor = Color(0xFFD9D9D9);
  static final Map<int, Color> colorMap = <int, Color>{
    0: defaultColor,
    1: const Color(0xFFFA4A78),
    2: const Color(0xFF7AE3FC),
    3: const Color(0xFFFDFB8E),
    4: const Color(0xFFFFDAD6),
    5: const Color(0xFFCFA9F2),
    6: const Color(0xFF96EF9E),
  };

  List<Color> getFemaleColors(int value) {
    _updateValues(secondGenerationFemaleIVList, value);
    return <Color>[colorMap[secondGenerationFemaleIVList[0]] ?? defaultColor, colorMap[secondGenerationFemaleIVList[1]] ?? defaultColor];
  }

  List<Color> getMaleColors(int value) {
    _updateValues(secondGenerationMaleIVList, value);
    return <Color>[colorMap[secondGenerationMaleIVList[0]] ?? defaultColor, colorMap[secondGenerationMaleIVList[1]] ?? defaultColor];
  }

  void _updateValues(List<int> list, int value) {
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

  List<bool> isFemaleButtonEnable() {
    return _getButtonEnableState(secondGenerationFemaleIVList, secondGenerationMaleIVList);
  }

  List<bool> isMaleButtonEnable() {
    return _getButtonEnableState(secondGenerationMaleIVList, secondGenerationFemaleIVList);
  }

  List<bool> _getButtonEnableState(List<int> primaryList, List<int> secondaryList) {
    final List<bool> buttonsList = List<bool>.filled(7, true);

    if (_sumList(primaryList) > 0) {
      if (_hasCommonValue(primaryList, secondaryList)) {
        if (primaryList[0] != 0 && primaryList[1] != 0) {
          for (int i = 0; i < 7; i++) {
            buttonsList[i] = primaryList[0] == i || primaryList[1] == i;
          }
          return buttonsList;
        }
        if (secondaryList[0] != 0 && secondaryList[1] != 0) {
          int index = 0;
          if (primaryList[0] == secondaryList[0] || primaryList[1] == secondaryList[0]) {
            index = secondaryList[1];
            buttonsList[index] = false;
          } else if (primaryList[0] == secondaryList[1] || primaryList[1] == secondaryList[1]) {
            index = secondaryList[0];
            buttonsList[index] = false;
          }
        }
      } else {
        if (primaryList[0] != 0 && primaryList[1] != 0) {
          for (int i = 1; i < 7; i++) {
            buttonsList[i] = primaryList[0] == i || primaryList[1] == i;
          }
        } else {
          for (int i = 0; i < 7; i++) {
            buttonsList[i] = secondaryList[0] == i || secondaryList[1] == i || primaryList[0] == i || primaryList[1] == i;
          }
        }
      }
    }
    return buttonsList;
  }

  bool _hasCommonValue(List<int> list1, List<int> list2) {
    return list1.toSet().intersection(list2.toSet()).isNotEmpty;
  }

  int _sumList(List<int> list) {
    return list.fold(0, (int previousValue, int element) => previousValue + element);
  }

  List<Color> restartFemaleValues() {
    secondGenerationFemaleIVList = <int>[0, 0];
    return <Color>[defaultColor, defaultColor];
  }

  List<Color> restartMaleValues() {
    secondGenerationMaleIVList = <int>[0, 0];
    return <Color>[defaultColor, defaultColor];
  }

  bool isFemaleRestartButtonEnabled() {
    return _isRestartButtonEnabled(secondGenerationFemaleIVList);
  }

  bool isMaleRestartButtonEnabled() {
    return _isRestartButtonEnabled(secondGenerationMaleIVList);
  }

  bool _isRestartButtonEnabled(List<int> list) {
    return _sumList(list) != 0;
  }
}
