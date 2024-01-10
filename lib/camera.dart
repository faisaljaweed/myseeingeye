import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class ChooseAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose an App'),
      ),
      body: FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(
          includeSystemApps: false,
          onlyAppsWithLaunchIntent: true,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Application> apps = snapshot.data!;
              return ListView.builder(
                itemCount: apps.length,
                itemBuilder: (context, index) {
                  Application app = apps[index];
                  return ListTile(
                    title: Text(app.appName),
                    leading: app is ApplicationWithIcon && app.icon != null
                        ? Image.memory(app.icon!)
                        : Icon(Icons.error_outline), // Placeholder icon
                    onTap: () => DeviceApps.openApp(app.packageName),
                  );
                },
              );
            } else {
              return Center(child: Text("No apps available"));
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
