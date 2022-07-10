// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//import '../data/library.dart';
import '../routing.dart';
//import '../widgets/author_list.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final String title = 'History';
  final _historyBox = Hive.box('history_box');
  List<Map<String, dynamic>> _items = [];

  // Get all items from the database
  void _refreshItems() {
    final data = _historyBox.keys.map((key) {
      final value = _historyBox.get(key);
      return {"word": value["word"], "time": value['time']};
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      // we use "reversed" to sort items in order from the latest to the oldest
    });
  }

  Map<String, dynamic> _readItem(int key) {
    final item = _historyBox.get(key);
    return item;
  }

  // Delete a single item
  Future<void> _deleteItem(int index) async {
    print(_historyBox.get(index));
    print(_historyBox.length);
    await _historyBox.deleteAt(index);
    print(_historyBox.length);
    _refreshItems(); // update the UI

    // Display a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has been deleted')));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    _refreshItems();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title),
        ),
        body: _items.isEmpty
            ? const Center(
                child: Text(
                  'No Data',
                  style: TextStyle(fontSize: 30),
                ),
              )
            : ListView.builder(
                // the list of items
                itemCount: _items.length,
                itemBuilder: (_, index) {
                  final currentItem = _items[index];
                  return Card(
                    color: Colors.orange.shade100,
                    margin: const EdgeInsets.all(10),
                    elevation: 3,
                    child: ListTile(
                        title: Text(currentItem['word']),
                        subtitle: Text(currentItem['time'].toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Delete button
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteItem(index),
                            ),
                          ],
                        )),
                  );
                }),
      );
}
