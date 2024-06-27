import 'dart:ui';

import 'package:breeder/blocks/pages/third_generation/a_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/init_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/restarted_third_generation_female_values_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/restarted_third_generation_male_values_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/third_generation_female_color_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/third_generation_male_color_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_generation_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdGenerationCubit extends Cubit<AThirdGenerationState> {

  ThirdGenerationModel thirdGenerationModel = ThirdGenerationModel();

  ThirdGenerationCubit() : super(InitSecondGenerationFamilyState());

  void getFemaleColors(int listNumber, int value) {
    thirdGenerationModel.updateValues(thirdGenerationModel.thirdGenerationIVList[listNumber][0], value);
    emit(
      ThirdGenerationFemaleColorsState(valuesList: <Color>[
        IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][0][0]).color,
        IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][0][1]).color,
        IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][0][2]).color,
      ]),
    );
  }

  void getMaleColors(int listNumber, int value) {
    thirdGenerationModel.updateValues(thirdGenerationModel.thirdGenerationIVList[listNumber][1], value);
    emit(
      ThirdGenerationMaleColorsState(valuesList: <Color>[
        IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][1][0]).color,
        IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][1][1]).color,
        IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][1][2]).color,
      ]),
    );
  }

  void resetFemaleValues(int listNumber) {
    if (thirdGenerationModel.isSumPositive(thirdGenerationModel.thirdGenerationIVList[listNumber][0])) {
      thirdGenerationModel.restartListValues(thirdGenerationModel.thirdGenerationIVList[listNumber][0]);
    }
    emit(
      RestartedThirdGenerationFemaleValuesState(
        valuesList: <Color>[
          IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][0][0]).color,
          IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][0][1]).color,
          IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][0][2]).color,
        ],
      ),
    );
  }

  void resetThirdMaleValues(int listNumber) {
    if (thirdGenerationModel.isSumPositive(thirdGenerationModel.thirdGenerationIVList[listNumber][1])) {
      thirdGenerationModel.restartListValues(thirdGenerationModel.thirdGenerationIVList[listNumber][1]);
    }
    emit(
      RestartedThirdGenerationMaleValuesState(
        valuesList: <Color>[
          IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][1][0]).color,
          IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][1][1]).color,
          IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][1][2]).color,
        ],
      ),
    );
  }

  List<Color> getFemaleButtonColors(int listNumber) {
    if (state is ThirdGenerationFemaleColorsState) {
      return (state as ThirdGenerationFemaleColorsState).valuesList;
    } else if (state is RestartedThirdGenerationFemaleValuesState) {
      return (state as RestartedThirdGenerationFemaleValuesState).valuesList;
    }
    return <Color>[
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][0][0]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][0][1]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][0][2]).color,
    ];
  }

  List<Color> getMaleButtonColors(int listNumber) {
    if (state is ThirdGenerationMaleColorsState) {
      return (state as ThirdGenerationMaleColorsState).valuesList;
    } else if (state is RestartedThirdGenerationMaleValuesState) {
      return (state as RestartedThirdGenerationMaleValuesState).valuesList;
    }
    return <Color>[
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][1][0]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][1][1]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[listNumber][1][2]).color,
    ];
  }
}