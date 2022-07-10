import 'package:flutter/material.dart';

import '../routing.dart';
import '../data/search.dart';
import '../widgets/search_list.dart';
import 'searchview/destination_screen.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_handleTabIndexChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newPath = _routeState.route.pathTemplate;
    if (newPath.startsWith('/search/destination')) {
      _tabController.index = 0;
    } else if (newPath.startsWith('/search/google')) {
      _tabController.index = 1;
    } else if (newPath == '/search/dictionnary') {
      _tabController.index = 2;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Search'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Destination',
                icon: Icon(Icons.book),
              ),
              Tab(
                text: 'Google',
                icon: Icon(Icons.web),
              ),
              Tab(text: 'Dictionary', icon: Icon(Icons.bookmark)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            DestinationScreen(),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      );

  RouteState get _routeState => RouteStateScope.of(context);

  void _handleSearchTapped(Search search) {
    _routeState.go('/book/${search.id}');
  }

  void _handleTabIndexChanged() {
    switch (_tabController.index) {
      case 1:
        _routeState.go('/books/new');
        break;
      case 2:
        _routeState.go('/books/all');
        break;
      case 0:
      default:
        _routeState.go('/books/popular');
        break;
    }
  }
}
