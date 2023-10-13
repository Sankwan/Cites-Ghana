import 'package:flutter/material.dart';
//with animation
void nextScreen(BuildContext ctx, Route route) {
  Navigator.of(ctx).push(route);
}

void nextScreenClosePrev(BuildContext ctx, Route route) {
  Navigator.of(ctx).pushReplacement(route);
}

void closeUI(BuildContext context) {
  Navigator.pop(context);
}

void nextscreenRemovePredicate(BuildContext context, Route route) {
  Navigator.pushAndRemoveUntil(
    context,
    route,
    (Route<dynamic> route) => false,
  );
}


//with no animation

nextNav(BuildContext context, intent) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) => intent),
    ),
  );
}

nextNavRemoveHistory(BuildContext context, intent) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => intent),
    (route) => false,
  );
}

prevNav(BuildContext context) {
  Navigator.pop(context);
}

// snackBar(BuildContext context, String text) {
//   return ScaffoldMessenger.of(context)
//       .showSnackBar(SnackBar(content: Text(text)));
// }

// var logger = Logger();

