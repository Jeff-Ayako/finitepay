import 'package:flutter/material.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinitePay Documentation'),
        backgroundColor: Colors.blueGrey,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Getting Started',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to our API documentation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'FinitePay offers a contemporary financial infrastructure designed for businesses and developers, '
              'enabling them to facilitate local and international payouts, gather payments from customers, '
              'and create virtual accounts.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Get Started',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Regardless of whether you are a startup or a global enterprise, discover the seamless integration process '
              'with FinitePay! Most teams are up and running in just 30 minutes, experiencing the full benefits of our platform.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionCard(
              title: 'Payins',
              description:
                  'Learn how to receive fast and secure payments with FinitePay.',
            ),
            SectionCard(
              title: 'Payouts',
              description:
                  'Learn how to make local and international payouts in different currencies.',
            ),
            SectionCard(
              title: 'Virtual Accounts',
              description:
                  'Create local and international bank accounts in different currencies.',
            ),
            SectionCard(
              title: 'Identity Management',
              description:
                  'Learn how to use FinitePay to verify your customer\'s identity.',
            ),
          ],
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final String description;

  const SectionCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}