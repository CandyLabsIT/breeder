enum MonsterGen {
  firstGen(1),
  secondGen(2),
  thirdGen(3);

  final int value;

  const MonsterGen(this.value);

  int get number => value;
}
