import 'package:coficabproject/dashbord/PageAcceuil.dart';
import 'package:coficabproject/historique/PageForSubItem.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isHistoryExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Fixed DrawerHeader with explicit height
          Container(
            width: double.infinity,
            height: 220, // Fixe la hauteur du DrawerHeader
            decoration: BoxDecoration(
              color: navbar,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle_outlined,
                  size: 100,
                  color: const Color.fromARGB(255, 7, 7, 7),
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.dashboard, color: Colors.black),
                    title: Text(
                      'Dashbord',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageAcceuil()));
                    },
                  ),
                  _buildCustomDivider(),
                  ListTile(
                    leading:
                        Icon(Icons.notification_important, color: Colors.black),
                    title: Text('Notification',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                  _buildCustomDivider(),

                  // History section with expansion
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: Icon(Icons.history_edu_outlined,
                                  color: Colors.black),
                              title: Text('Historique ',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black)),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                                isHistoryExpanded
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: Colors.black),
                            onPressed: () {
                              setState(() {
                                isHistoryExpanded = !isHistoryExpanded;
                              });
                            },
                          ),
                        ],
                      ),
                      _buildCustomDivider(),
                      if (isHistoryExpanded)
                        Container(
                          width: 280,
                          child: Column(
                            children: [
                              _buildHistoryItem('usine1', []),
                              _buildHistoryItem(
                                  'usine2', ['BUNKER', 'STAR', 'Amb-US2']),
                              _buildHistoryItem('usine3', ['Mg-US3']),
                              _buildHistoryItem('Extérieur', ['station1']),
                            ],
                          ),
                        ),
                    ],
                  ),

                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.black),
                    title: Text('Déconnexion',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                  _buildCustomDivider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 173, 169, 169).withOpacity(0.1),
            const Color.fromARGB(255, 193, 181, 181).withOpacity(0.5),
            const Color.fromARGB(255, 139, 131, 131).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 234, 232, 232)
                .withOpacity(0.3), // Shadow color
            blurRadius: 6, // Softness of the shadow
            spreadRadius: 2, // How far the shadow spreads
            offset: Offset(0, 2), // Shadow position (x, y)
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, List<String> subItems) {
    return ExpansionTile(
      leading: Icon(Icons.factory, color: Colors.black),
      title: Text(title, style: TextStyle(fontSize: 20, color: Colors.black)),
      children: subItems.map((subItem) {
        return ListTile(
          title: Text(subItem, style: TextStyle(fontSize: 18)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageForSubItem(title: subItem),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
