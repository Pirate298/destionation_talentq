import 'package:destionation_talentq/src/data/history.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../routing.dart';

class HistoryDetailsScreen extends StatelessWidget {
  final History history;

  const HistoryDetailsScreen({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(history.word),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                child: const Text('View author (Push)'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
}
