import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/login.dart';
import '../widgets/pagesnavigator.dart';
import 'onboarding_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  Future afterSplash() async {
    // mAuth.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('intro')) {
      await prefs.setBool('intro', true);
    }
    final bool? intro = prefs.getBool('intro');
    Future.delayed(const Duration(seconds: 1)).then((value) async {
        nextNav(context,
            (intro! ? const OnBoardingScreen() : const LoginPage()));
      });
  }

  @override
  void initState() {
    afterSplash();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 300,
            ),
            Container(
                alignment: Alignment.center,
                child:
                    const Text('CITES APP')),
            const SizedBox(height: 50),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/citeslogo.jpg'),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 16),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 10,
                children: const [
                  CircularProgressIndicator()
                  // SplashLoader(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
