import 'package:breeder/blocks/pages/new_breeding/a_new_breeding_state.dart';
import 'package:breeder/blocks/pages/new_breeding/new_breeding_cubit.dart';
import 'package:breeder/blocks/pages/new_breeding/state/init_new_breeding_state.dart';
import 'package:breeder/blocks/pages/second_generation/second_generation_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/second_generation/second_generation_model.dart';
import 'package:breeder/shared/models/new_breeding/new_breeding_model.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  await initLocator();

  group('Tests of NewBreedingCubit process', () {
    NewBreedingCubit actualNewBreedingCubit = globalLocator<NewBreedingCubit>();
    SecondGenerationCubit secondGenerationCubit = globalLocator<SecondGenerationCubit>();

    NewBreedingModel newBreedingModel = NewBreedingModel()..newBreedingTextEditingController.text = 'Test123';
    SecondGenerationModel secondGenerationModel = SecondGenerationModel()
      ..secondGenerationFemaleIVList[0] = 4
      ..secondGenerationFemaleIVList[1] = 0
      ..secondGenerationMaleIVList[0] = 3
      ..secondGenerationMaleIVList[1] = 0;

    test('Should emit [InitNewBreedingState] state', () {
      ANewBreedingState expectedNewBreedingState = InitNewBreedingState();

      expect(actualNewBreedingCubit.state, expectedNewBreedingState);
    });

    test('Should emit [InitNewBreedingState] state when when [NewBreedingModel] data is initialized', () {
      actualNewBreedingCubit.newBreedingModel = newBreedingModel;

      ANewBreedingState expectedNewBreedingState = InitNewBreedingState();

      expect(actualNewBreedingCubit.state, expectedNewBreedingState);
    });

    test('Should return list of zeros, and ' '', () {
      secondGenerationCubit.secondGenerationModel = secondGenerationModel;
      actualNewBreedingCubit
        ..newBreedingModel = newBreedingModel
        ..resetData();

      String expectedNewBreedingState = '';
      List<int> expectedSecondGenerationFemaleIVList = <int>[0, 0];
      List<int> expectedSecondGenerationMaleIVList = <int>[0, 0];

      expect(actualNewBreedingCubit.newBreedingModel.newBreedingTextEditingController.text, expectedNewBreedingState);
      expect(secondGenerationCubit.secondGenerationModel.secondGenerationFemaleIVList, expectedSecondGenerationFemaleIVList);
      expect(secondGenerationCubit.secondGenerationModel.secondGenerationMaleIVList, expectedSecondGenerationMaleIVList);
    });
  });
}
