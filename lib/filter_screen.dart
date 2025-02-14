import 'package:flutter/material.dart';
import 'api_service.dart';

class FilterScreen extends StatefulWidget {
  final Function({List<String>? continents, List<String>? timeZones})
      onApplyFilter;

  const FilterScreen({Key? key, required this.onApplyFilter}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final ApiService _apiService = ApiService();
  List<String> continents = [];
  List<String> timeZones = [];
  List<String> selectedContinents = [];
  List<String> selectedTimeZones = [];

  @override
  void initState() {
    super.initState();
    fetchFilters();
  }

  Future<void> fetchFilters() async {
    List<String> fetchedContinents = await _apiService.fetchContinents();
    List<String> fetchedTimeZones = await _apiService.fetchTimeZones();

    setState(() {
      continents = fetchedContinents;
      timeZones = fetchedTimeZones;
    });
  }

  void resetFilters() {
    setState(() {
      selectedContinents.clear();
      selectedTimeZones.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Countries"),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  ExpansionTile(
                    title: const Text("Continents"),
                    children: [
                      Wrap(
                        spacing: 8.0,
                        children: continents.map((continent) {
                          return FilterChip(
                            label: Text(continent),
                            selected: selectedContinents.contains(continent),
                            onSelected: (bool selected) {
                              setState(() {
                                selected
                                    ? selectedContinents.add(continent)
                                    : selectedContinents.remove(continent);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text("Time Zones"),
                    children: [
                      Wrap(
                        spacing: 8.0,
                        children: timeZones.map((timeZone) {
                          return FilterChip(
                            label: Text(timeZone),
                            selected: selectedTimeZones.contains(timeZone),
                            onSelected: (bool selected) {
                              setState(() {
                                selected
                                    ? selectedTimeZones.add(timeZone)
                                    : selectedTimeZones.remove(timeZone);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: resetFilters,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    side: const BorderSide(color: Colors.orange),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Reset",
                      style: TextStyle(color: Colors.orange, fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onApplyFilter(
                      continents: selectedContinents.isNotEmpty
                          ? selectedContinents
                          : null,
                      timeZones: selectedTimeZones.isNotEmpty
                          ? selectedTimeZones
                          : null,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Show Results",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
