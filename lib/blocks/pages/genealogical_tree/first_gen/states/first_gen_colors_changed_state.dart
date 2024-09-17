import 'package:breeder/blocks/pages/genealogical_tree/first_gen/a_first_gen_state.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';

class FirstGenColorsChangedState extends ASecondGenState {
  final Map<FirstGenIndex, List<IVColor>> firstGenMap;

  const FirstGenColorsChangedState({required this.firstGenMap});

  @override
  List<Map<FirstGenIndex, List<IVColor>>> get props => <Map<FirstGenIndex, List<IVColor>>>[firstGenMap];
}
