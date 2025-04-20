class FuelCalculator {
  static double calculateCost({
    required double distance,
    required double consumption,
    required double fuelPrice,
  }) {
    final litresNeeded = (distance / 100) * consumption;
    return litresNeeded * fuelPrice;
  }
}
