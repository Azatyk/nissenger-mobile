class Ticker {
  const Ticker();

  Stream<int> tick({required int ticksNumber}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (count) => ticksNumber - count - 1,
    ).take(ticksNumber);
  }
}
