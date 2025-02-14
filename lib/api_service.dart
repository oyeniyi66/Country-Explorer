import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://restcountries.com/v3.1";

  Future<List<Map<String, dynamic>>> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/all"));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Map<String, dynamic>> countries = data.map((country) {
          return {
            'name': country['name']['common'],
            'capital':
                country['capital'] != null ? country['capital'][0] : 'N/A',
            'flag': country['flags']['png'],
            'continent': country['continents'] != null
                ? country['continents'][0]
                : 'Unknown',
            'population': country['population'] ?? 0,
            'countryCode': country['cca2'] ?? '',
            'timezones': country['timezones'] ?? [],
          };
        }).toList();

        countries.sort((a, b) => a['name'].compareTo(b['name']));

        return countries;
      } else {
        throw Exception("Failed to load countries");
      }
    } catch (e) {
      print("Error fetching countries: $e");
      return [];
    }
  }

  Future<List<String>> fetchContinents() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/all"));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        Set<String> continents = {};

        for (var country in data) {
          if (country['continents'] != null) {
            continents.add(country['continents'][0]);
          }
        }

        return continents.toList();
      } else {
        throw Exception("Failed to load continents");
      }
    } catch (e) {
      print("Error fetching continents: $e");
      return [];
    }
  }

  Future<List<String>> fetchTimeZones() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/all"));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        Set<String> timeZones = {};

        for (var country in data) {
          if (country['timezones'] != null) {
            timeZones.addAll(List<String>.from(country['timezones']));
          }
        }

        return timeZones.toList();
      } else {
        throw Exception("Failed to load time zones");
      }
    } catch (e) {
      print("Error fetching time zones: $e");
      return [];
    }
  }
}
