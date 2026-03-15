import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';

class FormDetails extends StatefulWidget {
  const FormDetails({super.key});

  @override
  State<FormDetails> createState() => _FormDetailsState();
}

class _FormDetailsState extends State<FormDetails> {
  late TextEditingController _farmSizeController;
  late TextEditingController _cropsController;
  late TextEditingController _experienceController;

  @override
  void initState() {
    super.initState();
    final stats = context.read<ProfileState>().farmStats;
    _farmSizeController = TextEditingController(text: stats.acres.toString());
    _cropsController = TextEditingController(text: "Rice, Wheat, Cotton");
    _experienceController = TextEditingController(
      text: stats.experience.toString(),
    );
  }

  @override
  void dispose() {
    _farmSizeController.dispose();
    _cropsController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void _increase() {
    final value = int.tryParse(_farmSizeController.text) ?? 0;
    setState(() => _farmSizeController.text = (value + 1).toString());
  }

  void _decrease() {
    final value = int.tryParse(_farmSizeController.text) ?? 0;
    if (value > 0) {
      setState(() => _farmSizeController.text = (value - 1).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Farm Details",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            "Farm Size (Acres)",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 6),

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: _farmSizeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: _increase,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        child: const Icon(Icons.arrow_drop_up, size: 20),
                      ),
                    ),
                    InkWell(
                      onTap: _decrease,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        child: const Icon(Icons.arrow_drop_down, size: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            "Primary Crops",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _cropsController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            "Farming Experience (Years)",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _experienceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
