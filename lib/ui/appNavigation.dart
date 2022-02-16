import 'package:flutter/material.dart';

import 'settings/settings.dart';

/// This is the stateful widget that the main application instantiates.
class AppNavigation extends StatefulWidget {
  const AppNavigation({Key? key}) : super(key: key);

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _AppNavigationState extends State<AppNavigation> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomSettingsScreen(),
      ),
    );
  }
}
