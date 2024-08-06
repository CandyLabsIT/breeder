import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen_index.dart';

class SecondGenModel {
  late Map<SecondGenIndex, List<IVColor>> secondGenMap = <SecondGenIndex, List<IVColor>>{
    for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
  };

  void updateMapValues(SecondGenIndex secondGenIndex, IVColor ivColor) {
    // TODO(Balladyna): change name of currentList
    List<IVColor> ivColorList = List<IVColor>.from(secondGenMap[secondGenIndex]!);

    for (int i = 0; i <= 1; i++) {
      if (ivColorList[i] == ivColor) {
        ivColorList[i] = IVColor.defaultColor;
        break;
      } else if (ivColorList[i] == IVColor.defaultColor) {
        ivColorList[i] = ivColor;
        break;
      }
    }

    secondGenMap[secondGenIndex] = ivColorList;
  }

  void restartListValues(SecondGenIndex secondGenIndex) {
    secondGenMap[secondGenIndex] = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
  }

  void restartAll() {
    secondGenMap = <SecondGenIndex, List<IVColor>>{
      for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
    };
  }

  bool isListFilled(SecondGenIndex secondGenIndex) {
    return secondGenMap[secondGenIndex]!.any((IVColor ivColor) => ivColor != IVColor.defaultColor);
  }

  bool hasCommonValue(SecondGenIndex secondGenIndex) {
    List<IVColor> currentList = secondGenMap[secondGenIndex]!;
    List<IVColor> secondList = secondGenMap[getIndex(secondGenIndex)]!;
    return currentList.toSet().intersection(secondList.toSet()).isNotEmpty;
  }

  SecondGenIndex getIndex(SecondGenIndex secondGenIndex) {
    if (isFemale(secondGenIndex)) {
      return _getMaleIndex(secondGenIndex);
    } else {
      return _getFemaleIndex(secondGenIndex);
    }
  }

  bool isFemale(SecondGenIndex secondGenIndex) {
    if (secondGenIndex.value.isEven) {
      return false;
    }
    return true;
  }

  SecondGenIndex _getMaleIndex(SecondGenIndex secondGenIndex) {
    int next = secondGenIndex.value + 1;
    return SecondGenIndex.values.firstWhere((SecondGenIndex secondGenIndex) => secondGenIndex.value == next);
  }

  SecondGenIndex _getFemaleIndex(SecondGenIndex secondGenIndex) {
    int femaleIndex = secondGenIndex.value - 1;
    return SecondGenIndex.values.firstWhere((SecondGenIndex secondGenIndex) => secondGenIndex.value == femaleIndex);
  }
}
