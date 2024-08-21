import 'dart:ui';

import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_gen_index.dart';

class ThirdGenModel {
  late Map<ThirdGenIndex, List<IVColor>> thirdGenMap = <ThirdGenIndex, List<IVColor>>{
    for (ThirdGenIndex index in ThirdGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
  };

  late List<List<Color>> childrenColorsList = List<List<Color>>.generate(8, (_) => List<Color>.generate(4, (_) => const Color(0xFFD9D9D9)));

  void updateMapValues(ThirdGenIndex thirdGenIndex, IVColor ivColor) {
    List<IVColor> ivColorList = List<IVColor>.from(thirdGenMap[thirdGenIndex]!);

    // find if ivColorList contains ivColor, if yes set this color to replace, if not set defaultColor as IVColor to replace
    IVColor ivColorToReplace = ivColorList.contains(ivColor) ? ivColor : IVColor.defaultColor;

    for (int i = 0; i <= 2; i++) {
      if (ivColorList[i] == ivColorToReplace) {
        // replace list element with ivColorToReplace, if element is ivColor -> defaultColor else defaultColor -> ivColor
        ivColorList[i] = (ivColorToReplace == ivColor) ? IVColor.defaultColor : ivColor;
        break;
      }
    }

    thirdGenMap[thirdGenIndex] = ivColorList;
  }

  void resetIVListValues(ThirdGenIndex thirdGenIndex) {
    thirdGenMap[thirdGenIndex] = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
  }

  void restartAll() {
    thirdGenMap = <ThirdGenIndex, List<IVColor>>{
      for (ThirdGenIndex index in ThirdGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
    };
  }

  void updateListValues(ThirdGenIndex thirdGenIndex, List<IVColor> parentsList) {
    if (!parentsList.contains(IVColor.defaultColor)) {
      thirdGenMap[thirdGenIndex] = parentsList;
    }
  }

  bool isIVListFilled(ThirdGenIndex thirdGenIndex) {
    return thirdGenMap[thirdGenIndex]!.any((IVColor ivColor) => ivColor != IVColor.defaultColor);
  }

  bool hasCommonValue(ThirdGenIndex thirdGenIndex) {
    List<IVColor> femaleIVColorList = thirdGenMap[getFemaleIndex(thirdGenIndex)]!;
    List<IVColor> maleIVColorList = thirdGenMap[getMaleIndex(thirdGenIndex)]!;
    return femaleIVColorList
        .toSet()
        .intersection(maleIVColorList.toSet())
        .isNotEmpty;
  }

  ThirdGenIndex getFemaleIndex(ThirdGenIndex thirdGenIndex) {
    if (thirdGenIndex.value.isOdd) {
      return thirdGenIndex;
    }
    int femaleIndexValue = thirdGenIndex.value - 1;
    return ThirdGenIndex.values.firstWhere((ThirdGenIndex thirdGenIndex) => thirdGenIndex.value == femaleIndexValue);
  }

  ThirdGenIndex getMaleIndex(ThirdGenIndex thirdGenIndex) {
    if (thirdGenIndex.value.isEven) {
      return thirdGenIndex;
    }
    int maleIndexValue = thirdGenIndex.value + 1;
    return ThirdGenIndex.values.firstWhere((ThirdGenIndex secondGenIndex) => secondGenIndex.value == maleIndexValue);
  }

  int countCommonValues(ThirdGenIndex thirdGenIndex) {
    Set<IVColor> femaleSet = thirdGenMap[getFemaleIndex(thirdGenIndex)]!.toSet()
      ..remove(IVColor.defaultColor);
    Set<IVColor> maleSet = thirdGenMap[getMaleIndex(thirdGenIndex)]!.toSet()
      ..remove(IVColor.defaultColor);

    Set<IVColor> intersectionSet = femaleSet.intersection(maleSet);
    int commonValues = intersectionSet.length;

    return commonValues;
  }
}
