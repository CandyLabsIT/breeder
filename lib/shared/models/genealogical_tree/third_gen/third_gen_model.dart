import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:breeder/shared/models/genealogical_tree/third_gen/third_gen_index.dart';

class ThirdGenModel {
  MonsterModel thirdGenMonsterModel() {
    List<IVColor> ivColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor, IVColor.defaultColor];
    bool isAutoFilledBool = false;
    MonsterGen monsterGen = MonsterGen.thirdGen;

    MonsterModel thirdGenMonsterModel = MonsterModel(ivColorList: ivColorList, isAutoFilledBool: isAutoFilledBool, monsterGen: monsterGen);

    return thirdGenMonsterModel;
  }

  late Map<ThirdGenIndex, MonsterModel> thirdGenMap = <ThirdGenIndex, MonsterModel>{
    for (ThirdGenIndex thirdGenIndex in ThirdGenIndex.values) thirdGenIndex: thirdGenMonsterModel()
  };

  int getFatherIndexValue(ThirdGenIndex thirdGenIndex){
    int thirdGenIndexValue = thirdGenIndex.value;
    int fatherIndexValue = thirdGenIndexValue * 2;
    return fatherIndexValue;
  }

  int getMotherIndex
}
