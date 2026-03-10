import 'package:flutter/material.dart';
import 'globals.dart';

class FilterSectionWidget extends StatefulWidget {
  const FilterSectionWidget({super.key});

  @override
  State<FilterSectionWidget> createState() => _FilterSectionWidgetState();
}

class _FilterSectionWidgetState extends State<FilterSectionWidget> {
  String selectedSeasonLocal = selectedSeason.value;
  String selectedProvinceLocal = selectedProvince.value;

  final List<Map<String, String>> seasons = [
    {"name": "Yala Season", "period": "April - September"},
    {"name": "Maha Season", "period": "October - March"},
  ];

  final List<String> provinces = [
    "Central Province, Sri Lanka",
    "Eastern Province, Sri Lanka",
    "North Central Province, Sri Lanka Province, Sri Lanka",
    "Northern Province, Sri Lanka",
    "North Western Province, Sri Lanka",
    "Sabaragamuwa Province, Sri Lanka",
    "Southern Province, Sri Lanka",
    "Uva Province, Sri Lanka",
    "Western Province"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(blurRadius: 6, color: Colors.black12)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Season", style: TextStyle(fontSize: 12)),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedSeasonLocal,
                      isExpanded: true,
                      items: seasons.map((season) {
                        return DropdownMenuItem<String>(
                          value: season["name"],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                season["name"]!,
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                season["period"]!,
                                style: const TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          final period = seasons
                              .firstWhere((s) => s["name"] == value)["period"]!;
                          setState(() {
                            selectedSeasonLocal = value;
                          });
                          selectedSeason.value = value;
                          selectedSeasonPeriod.value = period;
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),

          
          Expanded(
            child: GestureDetector(
              onTap: () {
                showProvinceSearch();
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(blurRadius: 6, color: Colors.black12)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        selectedProvinceLocal,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showProvinceSearch() {
    TextEditingController searchController = TextEditingController();
    List<String> filteredList = provinces;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            void filter(String value) {
              setStateDialog(() {
                filteredList = provinces
                    .where((p) =>
                        p.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              });
            }

            return AlertDialog(
              title: const Text("Select Province"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: "Search province...",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: filter,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final province = filteredList[index];
                        return ListTile(
                          title: Text(
                            province,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          onTap: () {
                            setState(() {
                              selectedProvinceLocal = province;
                            });
                            selectedProvince.value = province;
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}