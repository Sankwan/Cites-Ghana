// import 'dart:convert';
// import 'dart:io';
import 'package:cites/animation/fadeanimate.dart';
import 'package:cites/animation/slideanimate.dart';
import 'package:cites/screens/profile_page.dart';
import 'package:cites/utils/users.api.dart';
import 'package:cites/widgets/pagesnavigator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


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
      print(code);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return DisplayPage(data: code as String);
      }));
    });
  }
}

//another page for display after scan is done
class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key, required this.data}) : super(key: key);
  final String data;

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  bool isLoading = true;

  int? id;

  @override
  Widget build(BuildContext context) {
    // fetch(widget.data);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Scan Results'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  nextScreen(context, SlideAnimate(const ProfilePage()));
                },
                icon: const Icon(Icons.person))
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Map>(
            future: fetchUsers(widget.data),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                Map data = snapshot.data as Map;
                Map cites = data['data'];
                List extra = cites['extra'];

                return ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/citeslogo.jpg',
                          height: 110,
                          width: 120,
                        ),
                        const Text.rich(TextSpan(
                          text:
                              'CONVENTION \n INTERNATIONAL TRADE IN \nENDANGERED SPECIES OF \nWILD FAUNA AND FLORA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 10,
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Card(
                      shadowColor: Colors.green,
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Export Type : ${cites['export_type_id']}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Importer Name : ${cites['importer_name']}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Importer Address : ${cites['importer_address']}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Exporter Name : ${cites['exporter_name']}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Exporter Address : ${cites['exporter_address']}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Country of Import : ${cites['export_country']}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Permit Number : ${cites['permit_no']}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(columns: const [
                        DataColumn(label: Text('Scientific Name')),
                        DataColumn(label: Text('Cites Appendix')),
                        DataColumn(label: Text('Quantity')),
                        DataColumn(label: Text('Specie Description')),
                      ], rows: [
                        for (var x in extra)
                          DataRow(cells: [
                            DataCell(Text(x['scientific_name'])),
                            DataCell(Text(x['cites_appendix'])),
                            DataCell(Text(x['quantity'])),
                            DataCell(Text(x['specie_description'])),
                          ]),
                      ]),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/coatofarms.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const Center(
                      child: Text('Wildlife Division',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    const Center(
                      child: Text('(Forestry Commission)'),
                    ),
                    const Center(
                      child: Text('P.O.Box M.239'),
                    ),
                    const Center(
                      child: Text('Accra'),
                    ),
                    const Center(
                      child: Text('Ghana, West Africa'),
                    ),
                    const Center(
                      child: Text('Tel 233-21-664654,662360'),
                    ),
                    const Center(
                      child: Text('Fax 233-21-666476'),
                    ),
                    const Center(
                      child: Text('E-mail: wildlife@cs.com.gh'),
                    ),
                  ],
                );
              }
              if (snapshot.hasError) {
                debugPrint('ERROR ' + snapshot.error.toString());
                return Text(snapshot.error.toString());
              }
              return const Center(
                child: Text('No data found'),
              );
            },
          ),
        ));
  }
}
