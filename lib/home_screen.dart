import 'package:flutter/material.dart';
import 'api_service.dart';
import 'country_details_screen.dart';
import 'filter_screen.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> countries = [];
  List<Map<String, dynamic>> filteredCountries = [];
  String searchQuery = "";
  List<String> selectedContinents = [];
  List<String> selectedTimeZones = [];

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    List<Map<String, dynamic>> fetchedCountries =
        await _apiService.fetchCountries();
    setState(() {
      countries = fetchedCountries;
      filteredCountries = fetchedCountries;
    });
  }

  void applyFilter({List<String>? continents, List<String>? timeZones}) {
    setState(() {
      selectedContinents = continents ?? [];
      selectedTimeZones = timeZones ?? [];
      filteredCountries = countries.where((country) {
        final matchesContinent = selectedContinents.isEmpty ||
            selectedContinents.contains(country['continent']);
        final matchesTimeZone = selectedTimeZones.isEmpty ||
            country['timezones'].any(selectedTimeZones.contains);
        return matchesContinent && matchesTimeZone;
      }).toList();
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredCountries = countries.where((country) {
        final matchesName =
            country['name'].toLowerCase().contains(searchQuery.toLowerCase());
        return matchesName;
      }).toList();
    });
  }

  Map<String, List<Map<String, dynamic>>> groupCountriesAlphabetically() {
    Map<String, List<Map<String, dynamic>>> groupedCountries = {};
    for (var country in filteredCountries) {
      String firstLetter = country['name'][0].toUpperCase();
      if (!groupedCountries.containsKey(firstLetter)) {
        groupedCountries[firstLetter] = [];
      }
      groupedCountries[firstLetter]!.add(country);
    }
    return groupedCountries;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final groupedCountries = groupCountriesAlphabetically();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Explore",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'Serif',
              ),
            ),
            const Text(
              ".",
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode
                ? Icons.wb_sunny
                : Icons.nightlight_round),
            onPressed: themeProvider.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              onChanged: updateSearchQuery,
              decoration: InputDecoration(
                labelText: "Search Country",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilterScreen(
                      onApplyFilter: applyFilter,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.filter_list),
              label: const Text("Filter"),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredCountries.isEmpty
                  ? const Center(child: Text("No countries found"))
                  : ListView.builder(
                      itemCount: groupedCountries.keys.length,
                      itemBuilder: (context, index) {
                        String letter = groupedCountries.keys.elementAt(index);
                        List<Map<String, dynamic>> countriesList =
                            groupedCountries[letter]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Text(
                                letter,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ...countriesList.map((country) {
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    country['flag'],
                                    width: 40,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(country['name']),
                                subtitle:
                                    Text(country['capital'] ?? "No Capital"),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CountryDetailsScreen(
                                              country: country),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
