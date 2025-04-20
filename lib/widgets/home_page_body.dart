import 'package:factoryio_app/topics_enums.dart';
import 'package:factoryio_app/widgets/box_count.dart';
import 'package:factoryio_app/widgets/mqtt_button.dart';
import 'package:flutter/material.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  List<Widget> getBody(BuildContext context, double aspectRatio) {
    return [
      Expanded(
        flex: 1,
        child: SafeArea(
          child: GridView.count(
            crossAxisCount: 1,
            childAspectRatio: aspectRatio - 0.05,

            children: [
              BoxCount(
                color: Theme.of(context).colorScheme.onInverseSurface,
                textColor: Theme.of(context).colorScheme.inverseSurface,
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: SafeArea(
          child: GridView.count(
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            crossAxisCount: 3,
            childAspectRatio: aspectRatio,
            padding: const EdgeInsets.all(16),
            children: [
              for (int i = 0; i < Topics.values.length - 3; i++)
                MqttButton(
                  topic: Topics.values[i].name,
                  label: Topics.values[i].description,
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return isPortrait
        ? Column(spacing: 12, children: getBody(context, 1.2))
        : Row(children: getBody(context, 1.4));
  }
}
