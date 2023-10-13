import 'package:cites/widgets/pagesnavigator.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/login.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      title: "Welcome to Cites ",
      bodyWidget: const Text('Welcome to the Convention on International Trade in Endangered Species of Wild Fauna and Flora (CITES). Our mission is to ensure that international trade in wildlife does not endanger the survival of species. Join us in our efforts to protect the world\'s precious biodiversity.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
      image: Center(child: Image.asset('assets/images/onboarding1.png')),
    ),
    PageViewModel(
      title: "Our Commitment to Conservation",
      bodyWidget: const Text(
          'CITES works tirelessly to combat the illegal trade in endangered species and promote sustainable trade that benefits both wildlife and people. ', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
      image: Center(child: Image.asset('assets/images/onboarding2.png')),
    ),
    PageViewModel(
      title: "Get Involved",
      bodyWidget: const Text('By using this app, you\'re becoming a part of the CITES community. Together, we can make a difference and ensure a future where wildlife thrives.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
      image: Center(child: Image.asset('assets/images/onboarding3.png')),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 10,
        backgroundColor: Colors.grey.shade50,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: IntroductionScreen(
        pages: listPagesViewModel,
        showSkipButton: true,
        showNextButton: true,
        showDoneButton: true,
        skip: const Text("Skip"),
        done: const Text("Done"),
        next: const Icon(Icons.arrow_forward_ios_rounded),
        onDone: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('intro', false);
          nextNavRemoveHistory(context, LoginPage());
        },
      ),
    );
  }
}
