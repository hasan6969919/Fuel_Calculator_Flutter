import 'package:flutter/material.dart';
import '../carselect.dart';
import '../fuelcal.dart';
import '../car.dart';
class FuelCostCalculatorScreen extends StatefulWidget {
  @override
  _FuelCostCalculatorScreenState createState() => _FuelCostCalculatorScreenState();
}

class _FuelCostCalculatorScreenState extends State<FuelCostCalculatorScreen> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _fuelPriceController = TextEditingController();

  final Map<String, double> _carModels = CarData.carModels;
  String _selectedCar = 'Toyota Corolla';
  double _mockDistance = 300.0;
  double? _fuelCost;

  void _calculateFuelCost() {
    final fuelPrice = double.tryParse(_fuelPriceController.text);
    if (fuelPrice == null) return;

    final cost = FuelCalculator.calculateCost(
      distance: _mockDistance,
      consumption: _carModels[_selectedCar]!,
      fuelPrice: fuelPrice,
    );

    setState(() {
      _fuelCost = cost;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fuel Cost Calculator')),
      body: FuelCostForm(
        startController: _startController,
        endController: _endController,
        fuelPriceController: _fuelPriceController,
        selectedCar: _selectedCar,
        carModels: _carModels,
        fuelCost: _fuelCost,
        onCarChanged: (car) => setState(() => _selectedCar = car),
        onCalculate: _calculateFuelCost,
      ),
    );
  }
}

class FuelCostForm extends StatelessWidget {
  final TextEditingController startController;
  final TextEditingController endController;
  final TextEditingController fuelPriceController;
  final String selectedCar;
  final Map<String, double> carModels;
  final double? fuelCost;
  final Function(String) onCarChanged;
  final VoidCallback onCalculate;

  const FuelCostForm({
    Key? key,
    required this.startController,
    required this.endController,
    required this.fuelPriceController,
    required this.selectedCar,
    required this.carModels,
    required this.fuelCost,
    required this.onCarChanged,
    required this.onCalculate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Starting Point', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: startController,
                    decoration: InputDecoration(
                      hintText: 'Enter starting location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Destination', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: endController,
                    decoration: InputDecoration(
                      hintText: 'Enter destination',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),

          CarSelector(
            selectedCar: selectedCar,
            carModels: carModels,
            onChanged: onCarChanged,
          ),

          Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Fuel Price (per liter)', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: fuelPriceController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: 'Enter fuel price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ElevatedButton(
            onPressed: onCalculate,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Calculate Fuel Cost'),
          ),

          if (fuelCost != null)
            Card(
              margin: const EdgeInsets.only(top: 16),
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Estimated Fuel Cost',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${fuelCost!.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}