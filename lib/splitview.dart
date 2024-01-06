import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SplitScreenPage extends StatefulWidget {
  @override
  _SplitScreenPageState createState() => _SplitScreenPageState();
}

class _SplitScreenPageState extends State<SplitScreenPage> {
  late CameraController _cameraController;
  late GoogleMapController _mapController;
  late List<CameraDescription> cameras;
  late CameraDescription firstCamera;

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
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: _cameraController.value.isInitialized
                ? CameraPreview(_cameraController)
                : Container(), // Camera view
          ),
          Expanded(
            flex: 1,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0), // Set the initial position
                zoom: 10.0,
              ),
            ), // Google Maps view
          ),
        ],
      ),
    );
  }
}

