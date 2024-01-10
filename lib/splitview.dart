import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:split_view/split_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SplitScreenPage extends StatefulWidget {
  @override
  _SplitScreenPageState createState() => _SplitScreenPageState();
}

class _SplitScreenPageState extends State<SplitScreenPage> {
  late CameraController _cameraController;
  late GoogleMapController _mapController;
  late List<CameraDescription> cameras;
  late CameraDescription firstCamera;
  bool showCamera = true; // Indicates whether to show the camera or map

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    firstCamera = cameras.first;
    _cameraController = CameraController(firstCamera, ResolutionPreset.medium);
    await _cameraController.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplitView(
        viewMode: SplitViewMode.Vertical, // Split screen horizontally
        children: [
          showCamera
              ? (_cameraController.value.isInitialized
                  ? CameraPreview(_cameraController)
                  : Container())
              //Camera view
              : GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(0, 0), // Set the initial position
                    zoom: 10.0,
                  ),
                ), // Google Maps view
          Center(
            child: WebView(
              initialUrl:
                  'https://www.google.com/maps', // Replace with your URL
              javascriptMode: JavascriptMode.unrestricted,
            ),
            // child: FutureBuilder<List<Application>>(
            //   future: DeviceApps.getInstalledApplications(
            //     includeSystemApps: false,
            //     onlyAppsWithLaunchIntent: true,
            //   ),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       if (snapshot.data != null) {
            //         List<Application> apps = snapshot.data!;
            //         return ListView.builder(
            //           itemCount: apps.length,
            //           itemBuilder: (context, index) {
            //             Application app = apps[index];
            //             return ListTile(
            //               title: Text(app.appName),
            //               leading:
            //                   app is ApplicationWithIcon && app.icon != null
            //                       ? Image.memory(app.icon!)
            //                       : null,
            //               onTap: () => DeviceApps.openApp(app.packageName),
            //             );
            //           },
            //         );
            //       } else {
            //         return Center(child: Text("No apps available"));
            //       }
            //     }
            //     return Center(child: CircularProgressIndicator());
            //   },
            // ), // Placeholder for other view
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showCamera = !showCamera;
          });
        },
        child: Icon(Icons.switch_camera), // Change icon as needed
      ),
    );
  }
}
