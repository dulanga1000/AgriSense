import 'package:flutter/material.dart';

class FilterSectionWidget extends StatefulWidget {
  const FilterSectionWidget({super.key});

  @override
  State<FilterSectionWidget> createState() => _FilterSectionWidgetState();
}

class _FilterSectionWidgetState extends State<FilterSectionWidget> {

  String selectedSeason = "Yala Season";
  String selectedProvince = "Western";

  final List<Map<String, String>> seasons = [
    {"name": "Yala Season", "period": "April - September"},
    {"name": "Maha Season", "period": "October - March"},
  ];

  final List<String> provinces = [
    "Central",
    "Eastern",
    "North Central",
    "Northern",
    "North Western",
    "Sabaragamuwa",
    "Southern",
    "Uva",
    "Western"
  ];

  /// SEASON DROPDOWN
  Widget seasonBox() {
    return Expanded(
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
                value: selectedSeason,
                isExpanded: true,
                items: seasons.map((season) {
                  return DropdownMenuItem<String>(
                    value: season["name"],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          season["name"]!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          season["period"]!,
                          style: const TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSeason = value!;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /// PROVINCE DROPDOWN WITH SEARCH
  Widget provinceBox() {
    return Expanded(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text("Location", style: TextStyle(fontSize: 12)),

              const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedProvince,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.keyboard_arrow_down)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// SEARCHABLE PROVINCE DIALOG
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

                  /// SEARCH BAR
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
                          title: Text(province),
                          onTap: () {
                            setState(() {
                              selectedProvince = province;
                            });

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          seasonBox(),
          provinceBox(),
        ],
      ),
    );
  }
}