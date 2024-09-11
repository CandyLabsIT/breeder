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
    int firstGenIndexValue = firstGenIndex.value;
    int firstGenIndexLength = FirstGenIndex.values.length;

    for (int i = firstGenIndexValue; i < firstGenIndexLength; i++) {
      FirstGenIndex currentFirstGenIndex = getIndexFromValue(i);
      if (hasIVValue(currentFirstGenIndex)) {
        firstGenMap[currentFirstGenIndex] = monsterModel().resetMonsterToDefaultIVColors();
      } else {
        break;
      }
    }
  }

  void resetAll() {
    for (FirstGenIndex index in FirstGenIndex.values) {
      firstGenMap[index] = monsterModel().resetMonsterToDefaultIVColors();
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
      previousFemaleFirstGenIndex = getFemaleIndex(previousMaleFirstGenIndex);
    }

    bool isPreviousFemaleFilled = firstGenMap[previousFemaleFirstGenIndex]!.contains(IVColor.defaultColor);
    bool isPreviousMaleFilled = firstGenMap[previousMaleFirstGenIndex]!.contains(IVColor.defaultColor);

    if (isPreviousFemaleFilled || isPreviousMaleFilled) {
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

    FirstGenIndex previousFemaleFirstGenIndex = getIndexFromValue(previousFemaleValue);
    return previousFemaleFirstGenIndex;
  }

  FirstGenIndex getPreviousMaleIndex(FirstGenIndex firstGenIndex) {
    int previousMaleValue;
    int firstGenValue = firstGenIndex.value;

    if (firstGenValue.isEven) {
      previousMaleValue = firstGenValue - 2;
    } else {
      previousMaleValue = firstGenValue - 3;
    }

    FirstGenIndex previousMaleFirstGenIndex = getIndexFromValue(previousMaleValue);
    return previousMaleFirstGenIndex;
  }

  FirstGenIndex getFemaleIndex(FirstGenIndex firstGenIndex) {
    if (firstGenIndex.value.isOdd) {
      return firstGenIndex;
    }

    int femaleIndexValue = firstGenIndex.value - 1;
    FirstGenIndex femaleFirstGenIndex = getIndexFromValue(femaleIndexValue);

    return femaleFirstGenIndex;
  }

  FirstGenIndex getMaleIndex(FirstGenIndex firstGenIndex) {
    if (firstGenIndex.value.isEven) {
      return firstGenIndex;
    }

    int maleIndexValue = firstGenIndex.value + 1;
    FirstGenIndex maleFirstGenIndex = getIndexFromValue(maleIndexValue);

    return maleFirstGenIndex;
  }

  FirstGenIndex getIndexFromValue(int firstGenIndexValue) {
    FirstGenIndex firstGenIndex = FirstGenIndex.values.firstWhere((FirstGenIndex firstGenIndex) => firstGenIndex.value == firstGenIndexValue);
    return firstGenIndex;
  }

  bool isQuotientIndexValueEven(FirstGenIndex firstGenIndex) {
    int firstGenIndexValue = firstGenIndex.value;
    int firstGenIndexQuotient = firstGenIndexValue ~/ 2;
    bool isQuotientEvenBool = firstGenIndexQuotient.isEven;
    return isQuotientEvenBool;
  }

  Set<IVColor> getFirstGenSet(FirstGenIndex firstGenIndex) {
    int firstGenIndexValue = firstGenIndex.value;
    Set<IVColor> firstGenSet = <IVColor>{};
    for (int i = 0; i < firstGenIndexValue; i++) {
      FirstGenIndex index = getIndexFromValue(i);
      firstGenSet.addAll(firstGenMap[index]!);
    }
    return firstGenSet;
  }

  bool hasListValues(FirstGenIndex firstGenIndex) {
    Set<IVColor> firstGenSet = getFirstGenSet(firstGenIndex);
    List<IVColor> ivColorList = firstGenMap[firstGenIndex]!;
    bool containsListValuesBool = firstGenSet.containsAll(ivColorList);
    return containsListValuesBool;
  }

  Set<IVColor> getPreviousPair(FirstGenIndex firstGenIndex) {
    FirstGenIndex femaleIndex = getPreviousFemaleIndex(firstGenIndex);
    FirstGenIndex maleIndex = getPreviousMaleIndex(firstGenIndex);

    Set<IVColor> previousPairSet = <IVColor>{}..addAll(firstGenMap[femaleIndex]!)..addAll(firstGenMap[maleIndex]!);

    return previousPairSet;
  }

  Set<IVColor> getPreviousIVColorSet(FirstGenIndex firstGenIndex) {
    Set<IVColor> ivColorSet = <IVColor>{};
    int firstGenIndexValue = firstGenIndex.value;
    int maxFirstGenIndexValue;
    if (firstGenIndexValue > 4 && firstGenIndexValue <= 8) {
      maxFirstGenIndexValue = FirstGenIndex.four.value;
      ivColorSet = getIVColorSet(maxFirstGenIndexValue);
    } else if (firstGenIndexValue >= 9 && firstGenIndexValue <= 16) {
      maxFirstGenIndexValue = FirstGenIndex.eight.value;
      ivColorSet = getIVColorSet(maxFirstGenIndexValue);
    } else if (firstGenIndexValue > 16){
      maxFirstGenIndexValue = FirstGenIndex.sixteen.value;
      ivColorSet = getIVColorSet(maxFirstGenIndexValue);
    }
    return ivColorSet;
  }



  Set<IVColor> getIVColorSet(int maxFirstGenIndexValue) {
    Set<IVColor> ivColorSet = <IVColor>{};
    int startNumber = FirstGenIndex.one.value;
    for (int i = startNumber; i <= maxFirstGenIndexValue; i++) {
      FirstGenIndex currentIndex = getIndexFromValue(i);
      List<IVColor> firstGenList = firstGenMap[currentIndex]!;
      ivColorSet.addAll(firstGenList);
    }
    return ivColorSet;
  }


}
