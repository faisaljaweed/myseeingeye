import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class ChooseAppPage extends StatelessWidget {
  const ChooseAppPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose an App'),
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
                    leading: app is ApplicationWithIcon
                        ? Image.memory(app.icon)
                        : const Icon(Icons.error_outline), // Placeholder icon
                    onTap: () => DeviceApps.openApp(app.packageName),
                  );
                },
              );
            } else {
              return const Center(child: Text("No apps available"));
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
