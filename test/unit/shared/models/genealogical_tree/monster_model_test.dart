import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<IVColor> actualIVColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
  bool actualIsAutoFilledBool = false;
  MonsterGen actualMonsterGen = MonsterGen.secondGen;

  MonsterModel actualMonsterModel =
      MonsterModel(ivColorList: actualIVColorList, isAutoFilledBool: actualIsAutoFilledBool, monsterGen: actualMonsterGen);

  group('Test of MonsterModel.updateIVColor', () {
    test('Should replace defaultColor with [hpColor] if [ivColorList contains only defaultColor]', () {
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.hpColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      IVColor actualIVColor = IVColor.hpColor;

      actualMonsterModel = actualMonsterModel.updateIVColor(actualMonsterModel.ivColorList, actualIVColor);

      expect(actualMonsterModel, expectedMonsterModel);
    });

    test('Should replace remaining [defaultColor with atkColor] if [ivColorList contains [hpColor, defaultColor]]', () {
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.atkColor, IVColor.hpColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      IVColor actualIVColor = IVColor.atkColor;

      actualMonsterModel = actualMonsterModel.updateIVColor(actualMonsterModel.ivColorList, actualIVColor);

      expect(actualMonsterModel, expectedMonsterModel);
    });

    test('Should remain unchanged list if list does not contain defaultColor or if ivColor is not any element of the list', () {
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.atkColor, IVColor.hpColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      IVColor actualIVColor = IVColor.speedColor;

      actualMonsterModel = actualMonsterModel.updateIVColor(actualMonsterModel.ivColorList, actualIVColor);

      expect(actualMonsterModel, expectedMonsterModel);
    });

    test('Should replace hpColor with defaultColor if list contain hpColor and ivColor is equal to hpColor', () {
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.atkColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      IVColor actualIVColor = IVColor.hpColor;

      actualMonsterModel = actualMonsterModel.updateIVColor(actualMonsterModel.ivColorList, actualIVColor);

      expect(actualMonsterModel, expectedMonsterModel);
    });

    test('Should replace atkColor with defaultColor if list contains atkColor and defaultColor and ivColor is equal to atkColor', () {
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      IVColor actualIVColor = IVColor.atkColor;

      actualMonsterModel = actualMonsterModel.updateIVColor(actualMonsterModel.ivColorList, actualIVColor);

      expect(actualMonsterModel, expectedMonsterModel);
    });
  });

  group('Test of MonsterModel.inheritValues', () {
    test('Should auto-fill ivColorList when called with sorted ivColorList', () {
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.spDefColor, IVColor.speedColor];
      bool expectedIsAutoFilledBool = true;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      List<IVColor> actualIVColorList = <IVColor>[IVColor.spDefColor, IVColor.speedColor];

      actualMonsterModel = actualMonsterModel.inheritValues(actualIVColorList, actualMonsterGen);

      expect(actualMonsterModel, expectedMonsterModel);
    });

    test('Should sort and auto-fill ivColorList when called with unsorted ivColorList', () {
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.atkColor, IVColor.defColor];
      bool expectedIsAutoFilledBool = true;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      List<IVColor> actualIVColorList = <IVColor>[IVColor.defColor, IVColor.atkColor];

      actualMonsterModel = actualMonsterModel.inheritValues(actualIVColorList, actualMonsterGen);

      expect(actualMonsterModel, expectedMonsterModel);
    });
  });

  group('Test of MonsterModel.resetMonsterToDefaultIVColors', () {
    test('Should reset ivColorList to defaultColor if ivColorList do not contain defaultColor', () {
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      actualMonsterModel = actualMonsterModel.getDefaultIVColors();

      expect(actualMonsterModel, expectedMonsterModel);
    });

    test('Should reset ivColorList to defaultColor if ivColorList contain defaultColor', () {
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      actualIVColorList = <IVColor>[IVColor.speedColor, IVColor.defaultColor];
      actualMonsterModel = MonsterModel(ivColorList: actualIVColorList, isAutoFilledBool: actualIsAutoFilledBool, monsterGen: actualMonsterGen);
      actualMonsterModel = actualMonsterModel.getDefaultIVColors();

      expect(actualMonsterModel, expectedMonsterModel);
    });
  });
}
