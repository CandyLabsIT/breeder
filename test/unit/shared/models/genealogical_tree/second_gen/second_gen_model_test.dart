import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final SecondGenModel secondGenModel = SecondGenModel();

  Map<SecondGenIndex, MonsterModel> actualSecondGenMap = secondGenModel.secondGenMap;
  group('Test of FirstGenModel.getFatherIndexValue', () {
    test('Should return [6] if [SecondGenIndex is three]', () {
      int expectedIntValue = 6;

      SecondGenIndex actualSecondGenIndex = SecondGenIndex.three;

      int actualIntValue = secondGenModel.getFatherIndexValue(actualSecondGenIndex);

      expect(actualIntValue, expectedIntValue);
    });

    test('Should return [16] if [SecondGenIndex is eight]', () {
      int expectedIntValue = 16;

      SecondGenIndex actualSecondGenIndex = SecondGenIndex.eight;

      int actualIntValue = secondGenModel.getFatherIndexValue(actualSecondGenIndex);

      expect(actualIntValue, expectedIntValue);
    });
  });

  group('Test of FirstGenModel.getMotherIndexValue', () {
    test('Should return [19] if [SecondGenIndex is ten]', () {
      int expectedIntValue = 19;

      SecondGenIndex actualSecondGenIndex = SecondGenIndex.ten;

      int actualIntValue = secondGenModel.getMotherIndexValue(actualSecondGenIndex);

      expect(actualIntValue, expectedIntValue);
    });

    test('Should return [25] if [SecondGenIndex is thirteen]', () {
      int expectedIntValue = 25;

      SecondGenIndex actualSecondGenIndex = SecondGenIndex.thirteen;

      int actualIntValue = secondGenModel.getMotherIndexValue(actualSecondGenIndex);

      expect(actualIntValue, expectedIntValue);
    });
  });

  group('Test of FirstGenModel.propagateFromParent', () {
    test('Should update secondGenMap with inherited ivColorList', () {
      List<IVColor> expectedIVList = <IVColor>[IVColor.hpColor, IVColor.speedColor];
      bool expectedIsAutoFilledBool = true;
      MonsterGen expectedMonsterGen = MonsterGen.secondGen;

      MonsterModel expectedSecondGenMonsterModel =
          MonsterModel(ivColorList: expectedIVList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: expectedMonsterGen);

      List<IVColor> actualIVList = <IVColor>[IVColor.speedColor, IVColor.hpColor];
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.ten;

      secondGenModel.propagateFromParent(actualSecondGenIndex, actualIVList);

      MonsterModel actualSecondGenMonsterModel = secondGenModel.secondGenMap[actualSecondGenIndex]!;

      expect(actualSecondGenMonsterModel, expectedSecondGenMonsterModel);
    });
  });

  group('Test of FirstGenModel.setDefaultValues', () {
    test('Should reset MonsterModel to default values if ivColorList does not contain defaultColor', () {
      List<IVColor> expectedIVList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen expectedMonsterGen = MonsterGen.secondGen;

      MonsterModel expectedSecondGenMonsterModel =
          MonsterModel(ivColorList: expectedIVList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: expectedMonsterGen);

      SecondGenIndex actualSecondGenIndex = SecondGenIndex.six;

      secondGenModel.setDefaultValues(actualSecondGenIndex);

      MonsterModel actualSecondGenModel = secondGenModel.secondGenMap[actualSecondGenIndex]!;

      expect(actualSecondGenModel, expectedSecondGenMonsterModel);
    });

    test('Should reset MonsterModel to default values if ivColorList contain defaultColor', () {
      List<IVColor> expectedIVList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen expectedMonsterGen = MonsterGen.secondGen;

      MonsterModel expectedSecondGenMonsterModel =
          MonsterModel(ivColorList: expectedIVList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: expectedMonsterGen);

      SecondGenIndex actualSecondGenIndex = SecondGenIndex.four;
      List<IVColor> actualIVColor = actualSecondGenMap[actualSecondGenIndex]!.ivColorList;

      actualSecondGenMap[actualSecondGenIndex] = secondGenModel.secondGenMonsterModel().updateIVColor(actualIVColor, IVColor.speedColor);

      secondGenModel.setDefaultValues(actualSecondGenIndex);

      MonsterModel actualSecondGenModel = secondGenModel.secondGenMap[actualSecondGenIndex]!;

      expect(actualSecondGenModel, expectedSecondGenMonsterModel);
    });
  });
}
