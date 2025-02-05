import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String githubRepo = 'https://github.com/oyeniyi66/hng_mobile_stages';
  final String hngLink = 'https://hng.tech';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('HNG Stage 0')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => launchUrl(Uri.parse(githubRepo)),
                child: Text('GitHub Repository'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => launchUrl(Uri.parse(hngLink)),
                child: Text('HNG Backlink'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
