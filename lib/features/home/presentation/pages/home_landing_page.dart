import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sangam/features/socialfeed/presentation/pages/social_feed_page.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.feed),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SocialFeedPageClean()),
            ),
          ),
        ],
      ),
    );
  }
}
