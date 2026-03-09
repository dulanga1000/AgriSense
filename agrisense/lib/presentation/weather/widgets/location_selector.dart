import 'package:flutter/material.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  bool showList = false;
  String selectedLocation = "Western Province";
  String searchQuery = "";

  final Map<String, List<String>> locations = {
    "Western Province": ["Colombo", "Negombo", "Kalutara"],
    "Central Province": ["Kandy", "Matale", "Nuwara Eliya"],
    "Southern Province": ["Galle", "Matara", "Hambantota"],
    "Northern Province": ["Jaffna", "Vavuniya"],
    "Eastern Province": ["Trincomalee", "Batticaloa", "Ampara"],
    "North Western Province": ["Kurunegala", "Puttalam"],
    "North Central Province": ["Anuradhapura", "Polonnaruwa"],
    "Uva Province": ["Badulla", "Monaragala"],
    "Sabaragamuwa Province": ["Ratnapura", "Kegalle"],
  };

  List<Map<String, String>> getFilteredCities() {
    List<Map<String, String>> results = [];

    locations.forEach((province, cities) {
      for (var city in cities) {
        if (city.toLowerCase().contains(searchQuery.toLowerCase())) {
          results.add({"province": province, "city": city});
        }
      }
    });

    return results;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = getFilteredCities();

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              showList = !showList;
            });
          },

          child: Container(
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 6),
              ],
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Change Location",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      selectedLocation,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                Icon(
                  showList
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),

        if (showList)
          Container(
            height: 300,
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 6),
              ],
            ),

            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search location...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,

                    itemBuilder: (context, index) {
                      final item = filtered[index];

                      return ListTile(
                        leading: const Icon(Icons.location_on_outlined),

                        title: Text(item["city"]!),

                        subtitle: Text(item["province"]!),

                        onTap: () {
                          setState(() {
                            selectedLocation =
                                "${item["city"]}, ${item["province"]}";

                            showList = false;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
