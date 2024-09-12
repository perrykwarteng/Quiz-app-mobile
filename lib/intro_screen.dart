import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          _buildPage(
            context,
            'Welcome to ATU Quiz App',
            'This is the best app for university students to test their knowledge.',
          ),
          _buildPage(
            context,
            'Track Your Progress',
            'Keep track of your quiz scores and improve over time.',
          ),
          _buildPage(
            context,
            'Get Started',
            'Let\'s get started by logging in or registering!',
            showButton: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context, String title, String description,
      {bool showButton = false}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xFFF5F5F5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF26436c),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF26436c),
            ),
            textAlign: TextAlign.center,
          ),
          if (showButton) ...[
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/auth');
              },
              child: const Text('Get Started'),
            ),
          ],
        ],
      ),
    );
  }
}
