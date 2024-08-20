import 'package:breeder/blocks/pages/genealogical_tree/third_generation/a_third_generation_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_gen_index.dart';

class ThirdGenIVListDefaultState extends AThirdGenerationState {
  final Map<ThirdGenIndex, List<IVColor>> thirdGenMap;

  const ThirdGenIVListDefaultState({required this.thirdGenMap});

  @override
  List<Map<ThirdGenIndex, List<IVColor>>> get props => <Map<ThirdGenIndex, List<IVColor>>>[thirdGenMap];
}
