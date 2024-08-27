import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';

class SecondGenMonsterDefaultState extends ASecondGenState {
  final Map<SecondGenIndex, List<IVColor>> secondGenMap;

  const SecondGenMonsterDefaultState({required this.secondGenMap});

  @override
  List<Map<SecondGenIndex, List<IVColor>>> get props => <Map<SecondGenIndex, List<IVColor>>>[secondGenMap];
}
