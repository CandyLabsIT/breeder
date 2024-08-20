import 'dart:ui';

import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_gen_index.dart';

class ThirdGenerationModel {
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

  bool isIVListFilled(ThirdGenIndex thirdGenIndex) {
    return thirdGenMap[thirdGenIndex]!.any((IVColor ivColor) => ivColor != IVColor.defaultColor);
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
