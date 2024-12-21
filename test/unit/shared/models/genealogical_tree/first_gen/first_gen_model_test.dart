import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_model.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Act
  final FirstGenModel firstGenModel = FirstGenModel();
  Map<FirstGenIndex, MonsterModel> actualMonsterMap = firstGenModel.firstGenMap;

  group('Test of FirstGenModel.updateIVColor()', () {
    test('Should [add hp IV] when [user chose hp IV for first monster]', () {
      // Arrange
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.hpColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.firstGen;

      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);
      expectedIVColorList = expectedMonsterModel.ivColorList;

      // Act
      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
      IVColor actualIVColor = IVColor.hpColor;

      firstGenModel.updateIVColor(actualFirstGenIndex, actualIVColor);
      List<IVColor> actualIVColorList = actualMonsterMap[actualFirstGenIndex]!.ivColorList;

      // Assert
      expect(actualIVColorList, expectedIVColorList);
    });

    test('Should [replace hp IV with default color] when [first monster was filled with hp IV and user again choose hp IV]', () {
      // Arrange
      List<IVColor> expectedIVColorList = <IVColor>[IVColor.defaultColor];
      bool expectedIsAutoFilledBool = false;
      MonsterGen monsterGen = MonsterGen.firstGen;

      MonsterModel expectedMonsterModel =
          MonsterModel(ivColorList: expectedIVColorList, isAutoFilledBool: expectedIsAutoFilledBool, monsterGen: monsterGen);
      expectedIVColorList = expectedMonsterModel.ivColorList;

      // Act
      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
      IVColor actualIVColor = IVColor.hpColor;

      firstGenModel.updateIVColor(actualFirstGenIndex, actualIVColor);
      List<IVColor> actualIVColorList = actualMonsterMap[actualFirstGenIndex]!.ivColorList;

      // Assert
      expect(actualIVColorList, expectedIVColorList);
    });
  });

  group('Test of FirstGenModel.resetMonsterToDefaultIVColors()', () {
    test('Should [reset first and second monster] when [user reset first monster]', () {
      // Arrange
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

      // Act
      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;

      firstGenModel
        ..updateIVColor(FirstGenIndex.one, IVColor.atkColor)
        ..updateIVColor(FirstGenIndex.two, IVColor.hpColor)
        ..resetMonsterToDefaultIVColors(actualFirstGenIndex);

      // Assert
      expect(actualMonsterMap, expectedFirstGenMap);
    });
  });

  group('Test of FirstGenModel.resetAll() - this method is invoked only when user returns to main menu view', () {
    test('Should [reset all monsters]', () {
      // Arrange
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

      // Act
      firstGenModel
        ..updateIVColor(FirstGenIndex.one, IVColor.speedColor)
        ..updateIVColor(FirstGenIndex.two, IVColor.hpColor)
        ..resetAll();

      // Assert
      expect(actualMonsterMap, expectedFirstGenMap);
    });
  });

  group('Test of FirstGenModel.hasNonDefaultIVColor()', () {
    test('Should return [false] when [first monster is not filled with IV]', () {
      // Arrange
      bool expectedHasNonDefaultIVColorBool = false;

      // Act
      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
      bool actualHasNonDefaultIVColorBool = firstGenModel.hasNonDefaultIVColor(actualFirstGenIndex);

      // Assert
      expect(actualHasNonDefaultIVColorBool, expectedHasNonDefaultIVColorBool);
    });

    test('Should return [true] when [first monster is filled with attack IV]', () {
      // Arrange
      bool expectedHasNonDefaultIVColorBool = true;

      // Act
      FirstGenIndex actualFirstGenIndex = FirstGenIndex.one;
      IVColor actualIVColor = IVColor.atkColor;

      firstGenModel.updateIVColor(actualFirstGenIndex, actualIVColor);
      bool actualHasNonDefaultIVColorBool = firstGenModel.hasNonDefaultIVColor(actualFirstGenIndex);

      // Assert
      expect(actualHasNonDefaultIVColorBool, expectedHasNonDefaultIVColorBool);
    });
  });

  group('Test of FirstGenModel.getPreviousPairMaleIndex()', () {
    test('Should return [FirstGenIndex.two] when [checked FirstGenIndex.three]', () {
      // Arrange
      FirstGenIndex expectedFirstGenIndex = FirstGenIndex.two;

      // Act
      FirstGenIndex actualFirstGenIndex = firstGenModel.getPreviousPairMaleIndex(FirstGenIndex.three);

      expect(actualFirstGenIndex, expectedFirstGenIndex);
    });

    test('Should return [FirstGenIndex.two] when [checked FirstGenIndex.four]', () {
      // Arrange
      FirstGenIndex expectedFirstGenIndex = FirstGenIndex.two;

      // Act
      FirstGenIndex actualFirstGenIndex = firstGenModel.getPreviousPairMaleIndex(FirstGenIndex.four);

      // Assert
      expect(actualFirstGenIndex, expectedFirstGenIndex);
    });
  });

  group('Test of FirstGenModel.getActivePairFemaleIndex()', () {
    test('Should return [FirstGenIndex.tree] when [checked FirstGenIndex.four]', () {
      // Arrange
      FirstGenIndex expectedFirstGenIndex = FirstGenIndex.three;

      // Act
      FirstGenIndex actualFirstGenIndex = firstGenModel.getActivePairFemaleIndex(FirstGenIndex.four);

      // Assert
      expect(actualFirstGenIndex, expectedFirstGenIndex);
    });

    test('Should return [FirstGenIndex.five] when [checked FirstGenIndex.five]', () {
      // Arrange
      FirstGenIndex expectedFirstGenIndex = FirstGenIndex.five;

      // Act
      FirstGenIndex actualFirstGenIndex = firstGenModel.getActivePairFemaleIndex(FirstGenIndex.five);

      // Assert
      expect(actualFirstGenIndex, expectedFirstGenIndex);
    });
  });

  group('Test of FirstGenModel.getIndexFromValue()', () {
    test('Should return [FirstGenIndex.fifteen] when [checked number is 15]', () {
      // Arrange
      FirstGenIndex expectedFirstGenIndex = FirstGenIndex.fifteen;

      // Act
      FirstGenIndex actualFirstGenIndex = firstGenModel.getIndexFromValue(15);

      // Assert
      expect(actualFirstGenIndex, expectedFirstGenIndex);
    });
  });
}
