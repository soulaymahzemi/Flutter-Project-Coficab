import 'package:coficabproject/appbar/appbar.dart';
import 'package:coficabproject/appbar/darwer.dart';
import 'package:coficabproject/dashbord/st-5_usine.dart';
import 'package:coficabproject/dashbord/st1star.dart';
import 'package:coficabproject/dashbord/st2usine.dart';
import 'package:coficabproject/dashbord/st3usine.dart';
import 'package:coficabproject/dashbord/st4-Usine2.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert'; // Import pour décoder le JSON

class PageAcceuil extends StatefulWidget {
  @override
  State<PageAcceuil> createState() => _PageAcceuil();
}

class _PageAcceuil extends State<PageAcceuil> {
  final ScrollController _listScrollController = ScrollController();
  bool _isScrolledToBottom = false; // Track scroll direction

  final List<Map<String, String>> machines = [
    {
      'titre': 'St-2: BUNKER',
      'temperateur': '0',
      'humidity': '0',
      'tempImage': 'thermostat',
      'humidityIcon': 'water_drop',
      'Real Time': '0'
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
      'titre': 'St-3:  AMB-US2',
      'temperateur': '0',
      'humidity': '0',
      'tempImage': 'thermostat',
      'humidityIcon': 'water_drop',
      'Real Time': '10:22'
    },
    {
      'titre': 'st-4:Mg-US3',
      'temperateur': '0',
      'humidity': '0',
      'tempImage': 'thermostat',
      'humidityIcon': 'water_drop',
      'Real Time': '10:22'
    },
    {
      'titre': 'ST-5:Station1',
      'temperateur': '0',
      'humidity': '0',
      'tempImage': 'thermostat',
      'humidityIcon': 'water_drop',
      'Real Time': '10:22'
    },
  ];

  @override
  void initState() {
    super.initState();
    fetchData(); // Récupération initiale des données

    // Met à jour les données toutes les 10 secondes (par exemple)
    Timer.periodic(Duration(seconds: 5), (timer) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.100.184'), // Remplacez par votre URL API
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Décodage JSON
        updateMachineData(data);
        print('Réponse de l\'API (JSON): ${response.body}');
      } else {
        debugPrint('Erreur : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erreur de connexion : $e');
    }
  }

// Mise à jour des données de la machine
  void updateMachineData(Map<String, dynamic> jsonResponse) {
    print("Données reçues : $jsonResponse");

    if (jsonResponse.containsKey('temperature') &&
        jsonResponse.containsKey('humidity')) {
      final temperature = jsonResponse['temperature'];
      final humidity = jsonResponse['humidity'];

      setState(() {
        machines[0] = {
          'titre': 'St-1: BUNKER',
          'temperateur': '${temperature.toStringAsFixed(1)} C',
          'humidity': '${humidity.toStringAsFixed(1)} %RH',
          'tempImage': 'thermostat',
          'humidityIcon': 'water_drop',
          'Real Time': '10:22',
        };
      });

      print("Température: $temperature, Humidité: $humidity");
    } else {
      print("Données JSON manquantes : température ou humidité");
    }
  }

// Mise à jour des données pour les graphiques
  List<ChartData> chartDataFromMachines(List<Map<String, String>> machines) {
    return machines.map((machine) {
      return ChartData(
        machine['titre'] ?? 'Unknown', // Titre comme axe X
        double.parse(
            machine['temperateur']!.replaceAll('C', '')), // Température
        double.parse(machine['humidity']!.replaceAll('%RH', '')), // Humidité
      );
    }).toList();
  }

