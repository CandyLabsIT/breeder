import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';

class SecondGenModel {
  late Map<SecondGenIndex, List<IVColor>> secondGenMap = <SecondGenIndex, List<IVColor>>{
    for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
  };

  void updateMapValues(SecondGenIndex secondGenIndex, IVColor ivColor) {
    List<IVColor> ivColorList = List<IVColor>.from(secondGenMap[secondGenIndex]!);

    // find if ivColorList contains ivColor, if yes set this color to replace, if not set defaultColor as IVColor to replace
    IVColor ivColorToReplace = ivColorList.contains(ivColor) ? ivColor : IVColor.defaultColor;

    for (int i = 0; i <= 1; i++) {
      if (ivColorList[i] == ivColorToReplace) {
        // replace list element with ivColorToReplace, if element is ivColor -> defaultColor else defaultColor -> ivColor
        ivColorList[i] = (ivColorToReplace == ivColor) ? IVColor.defaultColor : ivColor;
        break;
      }
    }

    secondGenMap[secondGenIndex] = ivColorList;
  }

  void resetIVListValues(SecondGenIndex secondGenIndex) {
    secondGenMap[secondGenIndex] = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
  }

  void resetAll() {
    secondGenMap = <SecondGenIndex, List<IVColor>>{
      for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
    };
  }

  bool isIVListFilled(SecondGenIndex secondGenIndex) {
    return secondGenMap[secondGenIndex]!.any((IVColor ivColor) => ivColor != IVColor.defaultColor);
  }

  bool hasCommonValue(SecondGenIndex secondGenIndex) {
    List<IVColor> femaleIVColorList = secondGenMap[getFemaleIndex(secondGenIndex)]!;
    List<IVColor> maleIVColorList = secondGenMap[getMaleIndex(secondGenIndex)]!;
    return femaleIVColorList.toSet().intersection(maleIVColorList.toSet()).isNotEmpty;
  }

  SecondGenIndex getFemaleIndex(SecondGenIndex secondGenIndex) {
    if (secondGenIndex.value.isOdd) {
      return secondGenIndex;
    }
    int femaleIndexValue = secondGenIndex.value - 1;
    return SecondGenIndex.values.firstWhere((SecondGenIndex secondGenIndex) => secondGenIndex.value == femaleIndexValue);
  }

  SecondGenIndex getMaleIndex(SecondGenIndex secondGenIndex) {
    if (secondGenIndex.value.isEven) {
      return secondGenIndex;
    }
    int maleIndexValue = secondGenIndex.value + 1;
    return SecondGenIndex.values.firstWhere((SecondGenIndex secondGenIndex) => secondGenIndex.value == maleIndexValue);
  }

  List<IVColor> getChildList(SecondGenIndex maleIndex) {
    List<IVColor> childList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor, IVColor.defaultColor];
    SecondGenIndex femaleIndex = getFemaleIndex(maleIndex);
    if (isPairFilled(maleIndex)) {
      childList = (secondGenMap[femaleIndex]! + secondGenMap[maleIndex]!).toSet().toList();
    }
    return childList;
  }

  bool isPairFilled(SecondGenIndex secondGenIndex) {
    bool isFilled = true;
    bool female = secondGenMap[getFemaleIndex(secondGenIndex)]!.contains(IVColor.defaultColor);
    bool male = secondGenMap[getMaleIndex(secondGenIndex)]!.contains(IVColor.defaultColor);

    if (female || male) {
      return false;
    }
    return isFilled;
  }
}
