import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottompopUpNavigation extends StatelessWidget {
  const BottompopUpNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                child: Center(
                  child: SvgPicture.asset(
                    width: 20,
                    'assets/bt.svg',
                    colorFilter:
                        const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                    semanticsLabel: 'A red up arrow',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Know More'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Connect with Cellular|WIFI'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Proceed'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
