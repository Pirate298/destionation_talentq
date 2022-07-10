// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:destionation_talentq/src/data/history.dart';
import 'package:destionation_talentq/src/screens/history_Detail.dart';
import 'package:flutter/material.dart';

// import '../auth.dart';
// import '../data.dart';
import '../routing.dart';
import '../data/search.dart';
import 'scaffold.dart';
// import '../screens/sign_in.dart';
import '../widgets/fade_transition_page.dart';
import 'search_detail.dart';
// import 'author_details.dart';
// import 'book_details.dart';
// import 'scaffold.dart';

/// Builds the top-level navigator for the app. The pages to display are based
/// on the `routeState` that was parsed by the TemplateRouteParser.
class DictionaryNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const DictionaryNavigator({
    required this.navigatorKey,
    super.key,
  });

  @override
  State<DictionaryNavigator> createState() => _DictionnaryNavigatorState();
}

class _DictionnaryNavigatorState extends State<DictionaryNavigator> {
  //final _signInKey = const ValueKey('Sign in');
  final _scaffoldKey = const ValueKey('App scaffold');
  final _bookDetailsKey = const ValueKey('Search details screen');
  final _authorDetailsKey = const ValueKey('History details screen');

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    //final authState = BookstoreAuthScope.of(context);
    final pathTemplate = routeState.route.pathTemplate;

    Search? selectedBook;
    // if (pathTemplate == '/book/:bookId') {
    //   selectedBook = libraryInstance.allBooks.firstWhereOrNull(
    //       (b) => b.id.toString() == routeState.route.parameters['bookId']);
    // }

    History? selectedHistory;
    // if (pathTemplate == '/author/:authorId') {
    //   selectedHistory = libraryInstance.allAuthors.firstWhereOrNull(
    //       (b) => b.id.toString() == routeState.route.parameters['authorId']);
    // }

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, dynamic result) {
        // When a page that is stacked on top of the scaffold is popped, display
        // the /books or /authors tab in BookstoreScaffold.
        if (route.settings is Page &&
            (route.settings as Page).key == _bookDetailsKey) {
          routeState.go('/books/popular');
        }

        if (route.settings is Page &&
            (route.settings as Page).key == _authorDetailsKey) {
          routeState.go('/authors');
        }

        return route.didPop(result);
      },
      pages: [
        // if (routeState.route.pathTemplate == '/signin')
        //   // Display the sign in screen.
        //   FadeTransitionPage<void>(
        //     key: _signInKey,
        //     child: SignInScreen(
        //       onSignIn: (credentials) async {
        //         var signedIn = await authState.signIn(
        //             credentials.username, credentials.password);
        //         if (signedIn) {
        //           await routeState.go('/books/popular');
        //         }
        //       },
        //     ),
        //   )
        // else ...[
        // Display the app
        FadeTransitionPage<void>(
          key: _scaffoldKey,
          child: const DictionnaryScaffold(),
        ),
        // Add an additional page to the stack if the user is viewing a book
        // or an author
        if (selectedBook != null)
          MaterialPage<void>(
            key: _bookDetailsKey,
            child: SearchDetailScreen(
              search: selectedBook,
            ),
          )
        else if (selectedHistory != null)
          MaterialPage<void>(
            key: _authorDetailsKey,
            child: HistoryDetailsScreen(
              history: selectedHistory,
            ),
          ),
      ],
      // ],
    );
  }
}
