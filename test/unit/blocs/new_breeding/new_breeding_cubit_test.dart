import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/blocks/pages/new_breeding/new_breeding_cubit.dart';
import 'package:breeder/blocks/pages/new_breeding/states/new_breeding_init_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_model.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen_index.dart';
import 'package:breeder/shared/models/new_breeding/new_breeding_model.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  await initLocator();

  group('Tests of NewBreedingCubit process', () {
    NewBreedingCubit actualNewBreedingCubit = globalLocator<NewBreedingCubit>();
    SecondGenCubit actualSecondGenCubit = globalLocator<SecondGenCubit>();

    NewBreedingModel newBreedingModel = NewBreedingModel()..newBreedingTextEditingController.text = 'Test123';
    SecondGenModel secondGenerationModel = SecondGenModel();


    test('Should emit [NewBreedingInitState] state', () {
      NewBreedingInitState expectedNewBreedingState = const NewBreedingInitState();

      expect(actualNewBreedingCubit.state, expectedNewBreedingState);
    });

    test('Should emit [NewBreedingInitState] state when when [NewBreedingModel] data is initialized', () {
      actualNewBreedingCubit.newBreedingModel = newBreedingModel;

      NewBreedingInitState expectedNewBreedingState = const NewBreedingInitState();

      expect(actualNewBreedingCubit.state, expectedNewBreedingState);
    });

    test('Should return list of zeros, and ' '', () {
      actualSecondGenCubit.secondGenModel = secondGenerationModel;

      List<IVColor> primaryIVColorList = <IVColor>[IVColor.defColor, IVColor.defaultColor];
      List<IVColor> secondaryIVColorList = <IVColor>[IVColor.atkColor, IVColor.spAtkColor];

      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.one] = primaryIVColorList;
      actualSecondGenCubit.secondGenModel.secondGenMap[SecondGenIndex.two] = secondaryIVColorList;

      actualNewBreedingCubit
        ..newBreedingModel = newBreedingModel
        ..resetData();

      String expectedNewBreedingState = '';

      Map<SecondGenIndex, List<IVColor>> expectedSecondGenMap = <SecondGenIndex, List<IVColor>>{
        for (SecondGenIndex index in SecondGenIndex.values) index: <IVColor>[IVColor.defaultColor, IVColor.defaultColor]
      };


      expect(actualNewBreedingCubit.newBreedingModel.newBreedingTextEditingController.text, expectedNewBreedingState);
      expect(actualSecondGenCubit.secondGenModel.secondGenMap, expectedSecondGenMap);
    });
  });
}
