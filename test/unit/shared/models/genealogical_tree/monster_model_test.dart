import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Act
  List<IVColor> actualIVColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
  bool actualIsAutoFilledBool = false;
  MonsterGen actualMonsterGen = MonsterGen.secondGen;

  MonsterModel actualMonsterModel =
      MonsterModel(ivColorList: actualIVColorList, isAutoFilledBool: actualIsAutoFilledBool, monsterGen: actualMonsterGen);

  group('Test of MonsterModel.updateIVColor() when [secondGen is updated]', () {
    test('Should [update second gen monster with hp IV] when [monster has two default color IV parts]', () {
      // Arrange
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.hpColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      // Act
      IVColor actualIVColor = IVColor.hpColor;

      actualMonsterModel = actualMonsterModel.updateIVColor(actualMonsterModel.ivColorList, actualIVColor);

      // Assert
      expect(actualMonsterModel, expectedMonsterModel);
    });

    test('Should [update second gen monster with attack IV] when [monster has one part filled with hp IV] and [second part is default color]', () {
      // Arrange
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.atkColor, IVColor.hpColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      // Act
      IVColor actualIVColor = IVColor.atkColor;

      actualMonsterModel = actualMonsterModel.updateIVColor(actualMonsterModel.ivColorList, actualIVColor);

      // Assert
      expect(actualMonsterModel, expectedMonsterModel);
    });

    test('Should [replace hp IV with default color] when [chosen IV is equal to hp IV]', () {
      // Arrange
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.atkColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      // Act
      IVColor actualIVColor = IVColor.hpColor;

      actualMonsterModel = actualMonsterModel.updateIVColor(actualMonsterModel.ivColorList, actualIVColor);

      // Assert
      expect(actualMonsterModel, expectedMonsterModel);
    });
  });

  group('Test of MonsterModel.inheritValues()', () {
    test('Should [sort (according to order of IVColor) and auto-fill monster IVs] when [monster inherit IVs from parents]', () {
      // Arrange

      List<IVColor> expectedIVColorList = <IVColor>[IVColor.atkColor, IVColor.defColor];
      bool expectedIsAutoFilledBool = true;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      // Act
      List<IVColor> actualIVColorList = <IVColor>[IVColor.defColor, IVColor.atkColor];

      actualMonsterModel = actualMonsterModel.inheritValues(actualIVColorList, actualMonsterGen);

      // Assert
      expect(actualMonsterModel, expectedMonsterModel);
    });
  });

  group('Test of MonsterModel.resetMonsterToDefaultIVColors()', () {
    test('Should [reset monster] when [monster is filled with IVs]', () {
      // Arrange
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      // Act
      actualMonsterModel = actualMonsterModel.getDefaultIVColors();

      // Assert
      expect(actualMonsterModel, expectedMonsterModel);
    });

    test('Should [reset monster] when [monster is only partially filled]', () {
      // Arrange
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.defaultColor, IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.secondGen;
      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);

      // Act
      actualIVColorList = <IVColor>[IVColor.speedColor, IVColor.defaultColor];

      actualMonsterModel = MonsterModel(ivColorList: actualIVColorList, isAutoFilledBool: actualIsAutoFilledBool, monsterGen: actualMonsterGen);
      actualMonsterModel = actualMonsterModel.getDefaultIVColors();

      // Assert
      expect(actualMonsterModel, expectedMonsterModel);
    });
  });
}
