import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';

class SecondGenModel {
  MonsterModel secondGenMonsterModel() {
    List<IVColor> ivList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
    bool isAutoFilledBool = false;
    MonsterGen monsterGen = MonsterGen.secondGen;

    MonsterModel secondGenMonster = MonsterModel(ivColorList: ivList, isAutoFilledBool: isAutoFilledBool, monsterGen: monsterGen);

    return secondGenMonster;
  }

  late Map<SecondGenIndex, MonsterModel> secondGenMap = <SecondGenIndex, MonsterModel>{
    for (SecondGenIndex secondGenIndex in SecondGenIndex.values) secondGenIndex: secondGenMonsterModel()
  };

  int getFatherIndexValue(SecondGenIndex secondGenIndex) {
    int secondGenIndexValue = secondGenIndex.value;
    int fatherGenIndexValue = secondGenIndexValue * 2;
    return fatherGenIndexValue;
  }

  int getMotherIndexValue(SecondGenIndex secondGenIndex) {
    int secondGenIndexValue = secondGenIndex.value;
    int motherIndexValue = secondGenIndexValue * 2 - 1;
    return motherIndexValue;
  }

  void inheritIVFromParents(SecondGenIndex secondGenIndex, List<IVColor> ivColorList) {
    MonsterModel inheritedDataMonsterModel = secondGenMonsterModel().inheritValues(ivColorList, MonsterGen.secondGen);
    secondGenMap[secondGenIndex] = inheritedDataMonsterModel;
  }

  void setDefaultValues(SecondGenIndex secondGenIndex) {
    MonsterModel defaultMonsterModel = secondGenMonsterModel().getDefaultIVColors();
    secondGenMap[secondGenIndex] = defaultMonsterModel;
  }
}
