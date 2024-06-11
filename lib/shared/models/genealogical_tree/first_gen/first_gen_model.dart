import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';

class FirstGenModel {
  late final Map<FirstGenIndex, MonsterModel> _firstGenMap = <FirstGenIndex, MonsterModel>{
    for (FirstGenIndex firstGenIndex in FirstGenIndex.values) firstGenIndex: _firstGenMonsterModel()
  };

  void updateIVColor(FirstGenIndex firstGenIndex, IVColor newIVColor) {
    MonsterModel currentMonsterModel = firstGenMap[firstGenIndex]!;
    List<IVColor> currentIVColorList = List<IVColor>.from(currentMonsterModel.ivColorList);
    IVColor currentIVColor = currentIVColorList[0];

    if (currentIVColor == newIVColor) {
      resetMonsterToDefaultIVColors(firstGenIndex);
    } else {
      MonsterModel updatedMonsterModel = _firstGenMonsterModel().updateIVColor(currentIVColorList, newIVColor);
      firstGenMap[firstGenIndex] = updatedMonsterModel;
    }
  }

  void resetMonsterToDefaultIVColors(FirstGenIndex firstGenIndex) {
    int firstGenIndexValue = firstGenIndex.value;
    int firstGenIndexLength = FirstGenIndex.values.length;

    for (int i = firstGenIndexValue; i < firstGenIndexLength; i++) {
      FirstGenIndex currentFirstGenIndex = getIndexFromValue(i);
      if (hasNonDefaultIVColor(currentFirstGenIndex)) {
        _setDefaultMonsterModel(currentFirstGenIndex);
      } else {
        break;
      }
    }
  }

  void resetAll() {
    for (FirstGenIndex firstGenIndex in FirstGenIndex.values) {
      if (hasNonDefaultIVColor(firstGenIndex)) {
        _setDefaultMonsterModel(firstGenIndex);
      } else {
        break;
      }
    }
  }

  bool hasNonDefaultIVColor(FirstGenIndex firstGenIndex) {
    bool ivValueBool = firstGenMap[firstGenIndex]!.ivColorList.any((IVColor ivColor) => ivColor != IVColor.defaultColor);
    return ivValueBool;
  }

  FirstGenIndex getActivePairFemaleIndex(FirstGenIndex firstGenIndex) {
    if (firstGenIndex.value.isOdd) {
      return firstGenIndex;
    }

    int femaleIndexValue = firstGenIndex.value - 1;
    FirstGenIndex femaleFirstGenIndex = getIndexFromValue(femaleIndexValue);

    return femaleFirstGenIndex;
  }

  FirstGenIndex getPreviousPairMaleIndex(FirstGenIndex firstGenIndex) {
    int previousMaleValue;
    int firstGenValue = firstGenIndex.value;

    if (firstGenValue.isEven) {
      previousMaleValue = firstGenValue - 2;
    } else {
      previousMaleValue = firstGenValue - 1;
    }
    FirstGenIndex previousMaleFirstGenIndex = getIndexFromValue(previousMaleValue);
    return previousMaleFirstGenIndex;
  }

  FirstGenIndex getIndexFromValue(int firstGenIndexValue) {
    FirstGenIndex firstGenIndex = FirstGenIndex.values.firstWhere((FirstGenIndex firstGenIndex) => firstGenIndex.value == firstGenIndexValue);
    return firstGenIndex;
  }

  void _setDefaultMonsterModel(FirstGenIndex firstGenIndex) {
    if (firstGenMap.containsKey(firstGenIndex)) {
      MonsterModel resetMonsterModel = firstGenMap[firstGenIndex]!.getDefaultIVColors();
      firstGenMap[firstGenIndex] = resetMonsterModel;
    }
  }

  MonsterModel _firstGenMonsterModel() {
    List<IVColor> ivColorList = <IVColor>[IVColor.defaultColor];
    bool isAutoFilledBool = false;
    MonsterGen monsterGen = MonsterGen.firstGen;

    MonsterModel firstGenMonsterModel = MonsterModel(ivColorList: ivColorList, isAutoFilledBool: isAutoFilledBool, monsterGen: monsterGen);
    return firstGenMonsterModel;
  }

  Map<FirstGenIndex, MonsterModel> get firstGenMap => _firstGenMap;
}
