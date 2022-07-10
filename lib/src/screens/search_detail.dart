// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:destionation_talentq/src/data/search.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class SearchDetailScreen extends StatelessWidget {
  final Search? search;

  const SearchDetailScreen({
    super.key,
    this.search,
  });

  @override
  Widget build(BuildContext context) {
    if (search == null) {
      return const Scaffold(
        body: Center(
          child: Text('No book found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(search!.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              search!.title,
              style: Theme.of(context).textTheme.headline4,
            ),
            // Text(
            //   search!.author.name,
            //   style: Theme.of(context).textTheme.subtitle1,
            // ),
            TextButton(
              child: const Text('View author (Push)'),
              onPressed: () {
                // Navigator.of(context).push<void>(
                //   MaterialPageRoute<void>(
                //     builder: (context) =>
                //         AuthorDetailsScreen(author: search!.author),
                //   ),
                // );
              },
            ),
            // Link(
            //   uri: Uri.parse('/author/${search!.author.id}'),
            //   builder: (context, followLink) => TextButton(
            //     onPressed: followLink,
            //     child: const Text('View author (Link)'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
