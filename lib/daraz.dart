import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:split_view/split_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Daraz extends StatefulWidget {
  const Daraz({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _DarazState createState() => _DarazState();
}

class _DarazState extends State<Daraz> {
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
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0), // Set the initial position
                    zoom: 10.0,
                  ),
                ), // Google Maps view
          const Center(
            child: WebView(
              initialUrl:
                  'https://www.amazon.com/?&tag=googleglobalp-20&ref=pd_sl_7nnedyywlk_e&adgrpid=159651196451&hvpone=&hvptwo=&hvadid=675114638367&hvpos=&hvnetw=g&hvrand=11741476808970746372&hvqmt=e&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9077144&hvtargid=kwd-10573980&hydadcr=2246_13468515', // Replace with your URL
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showCamera = !showCamera;
          });
        },
        child: const Icon(Icons.switch_camera), // Change icon as needed
      ),
    );
  }
}
