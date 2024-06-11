import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_model.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final FirstGenModel firstGenModel = FirstGenModel();

  Map<FirstGenIndex, MonsterModel> actualMonsterMap = firstGenModel.firstGenMap;

  group('Test of FirstGenModel.updateIVColor', () {
    test('Should replace defaultColor with hpColor in ivColorList if ivColorList contains defaultColor]', () {
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.hpColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.firstGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      expectedIVColorList = expectedMonsterModel.ivColorList;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
      IVColor actualIVColor = IVColor.hpColor;

      firstGenModel.updateIVColor(actualFirstGenIndex, actualIVColor);

      List<IVColor> actualIVColorList = actualMonsterMap[actualFirstGenIndex]!.ivColorList;

      expect(actualIVColorList, expectedIVColorList);
    });

    test('Should remain unchanged ivColorList if list does not contain defaultColor or if ivColor is not any element of the list', () {
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.hpColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.firstGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      expectedIVColorList = expectedMonsterModel.ivColorList;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
      IVColor actualIVColor = IVColor.speedColor;

      firstGenModel.updateIVColor(actualFirstGenIndex, actualIVColor);

      List<IVColor> actualIVColorList = actualMonsterMap[actualFirstGenIndex]!.ivColorList;

      expect(actualIVColorList, expectedIVColorList);
    });

    test('Should replace hpColor with defaultColor if list contain hpColor and ivColor is equal to hpColor]', () {
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.firstGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      expectedIVColorList = expectedMonsterModel.ivColorList;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
      IVColor actualIVColor = IVColor.hpColor;

      firstGenModel.updateIVColor(actualFirstGenIndex, actualIVColor);

      List<IVColor> actualIVColorList = actualMonsterMap[actualFirstGenIndex]!.ivColorList;

      expect(actualIVColorList, expectedIVColorList);
    });
  });

  group('Test of FirstGenModel.resetMonsterToDefaultIVColors', () {
    test(
        'Should reset a FirstGenIndex.one and FirstGenIndex.two ivColorList monster to default IVColor values if FirstGenIndex.one is reset do default and both monsters does not contain defaultColor',
        () {
      bool expectedIsAutoFilledBool = false;
      MonsterGen expectedMonsterGen = MonsterGen.firstGen;

      MonsterModel expectedFirstGenMonsterModel() {
        List<IVColor> ivColorList = <IVColor>[IVColor.defaultColor];
        bool isAutoFilledBool = expectedIsAutoFilledBool;
        MonsterGen monsterGen = expectedMonsterGen;

        MonsterModel expectedFirstGenMonsterModel =
            MonsterModel(ivColorList: ivColorList, isAutoFilledBool: isAutoFilledBool, monsterGen: monsterGen);
        return expectedFirstGenMonsterModel;
      }

      late Map<FirstGenIndex, MonsterModel> expectedFirstGenMap = <FirstGenIndex, MonsterModel>{
        for (FirstGenIndex firstGenIndex in FirstGenIndex.values) firstGenIndex: expectedFirstGenMonsterModel()
      };
      expectedFirstGenMap[FirstGenIndex.one] =
          MonsterModel(ivColorList: const <IVColor>[IVColor.atkColor], isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: expectedMonsterGen);

      firstGenModel
        ..updateIVColor(FirstGenIndex.one, IVColor.atkColor)
        ..updateIVColor(FirstGenIndex.two, IVColor.hpColor);

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.two;

      firstGenModel.resetMonsterToDefaultIVColors(actualFirstGenIndex);

      expect(actualMonsterMap, expectedFirstGenMap);
    });

    test(
        'Should reset ivColorList monsters from FirstGenIndex.one to three to default IVColor values if FirstGenIndex.one is reset do default and they all do not contain defaultColor',
        () {
      MonsterModel expectedFirstGenMonsterModel() {
        List<IVColor> ivColorList = <IVColor>[IVColor.defaultColor];
        bool isAutoFilledBool = false;
        MonsterGen monsterGen = MonsterGen.firstGen;

        MonsterModel expectedFirstGenMonsterModel =
            MonsterModel(ivColorList: ivColorList, isAutoFilledBool: isAutoFilledBool, monsterGen: monsterGen);
        return expectedFirstGenMonsterModel;
      }

      late Map<FirstGenIndex, MonsterModel> expectedFirstGenMap = <FirstGenIndex, MonsterModel>{
        for (FirstGenIndex firstGenIndex in FirstGenIndex.values) firstGenIndex: expectedFirstGenMonsterModel()
      };

      firstGenModel
        ..updateIVColor(FirstGenIndex.one, IVColor.speedColor)
        ..updateIVColor(FirstGenIndex.two, IVColor.hpColor)
        ..updateIVColor(FirstGenIndex.three, IVColor.atkColor);

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
      actualMonsterMap = firstGenModel.firstGenMap;

      firstGenModel.resetMonsterToDefaultIVColors(actualFirstGenIndex);

      expect(actualMonsterMap, expectedFirstGenMap);
    });

    test(
        'Should reset monsters ivColorList from FirstGenIndex.three to four to default IVColor and remain unchanged monster one and two if FirstGenIndex.three is reset do default and they all do not contain defaultColor',
        () {
      bool expectedIsAutoFilledBool = false;
      MonsterGen expectedMonsterGen = MonsterGen.firstGen;

      MonsterModel expectedFirstGenMonsterModel() {
        List<IVColor> ivColorList = <IVColor>[IVColor.defaultColor];
        bool isAutoFilledBool = expectedIsAutoFilledBool;
        MonsterGen monsterGen = expectedMonsterGen;

        MonsterModel expectedFirstGenMonsterModel =
            MonsterModel(ivColorList: ivColorList, isAutoFilledBool: isAutoFilledBool, monsterGen: monsterGen);
        return expectedFirstGenMonsterModel;
      }

      late Map<FirstGenIndex, MonsterModel> expectedFirstGenMap = <FirstGenIndex, MonsterModel>{
        for (FirstGenIndex firstGenIndex in FirstGenIndex.values) firstGenIndex: expectedFirstGenMonsterModel()
      };
      expectedFirstGenMap[FirstGenIndex.one] =
          MonsterModel(ivColorList: const <IVColor>[IVColor.atkColor], isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: expectedMonsterGen);

      expectedFirstGenMap[FirstGenIndex.two] =
          MonsterModel(ivColorList: const <IVColor>[IVColor.hpColor], isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: expectedMonsterGen);

      firstGenModel
        ..updateIVColor(FirstGenIndex.one, IVColor.atkColor)
        ..updateIVColor(FirstGenIndex.two, IVColor.hpColor)
        ..updateIVColor(FirstGenIndex.three, IVColor.speedColor)
        ..updateIVColor(FirstGenIndex.four, IVColor.atkColor);

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.three;
      actualMonsterMap = firstGenModel.firstGenMap;

      firstGenModel.resetMonsterToDefaultIVColors(actualFirstGenIndex);

      expect(actualMonsterMap, expectedFirstGenMap);
    });
  });

  group('Test of FirstGenModel.resetAll', () {
    test('Should reset all monsters ivColorList to default IVColor values if FirstGenIndex.one to three do not contain defaultColor', () {
      MonsterModel expectedFirstGenMonsterModel() {
        List<IVColor> ivColorList = <IVColor>[IVColor.defaultColor];
        bool isAutoFilledBool = false;
        MonsterGen monsterGen = MonsterGen.firstGen;

        MonsterModel expectedFirstGenMonsterModel =
            MonsterModel(ivColorList: ivColorList, isAutoFilledBool: isAutoFilledBool, monsterGen: monsterGen);
        return expectedFirstGenMonsterModel;
      }

      late Map<FirstGenIndex, MonsterModel> expectedFirstGenMap = <FirstGenIndex, MonsterModel>{
        for (FirstGenIndex firstGenIndex in FirstGenIndex.values) firstGenIndex: expectedFirstGenMonsterModel()
      };

      firstGenModel
        ..updateIVColor(FirstGenIndex.one, IVColor.speedColor)
        ..updateIVColor(FirstGenIndex.two, IVColor.hpColor)
        ..resetAll();

      expect(actualMonsterMap, expectedFirstGenMap);
    });
  });

  group('Test of FirstGenModel.hasNonDefaultIVColor', () {
    test('Should return [false] if [ivColorList contain defaultColor]', () {
      bool expectedBool = false;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;

      bool actualBool = firstGenModel.hasNonDefaultIVColor(actualFirstGenIndex);

      expect(actualBool, expectedBool);
    });

    test('Should return [true] if ivColorList does not contain defaultColor', () {
      bool expectedBool = true;

      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
      IVColor actualIVColor = IVColor.atkColor;

      firstGenModel.updateIVColor(actualFirstGenIndex, actualIVColor);

      bool actualBool = firstGenModel.hasNonDefaultIVColor(actualFirstGenIndex);

      expect(actualBool, expectedBool);
    });
  });

  group('Test of FirstGenModel.getPreviousMaleIndex', () {
    test('Should return [FirstGenIndex.two] if [checked FirstGenIndex is three]', () {
      FirstGenIndex expectedFirstGenIndex = FirstGenIndex.two;

      FirstGenIndex actualFirstGenIndex = firstGenModel.getPreviousMaleIndex(FirstGenIndex.three);

      expect(actualFirstGenIndex, expectedFirstGenIndex);
    });

    test('Should return [FirstGenIndex.two] if [checked FirstGenIndex is four]', () {
      FirstGenIndex expectedFirstGenIndex = FirstGenIndex.two;

      FirstGenIndex actualFirstGenIndex = firstGenModel.getPreviousMaleIndex(FirstGenIndex.four);

      expect(actualFirstGenIndex, expectedFirstGenIndex);
    });
  });

  group('Test of FirstGenModel.getFemaleIndex', () {
    test('Should return [FirstGenIndex.tree] if [checked FirstGenIndex is four]', () {
      FirstGenIndex expectedFirstGenIndex = FirstGenIndex.three;

      FirstGenIndex actualFirstGenIndex = firstGenModel.getFemaleIndex(FirstGenIndex.four);

      expect(actualFirstGenIndex, expectedFirstGenIndex);
    });

    test('Should return [FirstGenIndex.five] if [checked FirstGenIndex is five]', () {
      FirstGenIndex expectedFirstGenIndex = FirstGenIndex.five;

      FirstGenIndex actualFirstGenIndex = firstGenModel.getFemaleIndex(FirstGenIndex.five);

      expect(actualFirstGenIndex, expectedFirstGenIndex);
    });
  });

  group('Test of FirstGenModel.getIndexFromValue', () {
    test('Should return [FirstGenIndex.fifteen] if [checked number is 15]', () {
      FirstGenIndex expectedFirstGenIndex = FirstGenIndex.fifteen;

      FirstGenIndex actualFirstGenIndex = firstGenModel.getIndexFromValue(15);

      expect(actualFirstGenIndex, expectedFirstGenIndex);
    });
  });
}
