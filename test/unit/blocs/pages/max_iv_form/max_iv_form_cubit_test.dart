import 'package:breeder/blocks/pages/max_iv_form/a_max_iv_form_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_form/states/max_iv_form_init_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/states/max_iv_form_sum_calculated_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/max_iv_form/max_iv_form_model.dart';
import 'package:flutter_test/flutter_test.dart';

//ignore_for_file: cascade_invocations

Future<void> main() async {
  await initLocator();

  group('Tests of MaxIVFormCubit process', () {
    MaxIVFormCubit actualMaxIVFormCubit = globalLocator<MaxIVFormCubit>();

    MaxIVFormModel maxIVFormModel = MaxIVFormModel()
      ..maxIVTextEditingControllersList[0].text = '2'
      ..maxIVTextEditingControllersList[1].text = '1'
      ..maxIVTextEditingControllersList[2].text = '1'
      ..maxIVTextEditingControllersList[3].text = '1'
      ..maxIVTextEditingControllersList[4].text = '1';

    test('Should emit [AMaxIVFormState] state', () {
      AMaxIVFormState expectedMaxIVFormInitState = MaxIVFormInitState();

      expect(actualMaxIVFormCubit.state, expectedMaxIVFormInitState);
    });

    test('Should emit [MaxIVFormInitState] when [MaxIVSlotsModel] data is initialized', () {
      actualMaxIVFormCubit.maxIVFormModel = maxIVFormModel;

      AMaxIVFormState expectedMaxIVFormInitState = MaxIVFormInitState();

      expect(actualMaxIVFormCubit.state, expectedMaxIVFormInitState);
    });

    test('Should return [MaxIVFormSumCalculatedState] if [maxIVFormSum value has changed]', () {
      actualMaxIVFormCubit.calculateSum();

      AMaxIVFormState expectedMaxIVFormSumCalculatedState = const MaxIVFormSumCalculatedState(maxIVFormSum: 32);

      expect(actualMaxIVFormCubit.state, expectedMaxIVFormSumCalculatedState);
    });
  });
}
