import 'package:breeder/blocks/pages/genealogical_tree/third_generation/a_third_gen_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_gen_index.dart';

class ThirdGenIVListDefaultState extends AThirdGenState {
  final Map<ThirdGenIndex, List<IVColor>> thirdGenMap;

  const ThirdGenIVListDefaultState({required this.thirdGenMap});

  @override
  List<Map<ThirdGenIndex, List<IVColor>>> get props => <Map<ThirdGenIndex, List<IVColor>>>[thirdGenMap];
}
