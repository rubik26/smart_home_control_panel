abstract class SmartLampRepo {
  int power = 0;
  Future<int> togglePower(int level);
  int getPower();
}
