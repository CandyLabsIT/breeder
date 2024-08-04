import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen_index.dart';

class SecondGenModel {
  late Map<SecondGenIndex, List<IVColor>> colorMap = <SecondGenIndex, List<IVColor>>{
    for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
  };

  void updateMapValues(SecondGenIndex index, IVColor ivColor) {
    for (int i = 0; i <= 1; i++) {
      if (colorMap[index]![i] == ivColor) {
        colorMap[index]![i] = IVColor.defaultColor;
        break;
      } else if (colorMap[index]![i] == IVColor.defaultColor) {
        colorMap[index]![i] = ivColor;
        break;
      }
    }
  }

  void restartMapValues(SecondGenIndex index) {
    colorMap[index] = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
  }

  void restartAll() {
    colorMap = <SecondGenIndex, List<IVColor>>{
      for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
    };
  }

  bool isListFilled(SecondGenIndex index) {
    return colorMap[index]!.any((IVColor ivColor) => ivColor != IVColor.defaultColor);
  }

  bool hasCommonValue(SecondGenIndex index) {
    List<IVColor> currentList = colorMap[index]!;
    List<IVColor> secondList = colorMap[getIndex(index)]!;
    return currentList.toSet().intersection(secondList.toSet()).isNotEmpty;
  }

  SecondGenIndex getIndex(SecondGenIndex index) {
    if (isFemale(index)) {
      return _getMaleIndex(index);
    } else {
      return _getFemaleIndex(index);
    }
  }

  bool isFemale(SecondGenIndex index) {
    if (index.value.isOdd) {
      return false;
    }
    return true;
  }

  SecondGenIndex _getMaleIndex(SecondGenIndex index) {
    int next = index.value + 1;
    return SecondGenIndex.values.firstWhere((SecondGenIndex element) => element.value == next);
  }

  SecondGenIndex _getFemaleIndex(SecondGenIndex index) {
    int previous = index.value - 1;
    return SecondGenIndex.values.firstWhere((SecondGenIndex element) => element.value == previous);
  }

  // Map<SecondGenIndex, List<IVColor>> getFemaleColors() {
  //   return _getColors(SecondGenIndex.zero);
  // }
  //
  // Map<SecondGenIndex, List<IVColor>> getMaleColors() {
  //   return _getColors(SecondGenIndex.one);
  // }
  //
  // Map<SecondGenIndex, List<IVColor>> _getColors(SecondGenIndex index) {
  //   Map<SecondGenIndex, List<IVColor>> map = <SecondGenIndex, List<IVColor>>{};
  //   SecondGenIndex max = SecondGenIndex.fifteen;
  //
  //   if (isFemale(index)) {
  //     max = SecondGenIndex.fourteen;
  //   }
  //
  //   for (int i = index.value; i <= max.value; i += 2) {
  //     SecondGenIndex key = SecondGenIndex.values.firstWhere((SecondGenIndex element) => element.value == i);
  //     map[key] = colorMap[key]!;
  //   }
  //   return map;
  // }
}