  // Sample data for the chart
  final List<ChartData> chartData = [
    ChartData('00:00', 0, 44),
    ChartData('10:05', 23, 45),
    ChartData('10:10', 25, 50),
    ChartData('10:15', 24, 48),
    ChartData('10:20', 26, 52),
  ];
  void _toggleScrollDirection() {
    if (_listScrollController.hasClients) {
      if (_isScrolledToBottom) {
        // Scroll to the top
        _listScrollController.animateTo(
          0.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      } else {
        // Scroll to the bottom
        final position = _listScrollController.position.maxScrollExtent;
        _listScrollController.animateTo(
          position,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }

      // Toggle the scroll direction flag
      setState(() {
        _isScrolledToBottom = !_isScrolledToBottom;
      });
    }
  }

  /* final List<Widget> pages = [
    Card1(),
    Card2(),
    Card3(),
    Card4(),
    Card5(),
  ];*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      drawer: CustomDrawer(),
      // Floating action button. Functionality to be implemented
      floatingActionButton: FloatingActionButton.small(
        onPressed: _toggleScrollDirection,
        tooltip: _isScrolledToBottom ? 'Scroll to Top' : 'Scroll to Bottom',
        // Makes the button smaller
        child: Icon(
          _isScrolledToBottom ? Icons.arrow_upward : Icons.arrow_downward,
          size: 20,
        ),
      ),
      body: SingleChildScrollView(
        // Enable scrolling of the entire body
        controller: _listScrollController, // Attach ScrollController her
        child: Column(
          children: [
            // GridView with Cards
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // Empêche le défilement interne
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: machines.length,
                  itemBuilder: (context, index) {
                    final card = machines[index];
                    final temperature = double.tryParse(
                            card['temperateur']?.replaceAll('C', '') ?? '0') ??
                        0.0;
                    final humidity = double.tryParse(
                            card['humidity']?.replaceAll('%RH', '') ?? '0') ??
                        0.0;

                    // Define thresholds for alerts
                    const double temperatureThreshold = 20.0;
                    const double humidityThreshold = 50.0;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Card1(card: card),
                            //pages[index % pages.length],
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(13.0)),
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
                                // Affichage du titre
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      card['titre'] ?? 'Unknown',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 250, 247, 247),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                // Affichage de la température
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      if (temperature > temperatureThreshold)
                                        Icon(
                                          Icons.warning,
                                          size: 20,
                                          color: Colors.yellow,
                                        ),
                                      const SizedBox(width: 5),
                                      Icon(
                                        Icons.thermostat,
                                        size: 30,
                                        color: const Color.fromARGB(
                                            255, 240, 238, 238),
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
                                ),
                                const SizedBox(height: 20),
                                // Affichage de l'humidité
                                // Humidity icon and value with alert
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      if (humidity > humidityThreshold)
                                        Icon(
                                          Icons.warning,
                                          size: 20,
                                          color: Colors.yellow,
                                        ),
                                      const SizedBox(width: 5),
                                      Icon(
                                        Icons.water_drop,
                                        size: 25,
                                        color: const Color.fromARGB(
                                            255, 240, 238, 238),
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
                                ),
                                const SizedBox(height: 40),
                                Center(
                                  child: Text(
                                    'Real Time: ${card['Real Time']}',
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
            SizedBox(
              height: 30,
            ),
            // Chart Widget
            SizedBox(
                width: double.infinity,
                height: 300, // Chart height
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(text: 'Time'),
                  ),
                  axes: <ChartAxis>[
                    // Temperature Axis (on the left side)
                    NumericAxis(
                      name: 'Temperature',
                      title: AxisTitle(
                          text: 'Temperature (°C)',
                          textStyle: TextStyle(fontSize: 12)),
                      opposedPosition: false, // Left side (default position)
                      minimum: 0,
                      maximum: 120,
                      interval:
                          20, // Show ticks at intervals of 20 (e.g., 0, 20, 40, 60, etc.)
                    ),

                    // Humidity Axis (on the right side)
                    NumericAxis(
                      name: 'Humidity',
                      title: AxisTitle(
                          text: 'Humidity (%RH)',
                          textStyle: TextStyle(fontSize: 12)),
                      opposedPosition: true, // Right side
                      minimum: 0, // Set the minimum value to 0 for humidity
                      maximum: 120, // Adjust max value for humidity (0 to 100%)
                      interval:
                          20, // Show ticks at intervals of 20 (e.g., 0, 20, 40, 60, etc.)
                    ),
                  ],
                  legend: Legend(
                    isVisible: true, // Enable legend visibility
                    position:
                        LegendPosition.top, // Position the legend at the top
                    alignment: ChartAlignment
                        .center, // Align legend items in the center
                    overflowMode: LegendItemOverflowMode
                        .wrap, // Wrap legend items if they overflow
                  ),
                  series: <CartesianSeries>[
                    // Temperature Series
                    SplineAreaSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.time,
                      yValueMapper: (ChartData data, _) => data.temperature,
                      yAxisName:
                          'Temperature', // Associate this series with the temperature axis
                      name: 'Temperature',
                      color: Colors.red, // Line color
                      splineType: SplineType.monotonic, // Smooth curve
                      borderColor: Colors.red, // Dark contour
                      borderWidth: 2,
                      gradient: LinearGradient(
                        colors: [
                          Colors.red.withOpacity(0.3),
                          Colors.red.withOpacity(0)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),

                    // Humidity Series
                    SplineAreaSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.time,
                      yValueMapper: (ChartData data, _) => data.humidity,
                      yAxisName:
                          'Humidity', // Associate this series with the humidity axis
                      name: 'Humidity',
                      color: Colors.blue,
                      splineType: SplineType.monotonic,
                      borderColor: Colors.blue,
                      borderWidth: 2,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.3),
                          Colors.blue.withOpacity(0)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                )),
// Construire le graphique avec ajustement des titres
            SizedBox(
              width: 400,
              height: 400, // Hauteur du graphique
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(text: 'Machines'),
                  labelRotation: 0, // No rotation
                  labelPlacement: LabelPlacement
                      .betweenTicks, // Positionner les labels entre les ticks
                  // Custom label formatter to break the label into multiple lines
                  axisLabelFormatter: (AxisLabelRenderDetails details) {
                    String label = details.text;

                    // Split the label into two lines if it's too long
                    if (label.length > 5) {
                      int midIndex = (label.length / 2).floor();
                      String firstLine = label.substring(0, midIndex);
                      String secondLine = label.substring(midIndex);

                      // Return a ChartAxisLabel with a line break
                      return ChartAxisLabel(
                          '$firstLine\n$secondLine', details.textStyle);
                    }

                    // If it's short, return the label as is
                    return ChartAxisLabel(label, details.textStyle);
                  },
                ),
                axes: <ChartAxis>[
                  // Axe pour la température
                  NumericAxis(
                    name: 'Temperature',
                    title: AxisTitle(
                        text: 'Temperature (°C)',
                        textStyle: TextStyle(fontSize: 12)),
                    opposedPosition: false, // Côté gauche
                    minimum: 0,
                    maximum: 120, // Ajustez la plage si nécessaire
                    interval: 20,
                  ),
                  // Axe pour l'humidité
                  NumericAxis(
                    name: 'Humidity',
                    title: AxisTitle(
                        text: 'Humidity (%RH)',
                        textStyle: TextStyle(fontSize: 12)),
                    opposedPosition: true, // Côté droit
                    minimum: 0,
                    maximum: 120,
                    interval: 20,
                  ),
                ],
                legend: Legend(
                  isVisible: true, // Activer la légende
                  position: LegendPosition.top, // Position de la légende
                ),
                series: <CartesianSeries>[
                  // Série pour la température
                  ColumnSeries<ChartData, String>(
                    dataSource: chartDataFromMachines(
                        machines), // Utiliser les données des machines
                    xValueMapper: (ChartData data, _) =>
                        data.time, // Titre de la machine
                    yValueMapper: (ChartData data, _) =>
                        data.temperature, // Température
                    yAxisName:
                        'Temperature', // Associer à l'axe Y de température
                    name: 'Temperature',
                    color: Colors.red, // Couleur de la série
                  ),
                  // Série pour l'humidité
                  ColumnSeries<ChartData, String>(
                    dataSource: chartDataFromMachines(
                        machines), // Utiliser les données des machines
                    xValueMapper: (ChartData data, _) =>
                        data.time, // Titre de la machine
                    yValueMapper: (ChartData data, _) =>
                        data.humidity, // Humidité
                    yAxisName: 'Humidity', // Associer à l'axe Y de l'humidité
                    name: 'Humidity',
                    color: Colors.blueAccent, // Couleur de la série
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.time, this.temperature, this.humidity);
  final String time;
  final double temperature;
  final double humidity;
}
