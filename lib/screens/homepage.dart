import 'package:cites/screens/scanner.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFffffff),
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 300,
            ),
            const Center(
                child: Text(
              'Tap the button below to Scan',
              style: TextStyle(fontSize: 20),
            )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 160, right: 160),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Scanner()));
                  },
                  icon: const Icon(
                    Icons.qr_code_scanner,
                    size: 60,
                  )),
            ),
            const SizedBox(height: 50),
            Center(
              child: Container(
  height: 50.0,
  width: 250.0,
  child: Material(
    borderRadius: BorderRadius.circular(30.0),
    shadowColor: Colors.greenAccent,
    color: Colors.green,
    elevation: 10.0,
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const Scanner()));
      },
      splashColor: Colors.brown.shade400, // Change this color to the one you want
      child: const Center(
        child: Text(
          'SCAN QR-CODE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    ),
  ),
)

            ),
            const SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/citeslogo.jpg',
                  height: 100,
                  width: 100,
                ),
                // SizedBox(width: 50,),
                Image.asset(
                  'assets/images/forestry.png',
                  height: 120,
                  width: 120,
                ),
              ],
            )
          ],
        ));
  }
}

Future get() async {
  // Open a connection
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: '10.5.17.18',
      port: 3306,
      user: 'cecil',
      db: 'cites',
      password: 'Lazor271980'));

  debugPrint(conn.toString());
  //
  // // Insert some data
  // var result = await conn.query(
  //     'insert into users (name, email, age) values (?, ?, ?)',
  //     ['Bob', 'bob@bob.com', 25]);
  // debugPrint('Inserted row id=${result.insertId}');
  //
  // // Query the database using a parameterized query
  // var results = await conn.query(
  //     'select * from users');
  //     // 'select name, email, age from users where id = ?', [result.insertId]);
  // for (var row in results) {
  //   debugPrint('Name: ${row[0]}, email: ${row[1]} age: ${row[2]}');
  // }

  // Update some data
  // await conn.query('update users set age=? where name=?', [26, 'Bob']);
  //
  // // Query again database using a parameterized query
  // var results2 = await conn.query(
  //     'select name, email, age from users where id = ?', [result.insertId]);
  // for (var row in results2) {
  //   debugPrint('Name: ${row[0]}, email: ${row[1]} age: ${row[2]}');
  // }

  // Finally, close the connection
  await conn.close();
}
