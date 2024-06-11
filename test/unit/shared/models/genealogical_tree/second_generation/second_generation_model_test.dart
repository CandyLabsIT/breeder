import 'dart:ui';

import 'package:breeder/shared/models/second_generation_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final SecondGenerationModel secondGenerationModel = SecondGenerationModel();

  group(
    'Tests of SecondGenerationModel.getFemaleColors()',
        () {


      test(
        'Should return [list of defaultColor] if secondGenerationFemaleIVList contains only 0 (zero) and value is 0 (zero)',
            () {
          int actualValue = 0;
          secondGenerationModel
            ..secondGenerationFemaleIVList[0] = 0
            ..secondGenerationFemaleIVList[1] = 0;


          List<Color> actualColorsList = secondGenerationModel.getFemaleColors(actualValue);

          List<Color> expectedList = <Color>[const Color(0xFFD9D9D9), const Color(0xFFD9D9D9)];

          expect(actualColorsList, expectedList);
        },
      );

      test(
        'Should return [list with defaultColor and color != defaultColor] if secondGenerationFemaleIVList contains 0 (zero) and value is not 0 (zero)',
            () {
          int actualValue = 4;

          List<Color> actualColorsList = secondGenerationModel.getFemaleColors(actualValue);

          List<Color> expectedList = <Color>[const Color(0xFFFFDAD6), const Color(0xFFD9D9D9)];

          expect(actualColorsList, expectedList);
        },
      );

      test(
        'Should return [list of two colors != defaultColor] if secondGenerationFemaleIVList sum > 0 and value is not 0 (zero)',
            () {
          secondGenerationModel
            ..secondGenerationFemaleIVList[0] = 4
            ..secondGenerationFemaleIVList[1] = 0;
          int actualValue = 2;

          List<Color> actualColorsList = secondGenerationModel.getFemaleColors(actualValue);

          List<Color> expectedList = <Color>[const Color(0xFFFFDAD6), const Color(0xFF7AE3FC)];

          expect(actualColorsList, expectedList);
        },
      );

      test(
        'Should return [defaultColor and color != defaultColor] if both indexes of secondGenerationFemaleIVList are not 0 and value equals one of the indexes',
            () {
          secondGenerationModel
            ..secondGenerationFemaleIVList[0] = 4
            ..secondGenerationFemaleIVList[1] = 2;
          int actualValue = 2;

          List<Color> actualColorsList = secondGenerationModel.getFemaleColors(actualValue);

          List<Color> expectedList = <Color>[const Color(0xFFFFDAD6), const Color(0xFFD9D9D9)];

          expect(actualColorsList, expectedList);
        },
      );

      test(
        'Should return [two defaultColors] if only secondGenerationFemaleIVList[0] > 0 and value equals secondGenerationFemaleIVList[0]',
            () {
          secondGenerationModel
            ..secondGenerationFemaleIVList[0] = 4
            ..secondGenerationFemaleIVList[1] = 0;
          int actualValue = 4;

          List<Color> actualColorsList = secondGenerationModel.getFemaleColors(actualValue);

          List<Color> expectedList = <Color>[const Color(0xFFD9D9D9), const Color(0xFFD9D9D9)];

          expect(actualColorsList, expectedList);
        },
      );

      test(
        'Should return [two defaultColors] if only secondGenerationFemaleIVList[1] > 0 and value equals secondGenerationFemaleIVList[1]',
            () {
          secondGenerationModel
            ..secondGenerationFemaleIVList[0] = 0
            ..secondGenerationFemaleIVList[1] = 4;
          int actualValue = 4;

          List<Color> actualColorsList = secondGenerationModel.getFemaleColors(actualValue);

          List<Color> expectedList = <Color>[const Color(0xFFD9D9D9), const Color(0xFFD9D9D9)];

          expect(actualColorsList, expectedList);
        },
      );
    },
  );

  group('Tests of SecondGenerationModel.isFemaleButtonEnable()', () {
    secondGenerationModel
      ..secondGenerationFemaleIVList[0] = 0
      ..secondGenerationFemaleIVList[1] = 0;

    List<bool> expectedList = List<bool>.filled(7, true);

    test(
      'Should return [list of true] if the sum of secondGenerationFemaleIVList is 0',
          () {
        List<bool> actualButtonsList = secondGenerationModel.isFemaleButtonEnable();

        expect(actualButtonsList, expectedList);
      },
    );

    test(
      'Should return [list of true] if the sum of secondGenerationFemaleIVList > 0 and one index is 0',
          () {
        secondGenerationModel
          ..secondGenerationFemaleIVList[0] = 4
          ..secondGenerationFemaleIVList[1] = 0;

        List<bool> actualButtonsList = secondGenerationModel.isFemaleButtonEnable();

        expect(actualButtonsList, expectedList);
      },
    );

    test(
      'Should return [list of five false and two true] if both indexes of secondGenerationFemaleIVList > 0',
          () {
        secondGenerationModel
          ..secondGenerationFemaleIVList[0] = 4
          ..secondGenerationFemaleIVList[1] = 2;

        List<bool> actualButtonsList = secondGenerationModel.isFemaleButtonEnable();

        for (int i = 1; i < 7; i++) {
          if (i != 4 && i != 2) {
            expectedList[i] = false;
          }
        }

        expect(actualButtonsList, expectedList);
      },
    );

    test(
      'Should return [list of four false and three true] if only one index of secondGenerationFemaleIVList > 0 and both indexes of secondGenerationMaleIVList > 0 and one index equals secondGenerationFemaleIVList',
          () {
        secondGenerationModel
          ..secondGenerationFemaleIVList[0] = 3
          ..secondGenerationFemaleIVList[1] = 0
          ..secondGenerationMaleIVList[0] = 4
          ..secondGenerationMaleIVList[1] = 2;

        List<bool> actualButtonsList = secondGenerationModel.isFemaleButtonEnable();
        List<bool> expectedList = List<bool>.filled(7, true);

        for (int i = 1; i < 7; i++) {
          if (i != 2 && i != 3 && i != 4) {
            expectedList[i] = false;
          }
        }
        expect(actualButtonsList, expectedList);
      },
    );

    test(
      'Should return [list with one false] if only one index of secondGenerationFemaleIVList > 0 and both indexes of secondGenerationMaleIVList > 0 and all values are not equal to secondGenerationFemaleIVList',
          () {
        secondGenerationModel
          ..secondGenerationFemaleIVList[0] = 2
          ..secondGenerationFemaleIVList[1] = 0
          ..secondGenerationMaleIVList[0] = 4
          ..secondGenerationMaleIVList[1] = 2;

        List<bool> actualButtonsList = secondGenerationModel.isFemaleButtonEnable();
        List<bool> expectedList = List<bool>.filled(7, true);

        expectedList[4] = false;

        expect(actualButtonsList, expectedList);
      },
    );

    test(
      'Should return [list with one false] if only one index of secondGenerationFemaleIVList > 0 and both indexes of secondGenerationMaleIVList > 0 and all values are not equal to secondGenerationFemaleIVList',
          () {
        secondGenerationModel
          ..secondGenerationFemaleIVList[0] = 0
          ..secondGenerationFemaleIVList[1] = 4
          ..secondGenerationMaleIVList[0] = 4
          ..secondGenerationMaleIVList[1] = 2;

        List<bool> actualButtonsList = secondGenerationModel.isFemaleButtonEnable();
        List<bool> expectedList = List<bool>.filled(7, true);

        expectedList[2] = false;

        expect(actualButtonsList, expectedList);
      },
    );
  });

  group('Tests of SecondGenerationModel.restartFemaleValues()', () {
    secondGenerationModel
      ..secondGenerationFemaleIVList[0] = 4
      ..secondGenerationFemaleIVList[1] = 6;

    test(
      'Should return [list of defaultColor] if both indexes of secondGenerationFemaleIVList > 0',
          () {
        List<Color> actualButtonsList = secondGenerationModel.restartFemaleValues();
        List<Color> expectedList = <Color>[const Color(0xFFD9D9D9), const Color(0xFFD9D9D9)];

        expect(actualButtonsList, expectedList);
      },
    );

    test(
      'Should return [list of defaultColor] if one index of secondGenerationFemaleIVList > 0',
          () {
        secondGenerationModel
          ..secondGenerationFemaleIVList[0] = 4
          ..secondGenerationFemaleIVList[1] = 0;

        List<Color> actualButtonsList = secondGenerationModel.restartFemaleValues();
        List<Color> expectedList = <Color>[const Color(0xFFD9D9D9), const Color(0xFFD9D9D9)];

        expect(actualButtonsList, expectedList);
      },
    );

    test(
      'Should return return [list of defaultColor] if both indexes of secondGenerationFemaleIVList > 0',

      () {
        List<Color> actualButtonsList = secondGenerationModel.restartFemaleValues();
        late List<Color> expectedList = <Color>[const Color(0xFFD9D9D9), const Color(0xFFD9D9D9)];

        expect(actualButtonsList, expectedList);
      },
    );

     test(
       'Should return return [list of defaultColor] if one index of secondGenerationFemaleIVList > 0',
           () {

             secondGenerationModel
               ..secondGenerationFemaleIVList[0] = 4
               ..secondGenerationFemaleIVList[1] = 0;

         List<Color> actualButtonsList = secondGenerationModel.restartFemaleValues();
         late List<Color> expectedList = <Color>[const Color(0xFFD9D9D9), const Color(0xFFD9D9D9)];

         expect(actualButtonsList, expectedList);
       },
     );
  });

  group('Tests of SecondGenerationModel.isFemaleRestartButtonEnabled()', () {
    final SecondGenerationModel secondGenerationModel = SecondGenerationModel();

    test(
      'Should return [true] if both indexes of secondGenerationFemaleIVList > 0',
      () {
        secondGenerationModel
          ..secondGenerationFemaleIVList[0] = 4
          ..secondGenerationFemaleIVList[1] = 6;

        bool actualButtonState = secondGenerationModel.isFemaleRestartButtonEnabled();
        bool expectedButtonState = true;

        expect(actualButtonState, expectedButtonState);
      },
    );

    test(
      'Should return [true] if one index of secondGenerationFemaleIVList > 0',
          () {
        secondGenerationModel
          ..secondGenerationFemaleIVList[0] = 0
          ..secondGenerationFemaleIVList[1] = 6;

        bool actualButtonState = secondGenerationModel.isFemaleRestartButtonEnabled();
        bool expectedButtonState = true;

        expect(actualButtonState, expectedButtonState);
      },
    );

    test(
      'Should return [false] if both index of secondGenerationFemaleIVList == 0',
      () {
        secondGenerationModel
          ..secondGenerationFemaleIVList[0] = 0
          ..secondGenerationFemaleIVList[1] = 0;

        bool actualButtonState = secondGenerationModel.isFemaleRestartButtonEnabled();
        bool expectedButtonState = false;

        expect(actualButtonState, expectedButtonState);
      },
    );
  });

  group('Tests of SecondGenerationModel.getMaleColors()', () {
    test(
      'Should return [list of defaultColor] if secondGenerationMaleIVList has only 0 (zero) and value is 0 (zero)',
          () {
        int actualValue = 0;

        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 0
          ..secondGenerationMaleIVList[1] = 0;

        List<Color> actualColorsList = secondGenerationModel.getMaleColors(actualValue);

        List<Color> expectedList = <Color>[const Color(0xFFD9D9D9), const Color(0xFFD9D9D9)];

        expect(actualColorsList, expectedList);
      },
    );

    test(
      'Should return [list with defaultColor and non-defaultColor] if secondGenerationMaleIVList has only 0 (zero) and value is not 0 (zero)',
          () {
        int actualValue = 4;

        List<Color> actualColorsList = secondGenerationModel.getMaleColors(actualValue);

        List<Color> expectedList = <Color>[const Color(0xFFFFDAD6), const Color(0xFFD9D9D9)];

        expect(actualColorsList, expectedList);
      },
    );

    test(
      'Should return [list of two non-default colors] if secondGenerationMaleIVList sum > 0 and value is not 0 (zero)',
          () {
        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 4
          ..secondGenerationMaleIVList[1] = 0;
        int actualValue = 2;

        List<Color> actualColorsList = secondGenerationModel.getMaleColors(actualValue);

        List<Color> expectedList = <Color>[const Color(0xFFFFDAD6), const Color(0xFF7AE3FC)];

        expect(actualColorsList, expectedList);
      },
    );

    test(
      'Should return [defaultColor and non-defaultColor] if both indexes of secondGenerationMaleIVList are not 0 and value equals one of the indexes',
          () {
        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 4
          ..secondGenerationMaleIVList[1] = 2;
        int actualValue = 2;

        List<Color> actualColorsList = secondGenerationModel.getMaleColors(actualValue);

        List<Color> expectedList = <Color>[const Color(0xFFFFDAD6), const Color(0xFFD9D9D9)];

        expect(actualColorsList, expectedList);
      },
    );

    test(
      'Should return [two defaultColors] if only secondGenerationMaleIVList[0] > 0 and value equals secondGenerationMaleIVList[0]',
          () {
        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 4
          ..secondGenerationMaleIVList[1] = 0;
        int actualValue = 4;

        List<Color> actualColorsList = secondGenerationModel.getMaleColors(actualValue);

        List<Color> expectedList = <Color>[const Color(0xFFD9D9D9), const Color(0xFFD9D9D9)];

        expect(actualColorsList, expectedList);
      },
    );

    test(
      'Should return [two defaultColors] if only secondGenerationMaleIVList[1] > 0 and value equals secondGenerationMaleIVList[1]',
          () {
        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 0
          ..secondGenerationMaleIVList[1] = 4;
        int actualValue = 4;

        List<Color> actualColorsList = secondGenerationModel.getMaleColors(actualValue);

        List<Color> expectedList = <Color>[const Color(0xFFD9D9D9), const Color(0xFFD9D9D9)];

        expect(actualColorsList, expectedList);
      },
    );
  });

  group('Tests of SecondGenerationModel.isMaleButtonEnable()', () {
    final SecondGenerationModel secondGenerationModel = SecondGenerationModel()
      ..secondGenerationMaleIVList[0] = 0
      ..secondGenerationMaleIVList[1] = 0;

    List<bool> expectedList = List<bool>.filled(7, true);

    test(
      'Should return [list of true] if the sum of secondGenerationMaleIVList is 0',
          () {
        List<bool> actualButtonsList = secondGenerationModel.isMaleButtonEnable();

        expect(actualButtonsList, expectedList);
      },
    );

    test(
      'Should return [list of true] if the sum of secondGenerationMaleIVList > 0 and one index is 0',
          () {
        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 4
          ..secondGenerationMaleIVList[1] = 0;

        List<bool> actualButtonsList = secondGenerationModel.isMaleButtonEnable();

        expect(actualButtonsList, expectedList);
      },
    );

    test(
      'Should return [list with five false and two true] if both indexes of secondGenerationMaleIVList > 0',
          () {
        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 4
          ..secondGenerationMaleIVList[1] = 2;

        List<bool> actualButtonsList = secondGenerationModel.isMaleButtonEnable();

        for (int i = 1; i < 7; i++) {
          if (i != 4 && i != 2) {
            expectedList[i] = false;
          }
        }

        expect(actualButtonsList, expectedList);
      },
    );

    test(
      'Should return [list with four false and three true] if only one index of secondGenerationMaleIVList > 0 and both indexes of secondGenerationFemaleIVList > 0 and one index equals secondGenerationMaleIVList',
          () {
        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 3
          ..secondGenerationMaleIVList[1] = 0
          ..secondGenerationFemaleIVList[0] = 4
          ..secondGenerationFemaleIVList[1] = 2;

        List<bool> actualButtonsList = secondGenerationModel.isMaleButtonEnable();
        List<bool> expectedList = List<bool>.filled(7, true);

        for (int i = 1; i < 7; i++) {
          if (i != 2 && i != 3 && i != 4) {
            expectedList[i] = false;
          }
        }
        expect(actualButtonsList, expectedList);
      },
    );

    test(
      'Should return [list with one false] if only one index of secondGenerationMaleIVList > 0 and both indexes of secondGenerationFemaleIVList > 0 and all values are not equal to secondGenerationMaleIVList',
          () {
        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 2
          ..secondGenerationMaleIVList[1] = 0
          ..secondGenerationFemaleIVList[0] = 4
          ..secondGenerationFemaleIVList[1] = 2;

        List<bool> actualButtonsList = secondGenerationModel.isMaleButtonEnable();
        List<bool> expectedList = List<bool>.filled(7, true);

        expectedList[4] = false;

        expect(actualButtonsList, expectedList);
      },
    );

    test(
      'Should return [list with one false] if only one index of secondGenerationMaleIVList > 0 and both indexes of secondGenerationFemaleIVList > 0 and all values are not equal to secondGenerationMaleIVList',
          () {
        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 0
          ..secondGenerationMaleIVList[1] = 4
          ..secondGenerationFemaleIVList[0] = 4
          ..secondGenerationFemaleIVList[1] = 2;

        List<bool> actualButtonsList = secondGenerationModel.isMaleButtonEnable();
        List<bool> expectedList = List<bool>.filled(7, true);

        expectedList[2] = false;

        expect(actualButtonsList, expectedList);
      },
    );
  });

  group('Tests of SecondGenerationModel.restartMaleValues()', () {
    final SecondGenerationModel secondGenerationModel = SecondGenerationModel()
      ..secondGenerationMaleIVList[0] = 4
      ..secondGenerationMaleIVList[1] = 6;

    test(
      'Should return [list of defaultColor] if both indexes of secondGenerationMaleIVList > 0',
          () {
        List<Color> actualButtonsList = secondGenerationModel.restartMaleValues();
        List<Color> expectedList = <Color>[const Color(0xFFD9D9D9), const Color(0xFFD9D9D9)];

        expect(actualButtonsList, expectedList);
      },
    );
  });

  group('Tests of SecondGenerationModel.isMaleButtonEnabled()', () {
    final SecondGenerationModel secondGenerationModel = SecondGenerationModel();

    test(
      'Should return [true] if both indexes of secondGenerationMaleIVList > 0',
          () {
        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 4
          ..secondGenerationMaleIVList[1] = 6;

        bool actualButtonState = secondGenerationModel.isMaleRestartButtonEnabled();
        bool expectedButtonState = true;

        expect(actualButtonState, expectedButtonState);
      },
    );

    test(
      'Should return [true] if one index of secondGenerationMaleIVList > 0',
          () {
        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 0
          ..secondGenerationMaleIVList[1] = 6;

        bool actualButtonState = secondGenerationModel.isMaleRestartButtonEnabled();
        bool expectedButtonState = true;

        expect(actualButtonState, expectedButtonState);
      },
    );

    test(
      'Should return [false] if both indexes of secondGenerationMaleIVList are 0',
          () {
        secondGenerationModel
          ..secondGenerationMaleIVList[0] = 0
          ..secondGenerationMaleIVList[1] = 0;

        bool actualButtonState = secondGenerationModel.isMaleRestartButtonEnabled();
        bool expectedButtonState = false;

        expect(actualButtonState, expectedButtonState);
      },
    );
  });
}