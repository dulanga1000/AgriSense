import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/fertilizer/state/fertilizer_state.dart';
import 'package:flutter/services.dart';

class FertilizerForm extends StatefulWidget {
  final Function(String cropType, double landSize) onSubmit;

  const FertilizerForm({super.key, required this.onSubmit});

  @override
  State<FertilizerForm> createState() => _FertilizerFormState();
}

class _FertilizerFormState extends State<FertilizerForm> {
  static const String _defaultCropOption = "Select Crop";
  String? selectedCrop;
  final TextEditingController _landController = TextEditingController();

  static const List<String> _cropTypes = [
    _defaultCropOption,
    "Rice",
    "Maize",
    "Finger Millet",
    "Green Gram",
    "Cowpea",
    "Soybean",
    "Sesame",
    "Groundnut",
    "Cassava",
    "Sweet Potato",
    "Tea",
    "Rubber",
    "Coconut",
    "Cinnamon",
    "Pepper",
    "Clove",
    "Cardamom",
    "Nutmeg",
    "Coffee",
    "Cocoa",
    "Arecanut",
    "Banana",
    "Mango",
    "Papaya",
    "Pineapple",
    "Avocado",
    "Guava",
    "Rambutan",
    "Mangosteen",
    "Orange",
    "Lime",
    "Lemon",
    "Passion Fruit",
    "Wood Apple",
    "Tomato",
    "Chili",
    "Capsicum",
    "Brinjal",
    "Okra",
    "Onion",
    "Big Onion",
    "Garlic",
    "Potato",
    "Cabbage",
    "Carrot",
    "Leeks",
    "Beetroot",
    "Radish",
    "Cauliflower",
    "Broccoli",
    "Lettuce",
    "Beans",
    "Peas",
    "Cucumber",
    "Watermelon",
    "Pumpkin",
    "Bitter Gourd",
    "Snake Gourd",
    "Ridge Gourd",
    "Ash Plantain",
    "Long Bean",
    "Winged Bean",
  ];

  @override
  void initState() {
    super.initState();
    selectedCrop = _cropTypes.first;
  }

  bool get _isFormValid =>
      selectedCrop != null &&
      selectedCrop != _defaultCropOption &&
      _landController.text.isNotEmpty;

  @override
  void dispose() {
    _landController.dispose();
    super.dispose();
  }

  void _submit() {
    final landSize = double.tryParse(_landController.text) ?? 0;
    widget.onSubmit(selectedCrop!, landSize);
  }

  @override
  Widget build(BuildContext context) {
    final fertilizerState = context.watch<FertilizerState>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.eco, color: Colors.green),
                const SizedBox(width: 8),
                const Text(
                  "Enter Crop Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text("Crop Type"),
            const SizedBox(height: 6),

            DropdownButtonFormField<String>(
              initialValue: selectedCrop,
              items: _cropTypes
                  .map(
                    (crop) => DropdownMenuItem(value: crop, child: Text(crop)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => selectedCrop = value),

              decoration: InputDecoration(
                border: const OutlineInputBorder(),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text("Land Size (Acres)"),
            const SizedBox(height: 6),

            TextField(
              controller: _landController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: "Enter land size",

                border: const OutlineInputBorder(),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: _isFormValid && !fertilizerState.isLoading
                    ? _submit
                    : null,
                child: Text(
                  fertilizerState.isLoading
                      ? "Loading..."
                      : "Get Recommendation",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
