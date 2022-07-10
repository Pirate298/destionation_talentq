// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';

import '../routing.dart';
import 'scaffold_body.dart';

class DictionnaryScaffold extends StatelessWidget {
  const DictionnaryScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: const DictionaryScaffoldBody(),
        onDestinationSelected: (idx) {
          if (idx == 0) routeState.go('/search/destination');
          if (idx == 1) routeState.go('/history');
          if (idx == 2) routeState.go('/settings');
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Search',
            icon: Icons.search,
          ),
          AdaptiveScaffoldDestination(
            title: 'History',
            icon: Icons.history_edu,
          ),
          AdaptiveScaffoldDestination(
            title: 'Settings',
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    if (pathTemplate.startsWith('/search')) return 0;
    if (pathTemplate == '/history') return 1;
    if (pathTemplate == '/settings') return 2;
    return 0;
  }
}
