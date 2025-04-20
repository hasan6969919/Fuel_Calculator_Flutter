import 'package:flutter/material.dart';

class CarSelector extends StatelessWidget {
  final String selectedCar;
  final Map<String, double> carModels;
  final Function(String) onChanged;

  const CarSelector({
    required this.selectedCar,
    required this.carModels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose your car', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedCar,
              onChanged: (val) => onChanged(val!),
              items: carModels.keys.map((car) {
                return DropdownMenuItem(
                  child: Text('$car (${carModels[car]} L/100km)'),
                  value: car,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
