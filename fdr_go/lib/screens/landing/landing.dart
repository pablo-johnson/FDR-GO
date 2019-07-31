import 'package:fdr_go/data/bus_service.dart';
import 'package:fdr_go/data/notification_menu.dart';
import 'package:fdr_go/data/responses/login_response.dart';
import 'package:fdr_go/screens/asa/services/asa_services.dart';
import 'package:fdr_go/screens/bus/services/bus_services.dart';
import 'package:fdr_go/services/bus_service_services.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

class LandingPage extends StatefulWidget {
  final LoginResponse loginResponse;

  const LandingPage({this.loginResponse});

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const int BUS_SERVICE = 0;
  static const int ASA_SERVICE = 1;

  var _selectedIndex = BUS_SERVICE;
  bool _loading = false;
  List<String> goSteps = ["Paradero", "En Camino", "Colegio"];
  List<String> returnSteps = ["Colegio", "En Camino", "Paradero"];
  List<BusService> services;
  String _title = "Servicio de bus";

  NotificationMenu notificationMenu;

  @override
  void initState() {
    super.initState();
    if (widget.loginResponse != null) {
      services = widget.loginResponse.services;
    }
  }

  @override
  Widget build(BuildContext context) {
    notificationMenu = new NotificationMenu();
    notificationMenu.notifications = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarySwatch['red'],
        title: Text(_title),
      ),
      drawer: new MenuWidget(
        notificationMenu: notificationMenu,
      ),
      backgroundColor: primarySwatch['blue'],
      body: _selectedIndex == BUS_SERVICE
          ? new BusServicesPage(services: services)
          : new AsaServicesPage(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_bus),
          title: Text('BUS'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          title: Text('ASA'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: primarySwatch['red'],
      unselectedItemColor: Colors.black,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedIndex == BUS_SERVICE
          ? _title = "Servicio de Bus"
          : _title = "Actividades ASA";
    });
  }

  Future<void> _refreshData(bool showLoading) {
    if (showLoading) {
      setState(() {
        _loading = true;
      });
    }
    getBusServices().then((servicesResponse) {
      services = servicesResponse.services;
      setState(() {
        _loading = false;
      });
    });
    return null;
  }
}
