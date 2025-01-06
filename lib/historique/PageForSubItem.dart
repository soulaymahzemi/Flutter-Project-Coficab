import 'package:coficabproject/colors/colors.dart';
import 'package:flutter/material.dart';

class PageForSubItem extends StatefulWidget {
  final String title;

  PageForSubItem({required this.title});

  @override
  State<PageForSubItem> createState() => _PageForSubItemState();
}

class _PageForSubItemState extends State<PageForSubItem> {
  final List<Map<String, dynamic>> data = [
    {
      "date": "2025-01-01 10:00",
      "temperature": 22.5,
      "humidity": 55,
      "alert": ""
    },
    {
      "date": "2025-01-01 12:00",
      "temperature": 25.0,
      "humidity": 60,
      "alert": ""
    },
    {
      "date": "2025-01-01 14:00",
      "temperature": 23.0,
      "humidity": 50,
      "alert": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: navbar,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
              ),
              DataTable(
                columnSpacing: 16.0,
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.blueGrey.shade100,
                ),
                dataRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.white,
                ),
                border: TableBorder.all(
                  color: Colors.blueGrey.shade200,
                  width: 1,
                  borderRadius: BorderRadius.circular(8),
                ),
                columns: const [
                  DataColumn(
                    label: Text(
                      'Date/Heure',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Température (°C)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Humidité (%)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Alerte',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
                rows: data.map((entry) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          entry["date"].toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      DataCell(
                        Text(
                          entry["temperature"].toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      DataCell(
                        Text(
                          entry["humidity"].toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      DataCell(
                        Text(
                          entry["alert"].toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
