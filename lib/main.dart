import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

void main() async {
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PB Launcher',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Application> apps = List<Application>();

  @override
  void initState() {
    getApps();
    super.initState();
  }

  void getApps() async {
    apps = await DeviceApps.getInstalledApplications(includeAppIcons: true, includeSystemApps: true, onlyAppsWithLaunchIntent: true);
    setState(() {
      apps=apps;
    });
  }

  Widget _buildAppItems(BuildContext context, int index) {
    ApplicationWithIcon app = apps[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: CircleAvatar(backgroundColor: Colors.black,child: Image.memory(app.icon),),
      title: Text(app.appName),
      onTap: () => DeviceApps.openApp(app.packageName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: apps.length,
          itemBuilder: _buildAppItems,
        )
      ),
    );
  }
}
