import 'package:flutter/material.dart';
import 'package:agrisense/data/models/farm_stats_model.dart';

class FormDetails extends StatefulWidget {
  const FormDetails({super.key});

  @override
  State<FormDetails> createState() => _FormDetailsState();
}

class _FormDetailsState extends State<FormDetails> {

  final FarmStatsModel farmStats = FarmStatsModel(
    acres: 15,
    scans: 42,
    crops: 8,
    experience: 10,
  );

  late TextEditingController farmSizeController;
  late TextEditingController cropsController;
  late TextEditingController experienceController;

  @override
  void initState() {
    super.initState();

    farmSizeController =
        TextEditingController(text: farmStats.acres.toString());

    cropsController =
        TextEditingController(text: "Rice, Wheat, Cotton");

    experienceController =
        TextEditingController(text: "10");
  }

  void increaseFarmSize() {
    int value = int.tryParse(farmSizeController.text) ?? 0;
    setState(() {
      farmSizeController.text = (value + 1).toString();
    });
  }

  void decreaseFarmSize() {
    int value = int.tryParse(farmSizeController.text) ?? 0;
    if (value > 0) {
      setState(() {
        farmSizeController.text = (value - 1).toString();
      });
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
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE
          const Text(
            "Farm Details",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          /// FARM SIZE
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
                      controller: farmSizeController,
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
                      onTap: increaseFarmSize,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: const Icon(
                          Icons.arrow_drop_up,
                          size: 20,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: decreaseFarmSize,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: const Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// PRIMARY CROPS
          const Text(
            "Primary Crops",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),

          const SizedBox(height: 6),

          TextField(
            controller: cropsController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// EXPERIENCE
          const Text(
            "Farming Experience (Years)",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),

          const SizedBox(height: 6),

          TextField(
            controller: experienceController,
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