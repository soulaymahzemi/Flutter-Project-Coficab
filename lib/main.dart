import 'dart:convert';
import 'package:coficabproject/auth/login.dart';
import 'package:coficabproject/dashbord/PageAcceuil.dart';
import 'package:coficabproject/dashbord/text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async'; // Importer Timer pour récupérer les données périodiquement

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter HTTP Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginpage(),
    );
  }
}

class page extends StatefulWidget {
  @override
  State<page> createState() => _Page();
}

class _Page extends State<page> {
  final ScrollController _listScrollController = ScrollController();
  bool _isScrolledToBottom = false; // Track scroll direction
  List<Map<String, String>> machines = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch the data when the page is loaded
  }

  // Fetch the temperature and humidity data from the API
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://192.168.100.184')); // Replace with your API URL

    if (response.statusCode == 200) {
      String cleanedResponse = cleanHtml(response.body);
      updateMachineData(cleanedResponse);
    } else {
      // Handle error if the request fails
      setState(() {
        machines = [
          {
            'titre': 'St-1: BUNKER',
            'temperateur': 'Failed to load',
            'humidity': 'Failed to load',
            'tempImage': 'thermostat',
            'humidityIcon': 'water_drop',
            'Real Time': 'N/A'
          },
          {
            'titre': 'St-2: STAR',
            'temperateur': '0',
            'humidity': '0',
            'tempImage': 'thermostat',
            'humidityIcon': 'water_drop',
            'Real Time': '10:22',
          },
          {
            'titre': 'St-3: USINE 2',
            'temperateur': '0',
            'humidity': '0',
            'tempImage': 'thermostat',
            'humidityIcon': 'water_drop',
            'Real Time': '10:22'
          },
          {
            'titre': 'St-4:USINE 2',
            'temperateur': '0',
            'humidity': '0',
            'tempImage': 'thermostat',
            'humidityIcon': 'water_drop',
            'Real Time': '10:22'
          },
          {
            'titre': 'St-5: USINE 2',
            'temperateur': '0',
            'humidity': '0',
            'tempImage': 'thermostat',
            'humidityIcon': 'water_drop',
            'Real Time': '10:22'
          },
        ];
      });
    }
  }

  // Clean the HTML response to extract temperature and humidity values
  String cleanHtml(String html) {
    html = html.replaceAll('<br />', '\n');
    html = html.replaceAll(RegExp(r'<[^>]*>'), '');
    html = html.replaceAll(RegExp(r'\s+'), ' ').trim();
    return html;
  }

  // Update machine data based on the cleaned response
  void updateMachineData(String cleanedResponse) {
    RegExp tempRegExp = RegExp(r'analog input 0 is ([\d.]+)C');
    RegExp humidityRegExp = RegExp(r'analog input 1 is ([\d.]+)%HR');

    Match? tempMatch = tempRegExp.firstMatch(cleanedResponse);
    Match? humidityMatch = humidityRegExp.firstMatch(cleanedResponse);

    setState(() {
      machines = [
        {
          'titre': 'St-1: BUNKER',
          'temperateur': '${tempMatch?.group(1)}C',
          'humidity': '${humidityMatch?.group(1)}%RH',
          'tempImage': 'thermostat',
          'humidityIcon': 'water_drop',
          'Real Time': '10:22',
        },
        {
          'titre': 'St-2: STAR',
          'temperateur': '0',
          'humidity': '0',
          'tempImage': 'thermostat',
          'humidityIcon': 'water_drop',
          'Real Time': '10:22',
        },
        {
          'titre': 'St-3: USINE 2',
          'temperateur': '0',
          'humidity': '0',
          'tempImage': 'thermostat',
          'humidityIcon': 'water_drop',
          'Real Time': '10:22'
        },
        {
          'titre': 'St-4:USINE 2',
          'temperateur': '0',
          'humidity': '0',
          'tempImage': 'thermostat',
          'humidityIcon': 'water_drop',
          'Real Time': '10:22'
        },
        {
          'titre': 'St-5: USINE 2',
          'temperateur': '0',
          'humidity': '0',
          'tempImage': 'thermostat',
          'humidityIcon': 'water_drop',
          'Real Time': '10:22'
        },
      ];
    });
  }

  void _toggleScrollDirection() {
    if (_listScrollController.hasClients) {
      if (_isScrolledToBottom) {
        _listScrollController.animateTo(
          0.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      } else {
        final position = _listScrollController.position.maxScrollExtent;
        _listScrollController.animateTo(
          position,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }

      setState(() {
        _isScrolledToBottom = !_isScrolledToBottom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: _toggleScrollDirection,
        tooltip: _isScrolledToBottom ? 'Scroll to Top' : 'Scroll to Bottom',
        child: Icon(
          _isScrolledToBottom ? Icons.arrow_upward : Icons.arrow_downward,
          size: 20,
        ),
      ),
      body: SingleChildScrollView(
        controller: _listScrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: machines.length,
                itemBuilder: (context, index) {
                  final card = machines[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to a detailed page if necessary
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(13.0)),
                          gradient: LinearGradient(
                            colors: [Color(0xFFFE4956), Color(0xFFF9B1B8)],
                            begin: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  card['titre'] ?? 'Unknown',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Icon(
                                    Icons.thermostat,
                                    size: 40,
                                    color: Colors.redAccent,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    card['temperateur'] ?? '0',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(
                                    Icons.water_drop,
                                    size: 40,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    card['humidity'] ?? '0',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              Center(
                                child: Text(
                                  'Real Time: ${card['Real Time']}',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
