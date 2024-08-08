import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen_index.dart';

class SecondGenModel {
  late Map<SecondGenIndex, List<IVColor>> secondGenMap = <SecondGenIndex, List<IVColor>>{
    for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
  };

  void updateMapValues(SecondGenIndex secondGenIndex, IVColor ivColor) {
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

  void resetAll() {
    secondGenMap = <SecondGenIndex, List<IVColor>>{
      for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
    };
  }

  bool isListFilled(SecondGenIndex secondGenIndex) {
    return secondGenMap[secondGenIndex]!.any((IVColor ivColor) => ivColor != IVColor.defaultColor);
  }

  bool hasCommonValue(SecondGenIndex secondGenIndex) {
    List<IVColor> activeMonsterIVColorList = secondGenMap[secondGenIndex]!;
    List<IVColor> pairedMonsterIVColorList = secondGenMap[getIndex(secondGenIndex)]!;
    return activeMonsterIVColorList.toSet().intersection(pairedMonsterIVColorList.toSet()).isNotEmpty;
  }

  SecondGenIndex getIndex(SecondGenIndex secondGenIndex) {
    if (_isFemale(secondGenIndex)) {
      return _getMaleIndex(secondGenIndex);
    } else {
      return _getFemaleIndex(secondGenIndex);
    }
  }

  bool _isFemale(SecondGenIndex secondGenIndex) {
    if (secondGenIndex.value.isEven) {
      return false;
    }
    return true;
  }

  SecondGenIndex _getMaleIndex(SecondGenIndex secondGenIndex) {
    int maleIndexValue = secondGenIndex.value + 1;
    return SecondGenIndex.values.firstWhere((SecondGenIndex secondGenIndex) => secondGenIndex.value == maleIndexValue);
  }

  SecondGenIndex _getFemaleIndex(SecondGenIndex secondGenIndex) {
    int femaleIndexValue = secondGenIndex.value - 1;
    return SecondGenIndex.values.firstWhere((SecondGenIndex secondGenIndex) => secondGenIndex.value == femaleIndexValue);
  }
}
