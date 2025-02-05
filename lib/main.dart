import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherInfoApp());
}

class WeatherInfoApp extends StatelessWidget {
  const WeatherInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Info App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  String cityName = "";
  String temperature = "";
  String weatherCondition = "";
  List<Map<String, String>> forecast = [];

  final List<String> weatherConditions = ["Sunny", "Cloudy", "Rainy"];
  final Random _random = Random();

  // Fetch current weather
  void _fetchWeather() {
    setState(() {
      cityName = _cityController.text.isNotEmpty
          ? _cityController.text
          : "Unknown City";
      int temp = 15 +
          _random
              .nextInt(16); // Generates a random temperature between 15 and 30
      String condition =
          weatherConditions[_random.nextInt(weatherConditions.length)];

      temperature = "$temp°C";
      weatherCondition = condition;
    });
  }

  // Fetch 7-day forecast
  void _fetchForecast() {
    setState(() {
      forecast = List.generate(7, (index) {
        int temp = 15 +
            _random.nextInt(
                16); // Generates a random temperature between 15 and 30
        String condition =
            weatherConditions[_random.nextInt(weatherConditions.length)];
        return {
          "day": "Day ${index + 1}",
          "temperature": "$temp°C",
          "condition": condition,
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: "Enter City Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _fetchWeather,
                  child: const Text("Fetch Weather"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _fetchForecast,
                  child: const Text("Fetch 7-Day Forecast"),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Display current weather info
            if (cityName.isNotEmpty) ...[
              Text(
                "City: $cityName",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Temperature: $temperature",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                "Condition: $weatherCondition",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
            ],

            // Display 7-day weather forecast
            if (forecast.isNotEmpty) ...[
              const Text(
                "7-Day Forecast",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: forecast.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(forecast[index]["day"]!),
                        subtitle: Text(
                            "Temperature: ${forecast[index]["temperature"]}, Condition: ${forecast[index]["condition"]}"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
