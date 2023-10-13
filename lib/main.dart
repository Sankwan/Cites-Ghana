import 'package:bot_toast/bot_toast.dart';
import 'package:cites/authentication/login.dart';
import 'package:cites/authentication/signup.dart';
import 'package:cites/screens/homepage.dart';
import 'package:cites/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isUserExist(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              title: 'Cites',
              theme: ThemeData(
                primarySwatch: Colors.green,
                // useMaterial3: true,
              ),
              routes: <String, WidgetBuilder>{
                '/signup': (BuildContext context) => const SignupPage()
              },
              // home: const LoginPage(),
              home: snapshot.data! ? MyHomePage(): SplashPage(),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

Future<bool> isUserExist() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  // prefs.remove("email");
  if (email != null) {
    return true;
  } else {
    return false;
  }
}
