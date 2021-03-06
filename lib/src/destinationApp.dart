// import 'dart:html';

import 'package:flutter/material.dart';
import 'screens/navigator.dart';

import 'routing.dart';

class Dictionnary extends StatefulWidget {
  const Dictionnary({super.key});
  @override
  State<Dictionnary> createState() => _DictionnaryState();
}

class _DictionnaryState extends State<Dictionnary> {
  // final _auth = BookstoreAuth();
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final RouteState _routeState;
  late final SimpleRouterDelegate _routerDelegate;
  late final TemplateRouteParser _routeParser;

  @override
  void initState() {
    /// Configure the parser with all of the app's allowed path templates.
    _routeParser = TemplateRouteParser(
      allowedPaths: [
        '/search',
        '/history',
        '/settings',
        '/search/destination',
        '/search/google',
        '/search/dictionnary',
      ],
      guard: _guard,
      initialRoute: '/search',
    );

    _routeState = RouteState(_routeParser);

    _routerDelegate = SimpleRouterDelegate(
      routeState: _routeState,
      navigatorKey: _navigatorKey,
      builder: (context) => DictionaryNavigator(
        navigatorKey: _navigatorKey,
      ),
    );

    // Listen for when the user logs out and display the signin screen.
    //_auth.addListener(_handleAuthStateChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) => RouteStateScope(
        notifier: _routeState,
        // child: BookstoreAuthScope(
        //  notifier: _auth,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: _routerDelegate,
          routeInformationParser: _routeParser,
          // Revert back to pre-Flutter-2.5 transition behavior:
          // https://github.com/flutter/flutter/issues/82053
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                // TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
                // TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                // TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
              },
            ),
          ),
        ),
        // ),
      );

  Future<ParsedRoute> _guard(ParsedRoute from) async {
    print('_guard');
    // final signedIn = _auth.signedIn;
    // final signInRoute = ParsedRoute('/signin', '/signin', {}, {});

    // // Go to /signin if the user is not signed in
    // if (!signedIn && from != signInRoute) {
    //   return signInRoute;
    // }
    // // Go to /books if the user is signed in and tries to go to /signin.
    // else if (signedIn && from == signInRoute) {
    //   return ParsedRoute('/books/popular', '/books/popular', {}, {});
    // }
    return from;
  }

  void _handleAuthStateChanged() {
    // if (!_auth.signedIn) {
    //   _routeState.go('/signin');
    // }
  }

  @override
  void dispose() {
    // _auth.removeListener(_handleAuthStateChanged);
    _routeState.dispose();
    _routerDelegate.dispose();
    super.dispose();
  }
}
