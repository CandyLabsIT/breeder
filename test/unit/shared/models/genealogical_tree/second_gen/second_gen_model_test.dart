import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Act
  final SecondGenModel secondGenModel = SecondGenModel();

  Map<SecondGenIndex, MonsterModel> actualSecondGenMap = secondGenModel.secondGenMap;
  group('Test of FirstGenModel.getFatherIndexValue()', () {
    test('Should return [6] when [SecondGenIndex.three] is father index', () {
      // Arrange
      int expectedIntValue = 6;

      // Act
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.three;
      int actualIntValue = secondGenModel.getFatherIndexValue(actualSecondGenIndex);

      // Assert
      expect(actualIntValue, expectedIntValue);
    });

    test('Should return [16] when [SecondGenIndex.eight] is father index', () {
      // Arrange
      int expectedIntValue = 16;

      // Act
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.eight;
      int actualIntValue = secondGenModel.getFatherIndexValue(actualSecondGenIndex);

      // Assert
      expect(actualIntValue, expectedIntValue);
    });
  });

  group('Test of FirstGenModel.getMotherIndexValue()', () {
    test('Should return [19] when [SecondGenIndex.ten] is mother index', () {
      // Arrange
      int expectedIntValue = 19;

      // Act
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.ten;
      int actualIntValue = secondGenModel.getMotherIndexValue(actualSecondGenIndex);

      // Assert
      expect(actualIntValue, expectedIntValue);
    });

    test('Should return [25] when [SecondGenIndex.thirteen] is mother index', () {
      // Arrange
      int expectedIntValue = 25;

      // Act
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.thirteen;
      int actualIntValue = secondGenModel.getMotherIndexValue(actualSecondGenIndex);

      // Assert
      expect(actualIntValue, expectedIntValue);
    });
  });

  group('Test of FirstGenModel.inheritIVFromParents()', () {
    test('Should [update first monster] when [monster parents are filled with IVs]', () {
      // Arrange
      List<IVColor> expectedIVList = <IVColor>[IVColor.hpColor, IVColor.speedColor];
      bool expectedIsAutoFilledBool = true;
      MonsterGen expectedMonsterGen = MonsterGen.secondGen;

      MonsterModel expectedSecondGenMonsterModel =
          MonsterModel(ivColorList: expectedIVList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: expectedMonsterGen);

      // Act
      List<IVColor> actualIVList = <IVColor>[IVColor.speedColor, IVColor.hpColor];
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.ten;

      secondGenModel.inheritIVFromParents(actualSecondGenIndex, actualIVList);
      MonsterModel actualSecondGenMonsterModel = secondGenModel.secondGenMap[actualSecondGenIndex]!;

      // Assert
      expect(actualSecondGenMonsterModel, expectedSecondGenMonsterModel);
    });
  });

  group('Test of FirstGenModel.setDefaultValues()', () {
    test('Should [reset monster] when [monster is filled with IVs]', () {
      // Arrange
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.six;

      List<IVColor> expectedIVList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen expectedMonsterGen = MonsterGen.secondGen;

      MonsterModel expectedSecondGenMonsterModel =
          MonsterModel(ivColorList: expectedIVList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: expectedMonsterGen);

      // Act
      secondGenModel.setDefaultValues(actualSecondGenIndex);
      MonsterModel actualSecondGenMonsterModel = secondGenModel.secondGenMap[actualSecondGenIndex]!;

      // Assert
      expect(actualSecondGenMonsterModel, expectedSecondGenMonsterModel);
    });

    test('Should [reset monster] when [monster is not filled with IVs]', () {
      // Arrange
      List<IVColor> expectedIVList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen expectedMonsterGen = MonsterGen.secondGen;

      MonsterModel expectedSecondGenMonsterModel =
          MonsterModel(ivColorList: expectedIVList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: expectedMonsterGen);

      // Act
      SecondGenIndex actualSecondGenIndex = SecondGenIndex.four;
      List<IVColor> actualIVColor = actualSecondGenMap[actualSecondGenIndex]!.ivColorList;

      actualSecondGenMap[actualSecondGenIndex] = secondGenModel.secondGenMonsterModel().updateIVColor(actualIVColor, IVColor.speedColor);
      secondGenModel.setDefaultValues(actualSecondGenIndex);
      MonsterModel actualSecondGenModel = secondGenModel.secondGenMap[actualSecondGenIndex]!;

      // Assert
      expect(actualSecondGenModel, expectedSecondGenMonsterModel);
    });
  });
}
