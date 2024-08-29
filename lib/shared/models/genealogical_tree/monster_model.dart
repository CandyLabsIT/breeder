import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';

class MonsterModel {
  final List<IVColor> ivList;
  final bool isAutoFilledBool;
  final MonsterGen monsterGen;

  const MonsterModel({
    required this.ivList,
    required this.isAutoFilledBool,
    required this.monsterGen
  });

  List<IVColor> updateIVColor(List<IVColor> ivColorList, IVColor ivColor) {
    // find if ivColorList contains ivColor, if yes set this color to replace, if not set defaultColor as IVColor to replace
    IVColor ivColorToReplace = ivColorList.contains(ivColor) ? ivColor : IVColor.defaultColor;
    int listLength = ivColorList.length;

    for (int i = 0; i < listLength; i++) {
      if (ivColorList[i] == ivColorToReplace) {
        // replace list element with ivColorToReplace, if element is ivColor -> defaultColor else defaultColor -> ivColor
        ivColorList[i] = (ivColorToReplace == ivColor) ? IVColor.defaultColor : ivColor;
        break;
      }
    }

    return ivColorList;
  }

  List<IVColor> resetMonsterToDefaultIVColors(List<IVColor> ivColorList) {
    for (int index = 0; index < monsterGen.value; index++){
      ivList[index] = IVColor.defaultColor;
    }
      return ivColorList;
  }
}