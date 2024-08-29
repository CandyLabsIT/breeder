import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';

class FirstGenModel {
  MonsterModel monsterModel() {
    List<IVColor> ivList = <IVColor>[IVColor.defaultColor];
    bool isAutoFilledBool = false;
    MonsterGen monsterGen = MonsterGen.firstGen;

    MonsterModel monster = MonsterModel(ivList: ivList, isAutoFilledBool: isAutoFilledBool, monsterGen: monsterGen);
    return monster;
  }

  late Map<FirstGenIndex, List<IVColor>> firstGenMap = <FirstGenIndex, List<IVColor>>{
    for (FirstGenIndex firstGenIndex in FirstGenIndex.values) firstGenIndex: monsterModel().ivList
  };

  void updateIVColor(FirstGenIndex firstGenIndex, IVColor ivColor) {
    List<IVColor> ivColorList = List<IVColor>.from(firstGenMap[firstGenIndex]!);

    firstGenMap[firstGenIndex] = monsterModel().updateIVColor(ivColorList, ivColor);
  }

  void resetMonsterToDefaultIVColors(FirstGenIndex firstGenIndex) {
    List<IVColor> ivColorList = List<IVColor>.from(firstGenMap[firstGenIndex]!);
    firstGenMap[firstGenIndex] = monsterModel().resetMonsterToDefaultIVColors(ivColorList);
  }

  void resetAll() {
    for (FirstGenIndex index in FirstGenIndex.values) {
      List<IVColor> ivColorList = List<IVColor>.from(firstGenMap[index]!);
      firstGenMap[index] = monsterModel().resetMonsterToDefaultIVColors(ivColorList);
    }
  }

  bool hasIVValue(FirstGenIndex firstGenIndex) {
    bool ivValueBool = firstGenMap[firstGenIndex]!.any((IVColor ivColor) => ivColor != IVColor.defaultColor);

    return ivValueBool;
  }

  bool isPreviousPairFilled(FirstGenIndex firstGenIndex) {
    bool isFilled = true;
    FirstGenIndex previousFemaleFirstGenIndex;
    FirstGenIndex previousMaleFirstGenIndex;

    FirstGenIndex femaleGenIndex = getFemaleIndex(firstGenIndex);

    if (femaleGenIndex == firstGenIndex) {
      previousFemaleFirstGenIndex = getPreviousFemaleIndex(firstGenIndex);
      previousMaleFirstGenIndex = getMaleIndex(previousFemaleFirstGenIndex);
    } else {
      previousMaleFirstGenIndex = getPreviousMaleIndex(firstGenIndex);
      previousFemaleFirstGenIndex = getFemaleIndex(firstGenIndex);
    }

    bool isPreviousFemaleFilled = firstGenMap[previousFemaleFirstGenIndex]!.contains(IVColor.defaultColor);
    bool isPreviousMaleFilled = firstGenMap[previousMaleFirstGenIndex]!.contains(IVColor.defaultColor);

    if (!isPreviousFemaleFilled || !isPreviousMaleFilled) {
      isFilled = false;
    }

    return isFilled;
  }

  FirstGenIndex getPreviousFemaleIndex(FirstGenIndex firstGenIndex) {
    int previousFemaleValue;
    int firstGenValue = firstGenIndex.value;

    if (firstGenValue.isOdd) {
      previousFemaleValue = firstGenValue - 2;
    } else {
      previousFemaleValue = firstGenValue - 3;
    }

    FirstGenIndex previousFemaleFirstGenIndex =
        FirstGenIndex.values.firstWhere((FirstGenIndex firstGenIndex) => firstGenIndex.value == previousFemaleValue);
    return previousFemaleFirstGenIndex;
  }

  FirstGenIndex getPreviousMaleIndex(FirstGenIndex firstGenIndex) {
    int previousFemaleValue;
    int firstGenValue = firstGenIndex.value;

    if (firstGenValue.isOdd) {
      previousFemaleValue = firstGenValue - 2;
    } else {
      previousFemaleValue = firstGenValue - 3;
    }

    FirstGenIndex previousFemaleFirstGenIndex =
    FirstGenIndex.values.firstWhere((FirstGenIndex firstGenIndex) => firstGenIndex.value == previousFemaleValue);
    return previousFemaleFirstGenIndex;
  }

  FirstGenIndex getFemaleIndex(FirstGenIndex firstGenIndex) {
    if (firstGenIndex.value.isOdd) {
      return firstGenIndex;
    }

    int femaleIndexValue = firstGenIndex.value - 1;
    FirstGenIndex femaleFirstGenIndex = FirstGenIndex.values.firstWhere((FirstGenIndex firstGenIndex) => firstGenIndex.value == femaleIndexValue);

    return femaleFirstGenIndex;
  }

  FirstGenIndex getMaleIndex(FirstGenIndex firstGenIndex) {
    if (firstGenIndex.value.isEven) {
      return firstGenIndex;
    }

    int maleIndexValue = firstGenIndex.value + 1;
    FirstGenIndex maleFirstGenIndex = FirstGenIndex.values.firstWhere((FirstGenIndex firstGenIndex) => firstGenIndex.value == maleIndexValue);

    return maleFirstGenIndex;
  }
}
