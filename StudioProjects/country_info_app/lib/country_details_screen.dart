import 'package:flutter/material.dart';

class CountryDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> country;

  const CountryDetailsScreen({Key? key, required this.country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(country['name'], style: const TextStyle(fontSize: 24))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(country['flag'], width: 200, height: 170),
            ),
            const SizedBox(height: 20),
            Text(
              "Name: ${country['name']}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text("Capital: ${country['capital'] ?? 'No Capital'}",
                style: const TextStyle(fontSize: 18)),
            Text("Population: ${country['population'] ?? 'N/A'}",
                style: const TextStyle(fontSize: 18)),
            Text("Continent: ${country['continent'] ?? 'Unknown'}",
                style: const TextStyle(fontSize: 18)),
            if (country.containsKey('president'))
              Text("President: ${country['president']}",
                  style: const TextStyle(fontSize: 18)),
            Text("Country Code: ${country['countryCode']}",
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
