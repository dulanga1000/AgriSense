import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/crop/constants/season_constants.dart';
import 'package:agrisense/core/constants/location_constants.dart';
import 'package:agrisense/data/models/district_model.dart';
import 'package:agrisense/presentation/crop/state/crop_advisory_state.dart';

class FilterSectionWidget extends StatelessWidget {
  const FilterSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CropAdvisoryState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: _SelectorCard(
              label: "Select Season",
              value: state.selectedSeason.name.split(" ").first,
              isOpen: state.isSeasonOpen,
              onTap: () => state.toggleSeason(),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: _SelectorCard(
              label: "Location",
              value: state.selectedDistrict.province.length > 10
                  ? "${state.selectedDistrict.province.substring(0, 10)}..."
                  : state.selectedDistrict.province,
              isOpen: state.isLocationOpen,
              onTap: () => state.toggleLocation(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectorCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isOpen;
  final VoidCallback onTap;

  const _SelectorCard({
    required this.label,
    required this.value,
    required this.isOpen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isOpen
              ? const BorderRadius.vertical(top: Radius.circular(12))
              : BorderRadius.circular(12),
          boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Icon(
              isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}

class SeasonDropdownContent extends StatelessWidget {
  final CropAdvisoryState state;

  const SeasonDropdownContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: SeasonConstants.seasons.map((season) {
          final isSelected = state.selectedSeason.name == season.name;
          final isLast = season == SeasonConstants.seasons.last;

          return GestureDetector(
            onTap: () {
              state.updateSeason(season);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
                borderRadius: isLast
                    ? const BorderRadius.vertical(bottom: Radius.circular(12))
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    season.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isSelected
                          ? const Color(0xFF16A34A)
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    season.period,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? const Color(0xFF16A34A) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class LocationDropdownContent extends StatefulWidget {
  final CropAdvisoryState state;

  const LocationDropdownContent({super.key, required this.state});

  @override
  State<LocationDropdownContent> createState() =>
      _LocationDropdownContentState();
}

class _LocationDropdownContentState extends State<LocationDropdownContent> {
  final TextEditingController _searchController = TextEditingController();
  List<DistrictModel> _filtered = LocationConstants.districts;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filter(String value) {
    setState(() {
      _filtered = LocationConstants.districts
          .where(
            (d) =>
                d.district.toLowerCase().contains(value.toLowerCase()) ||
                d.province.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onChanged: _filter,
              decoration: InputDecoration(
                hintText: "Search location",
                hintStyle: const TextStyle(fontSize: 13),
                prefixIcon: const Icon(Icons.search, size: 18),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 220,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final district = _filtered[index];
                final isSelected =
                    widget.state.selectedDistrict.district == district.district;
                final showHeader =
                    index == 0 ||
                    _filtered[index - 1].province != district.province;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showHeader)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        color: Colors.grey.shade100,
                        child: Text(
                          district.province,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        widget.state.updateDistrict(district);
                      },
                      child: Container(
                        color: isSelected
                            ? const Color(0xFFE8F5E9)
                            : Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: isSelected
                                  ? const Color(0xFF16A34A)
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              district.district,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? const Color(0xFF16A34A)
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
