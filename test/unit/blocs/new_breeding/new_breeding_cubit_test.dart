import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/blocks/pages/new_breeding/a_new_breeding_state.dart';
import 'package:breeder/blocks/pages/new_breeding/new_breeding_cubit.dart';
import 'package:breeder/blocks/pages/new_breeding/state/new_breeding_init_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:breeder/shared/models/new_breeding/new_breeding_model.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  await initLocator();

  group('Tests of NewBreedingCubit process', () {
    NewBreedingCubit actualNewBreedingCubit = globalLocator<NewBreedingCubit>();
    SecondGenCubit secondGenCubit = globalLocator<SecondGenCubit>();

    NewBreedingModel newBreedingModel = NewBreedingModel()..newBreedingTextEditingController.text = 'Test123';
    SecondGenModel secondGenerationModel = SecondGenModel()
      ..secondGenFemaleIVList[0] = 4
      ..secondGenFemaleIVList[1] = 0
      ..secondGenMaleIVList[0] = 3
      ..secondGenMaleIVList[1] = 0;

    test('Should emit [NewBreedingInitState] state', () {
      ANewBreedingState expectedNewBreedingState = NewBreedingInitState();

      expect(actualNewBreedingCubit.state, expectedNewBreedingState);
    });

    test('Should emit [NewBreedingInitState] state when when [NewBreedingModel] data is initialized', () {
      actualNewBreedingCubit.newBreedingModel = newBreedingModel;

      ANewBreedingState expectedNewBreedingState = NewBreedingInitState();

      expect(actualNewBreedingCubit.state, expectedNewBreedingState);
    });

    test('Should return list of zeros, and ' '', () {
      secondGenCubit.secondGenerationModel = secondGenerationModel;
      actualNewBreedingCubit
        ..newBreedingModel = newBreedingModel
        ..resetData();

      String expectedNewBreedingState = '';
      List<int> expectedSecondGenerationFemaleIVList = <int>[0, 0];
      List<int> expectedSecondGenerationMaleIVList = <int>[0, 0];

      expect(actualNewBreedingCubit.newBreedingModel.newBreedingTextEditingController.text, expectedNewBreedingState);
      expect(secondGenCubit.secondGenerationModel.secondGenFemaleIVList, expectedSecondGenerationFemaleIVList);
      expect(secondGenCubit.secondGenerationModel.secondGenMaleIVList, expectedSecondGenerationMaleIVList);
    });
  });
}
