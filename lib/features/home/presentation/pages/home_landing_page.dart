import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeLandingPage extends StatelessWidget {
  const HomeLandingPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Sangam",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
    );
  }
}
