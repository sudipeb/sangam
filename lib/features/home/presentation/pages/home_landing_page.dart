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
            tooltip: 'Social Feed',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SocialFeedPageClean()),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Sangam',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.feed, color: Colors.blue),
                      title: const Text('Social Feed'),
                      subtitle: const Text(
                        'View and browse all posts with infinite scroll',
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SocialFeedPageClean(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
