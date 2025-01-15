import 'package:flutter/material.dart';
import 'package:world_flags/world_flags.dart';

class BalancesPage extends StatefulWidget {
  const BalancesPage({super.key});

  @override
  State<BalancesPage> createState() => _BalancesPageState();
}

class _BalancesPageState extends State<BalancesPage> {
  static const size = kMinInteractiveDimension / 2;
  static const countries = WorldCountry.list;

  final _aspectRatio = ValueNotifier(FlagConstants.defaultAspectRatio);

  @override
  void dispose() {
    _aspectRatio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          minimum: const EdgeInsets.all(size / 2),
          child: ValueListenableBuilder(
            valueListenable: _aspectRatio,
            builder: (_, aspectRatio, __) => Scaffold(
              body: ListView.builder(
                itemBuilder: (_, i) => ListTile(
                  title: Text(countries[i].internationalName),
                  // subtitle: CountryFlag.simplified(
                  //   countries[i],
                  //   height: size,
                  //   aspectRatio: aspectRatio,
                  // ),
                  trailing: CountryFlag.simplified(
                    countries[i],
                    height: size,
                    aspectRatio: aspectRatio,
                  ),
                ),
                itemCount: countries.length,
              ),
              bottomNavigationBar: SizedBox(
                height: size * 2,
                child: Slider(
                  value: aspectRatio,
                  onChanged: (newRatio) => _aspectRatio.value = newRatio,
                  min: FlagConstants.minAspectRatio,
                  max: FlagConstants.maxAspectRatio,
                ),
              ),
            ),
          ),
        ),
      );
}
