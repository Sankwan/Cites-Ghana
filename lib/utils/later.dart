// import 'dart:convert';
// import 'dart:io';
import 'dart:convert';

import 'package:cites/utils/users.api.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;


class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Align the QR Code to Scan"),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: Center(
                  child: Text('Scan a code'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();

      var code = scanData.code;
      logger.d(code);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return DisplayPage(data: code as String, email: '',);
      }));
    });
  }
}


//this page for display after scan is done

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key, required this.email, required String data}) : super(key: key);
  final String email;

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  bool isLoading = true;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('http://fciis2.fcghana.org/cites/v1/users/retrieve.php'),
        body: {'email': widget.email},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'] == true) {
          setState(() {
            userData = jsonData['data'];
          });
        } else {
          // Handle the case when the user profile is not found
          setState(() {
            userData = null;
          });
        }
      } else {
        // Handle HTTP error
        setState(() {
          userData = null;
        });
      }
    } catch (error) {
      // Handle other errors
      setState(() {
        userData = null;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Results'),
        actions: [
          IconButton(
            onPressed: () {
              // if (userData != null) {
              //   nextScreen(
              //     context,
              //     SlideAnimate(
              //       ProfilePage(userData: userData!),                    
              //     ),
              //   );
              // }
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: isLoading
      //       ? const Center(child: CircularProgressIndicator())
      //       : userData != null
      //           ? DisplayUserData(userData: userData!)
      //           : const Center(child: Text('No data found')),
      // ),
    );
  }
}

// class DisplayUserData extends StatelessWidget {
//   final Map<String, dynamic> userData;

//   const DisplayUserData({Key? key, required this.userData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       // Your code for displaying user data goes here
//       // Example: Text(userData['fullName'])
//     );
//   }
// }


