import 'package:flutter/material.dart';
import 'package:my_seeing_eye/camera.dart';
import 'package:my_seeing_eye/splitview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool isCameraOpened = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
          backgroundColor: const Color(0xff00061c),
          body: Stack(
            children: [
              Column(children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, top: 80),
                      child: Image.asset("images/My-Seeing-Eye-Icon-Logo.png"),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.03,
                    ),
                    GestureDetector(
                      onTap: _openCamera,
                      child: Column(children: [
                        Image.asset("images/Open-Camera.png"),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        const Text(
                          "on Camera",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.2,
                    ),
                    GestureDetector(
                      onTap:
                      () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) =>SplitScreenPage()));
                      },
                      child: Column(children: [
                        Image.asset("images/Get-Direction.png"),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        const Text(
                          "Get Direction",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: screenSize.height * 0.43,
                      width: screenSize.width * 1,
                      child: Image.asset(
                        "images/my-seen-eye-image.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      child: Row(
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.19,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Column(children: [
                              Image.asset("images/How-to-Get-Directions.png"),
                              SizedBox(
                                height: screenSize.height * 0.02,
                              ),
                              const Text(
                                "How to Get\nDirections",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ]),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.2,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ChooseAppPage()));
                            },
                            child: Column(children: [
                              Image.asset("images/Choose-Application.png"),
                              SizedBox(
                                height: screenSize.height * 0.02,
                              ),
                              const Text(
                                "Chosse App\n",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ]),
            ],
          )),
    );
  }

  void _openMap() async {
    // Replace 'your_map_url_here' with the actual map URL you want to open
    final mapUrl = 'https://www.google.com/maps';
    try {
      if (await canLaunch(mapUrl)) {
        await launch(mapUrl);
      } else {
        throw 'Could not launch $mapUrl';
      }
    } catch (e) {
      print('Error launching map: $e');
    }
  }

  void _openCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // Do something with the image
      // pickedImage.path will give you the image path
      // You can display it or perform any operation you need
    }
  }
}
