import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';

class SecondGenModel {
  late Map<SecondGenIndex, List<IVColor>> secondGenMap = <SecondGenIndex, List<IVColor>>{
    for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
  };

  void updateIVColor(SecondGenIndex secondGenIndex, IVColor ivColor) {
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

  // TODO(balladyna): method names is very similar to cubit method name and also "Monster" in name could be misleading
  void resetMonsterToDefaultIVColors(SecondGenIndex secondGenIndex) {
    secondGenMap[secondGenIndex] = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
  }

  void resetAll() {
    secondGenMap = <SecondGenIndex, List<IVColor>>{
      for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
    };
  }

  bool hasIVValue(SecondGenIndex secondGenIndex) {
    bool ivValueBool = secondGenMap[secondGenIndex]!.any((IVColor ivColor) => ivColor != IVColor.defaultColor);

    return ivValueBool;
  }

  bool hasCommonIVColor(SecondGenIndex secondGenIndex) {
    List<IVColor> femaleIVColorList = secondGenMap[getFemaleIndex(secondGenIndex)]!;
    List<IVColor> maleIVColorList = secondGenMap[getMaleIndex(secondGenIndex)]!;

    bool commonIVColorBool = femaleIVColorList.toSet().intersection(maleIVColorList.toSet()).isNotEmpty;

    return commonIVColorBool;
  }

  SecondGenIndex getFemaleIndex(SecondGenIndex secondGenIndex) {
    if (secondGenIndex.value.isOdd) {
      return secondGenIndex;
    }

    int femaleIndexValue = secondGenIndex.value - 1;
    SecondGenIndex femaleSecondGenIndex =
        SecondGenIndex.values.firstWhere((SecondGenIndex secondGenIndex) => secondGenIndex.value == femaleIndexValue);

    return femaleSecondGenIndex;
  }

  SecondGenIndex getMaleIndex(SecondGenIndex secondGenIndex) {
    if (secondGenIndex.value.isEven) {
      return secondGenIndex;
    }

    int maleIndexValue = secondGenIndex.value + 1;
    SecondGenIndex maleSecondGenIndex = SecondGenIndex.values.firstWhere((SecondGenIndex secondGenIndex) => secondGenIndex.value == maleIndexValue);

    return maleSecondGenIndex;
  }
}
