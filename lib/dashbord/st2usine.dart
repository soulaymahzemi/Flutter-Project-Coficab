import 'package:coficabproject/appbar/appbar.dart';
import 'package:coficabproject/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Card2 extends StatefulWidget {
  @override
  State<Card2> createState() => _Card2State();
}

class _Card2State extends State<Card2> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
      title:
       Center(
        child: Text(
          'St-2:STAR',
          style: TextStyle(
            fontSize: 20,
          ),
        textAlign: TextAlign.center,
        ),
        ) ,
        
        ),
         body: Container(
       color: Color.fromARGB(255, 250, 246, 246),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(  // Utiliser Expanded ici pour permettre aux cartes de se redimensionner
                    child:
                     Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 25),  // Marge réduite
                      child: Container(
                        height: 180,
                           decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(13.0)),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFE4956),
                                    Color(0xFFF9B1B8),
                                  ],
                                  begin: Alignment.bottomCenter,
                                ),
                              ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.thermostat,
                              size: 40,
                              color: Colors.redAccent,
                            ),
                            
          
                            SizedBox(height: 5),
                            Text(
                              '25°C',
                              style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold ,color: Color.fromARGB(255, 255, 254, 254)),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Real Time:20.00',
                              style: TextStyle(fontSize: 16, color:  Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Espace entre les cartes
                  Expanded(  // Utiliser Expanded ici pour permettre aux cartes de se redimensionner
                    child: Card(
                      elevation: 4,
                     
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),  // Marge réduite
                      child: Container(
                        height: 180,
                         decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(13.0)),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFE4956),
                                    Color(0xFFF9B1B8),
                                  ],
                                  begin: Alignment.bottomCenter,
                                ),
                              ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.water_drop,
                              size: 40,
                              color: Colors.blueAccent,
                            ),
                            
                            SizedBox(height: 5),
                            Text(
                              '60% RH',
                              style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Real Time:21:00',
                              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      // TabBar
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.redAccent,
                        tabs: [
                          Tab(text: 'Température'),
                          Tab(text: 'Humidité'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Graphique pour la température
                            SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              title: ChartTitle(text: 'Température (°C)'),
                               primaryYAxis: NumericAxis(
                                minimum: 0,
                                maximum: 120,
                                interval: 20,
                              ),
                              series: <CartesianSeries<dynamic, dynamic>>[ 
                                SplineAreaSeries<ChartData, String>(
                                  dataSource: [
                                    ChartData('10:00', 25),
                                    ChartData('11:00', 27),
                                    ChartData('12:00', 28),
                                    ChartData('13:00', 26),
                                  ],
                                  xValueMapper: (ChartData data, _) => data.time,
                                  yValueMapper: (ChartData data, _) => data.value,
                                  color: Colors.redAccent,
                                    splineType: SplineType.monotonic, // Smooth curve
                                  borderColor: Colors.red, // Dark contour
                                  borderWidth: 2,
                                    gradient: LinearGradient(
                                    colors: [Colors.red.withOpacity(0.3), Colors.red.withOpacity(0)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                )
                              ],
                            ),
                            // Graphique pour l'humidité
                            SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              title: ChartTitle(text: 'Humidité (%)'),
                               primaryYAxis: NumericAxis(
                                minimum: 0,
                                maximum: 120,
                                interval: 20,
                              ),
                              series: <CartesianSeries>[ 
                                SplineAreaSeries<ChartData, String>(
                                  dataSource: [
                                    ChartData('10:00', 60),
                                    ChartData('11:00', 63),
                                    ChartData('12:00', 65),
                                    ChartData('13:00', 62),
                                  ],
                                  xValueMapper: (ChartData data, _) => data.time,
                                  yValueMapper: (ChartData data, _) => data.value,
                                  color: Colors.blueAccent,
                                                      splineType: SplineType.monotonic,

                                  borderColor: Colors.blueAccent,
                                    borderWidth: 2,
                                    gradient: LinearGradient(
                                      colors: [Colors.blue.withOpacity(0.3), Colors.blue.withOpacity(0)],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Classe pour représenter les données
class ChartData {
  final String time;
  final double value;

  ChartData(this.time, this.value);
}
