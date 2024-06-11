enum MonsterGen {
  firstGen(1),
  secondGen(2);

  final int value;

  const MonsterGen(this.value);

  int get number => value;
}
