import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HistoricalDataPage(),
    );
  }
}

class HistoricalDataPage extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {
      "date": "2025-01-01 10:00",
      "temperature": 22.5,
      "humidity": 55,
      "alert": "Normal"
    },
    {
      "date": "2025-01-01 12:00",
      "temperature": 25.0,
      "humidity": 60,
      "alert": "High Temp"
    },
    {
      "date": "2025-01-01 14:00",
      "temperature": 23.0,
      "humidity": 50,
      "alert": "Normal"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page Historique"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Date/Heure')),
              DataColumn(label: Text('Température (°C)')),
              DataColumn(label: Text('Humidité (%)')),
              DataColumn(label: Text('Alerte')),
            ],
            rows: data.map((entry) {
              return DataRow(cells: [
                DataCell(Text(entry["date"].toString())),
                DataCell(Text(entry["temperature"].toString())),
                DataCell(Text(entry["humidity"].toString())),
                DataCell(Text(entry["alert"].toString())),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
