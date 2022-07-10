import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:destionation_talentq/src/data/word.dart';

import 'package:hive/hive.dart';
import 'package:destionation_talentq/src/data/history.dart';
import 'package:intl/intl.dart';

class DestinationScreen extends StatefulWidget {
  DestinationScreen({Key? key}) : super(key: key);

  //final String title;

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  // @override
  // void dispose() {
  //   _searchController.dispose();
  //   focus.dispose();
  //   super.dispose();
  // }

  final _historyBox = Hive.box('history_box');

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    word = data.map((e) => Word.fromMap(e)).toList();
  }

  final _formKey = GlobalKey<FormState>();

  final focus = FocusNode();
  List<Word> word = [];
  Word _selectedWord = Word.init();

  //Function xu ly database local (HIVE)
  Future<void> saveToHistory(Map<String, dynamic> newItem) async {
    await _historyBox.add(newItem);
  }

  bool containsWord(String text) {
    final Word result = word.firstWhere(
        (Word words) => words.word.toLowerCase() == text.toLowerCase(),
        orElse: () => Word.init());

    if (result.word.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: SearchField(
                  focusNode: focus,
                  suggestions: word
                      .map((wordList) =>
                          SearchFieldListItem(wordList.word, item: wordList))
                      .toList(),
                  suggestionState: Suggestion.hidden,
                  hasOverlay: true,
                  controller: _searchController,
                  hint: 'Tra từ',
                  maxSuggestionsInViewPort: 4,
                  itemHeight: 45,
                  validator: (x) {
                    if (x!.isEmpty || !containsWord(x)) {
                      return 'Please Enter a valid Word';
                    }
                    return null;
                  },
                  inputType: TextInputType.text,
                  onSuggestionTap: (SearchFieldListItem<Word> x) {
                    setState(() {
                      _selectedWord = x.item!;
                    });
                    _formKey.currentState!.validate();
                    focus.unfocus();
                    saveToHistory({
                      "word": _selectedWord.word,
                      "time": DateFormat('hh:mm:ss').format(DateTime.now())
                    });
                    print(_historyBox.values);
                  },
                ),
              ),
            ),
            Expanded(
                child: Center(
                    child: _selectedWord.word.isEmpty
                        ? const Text('')
                        : WordDetail(
                            wordSearch: _selectedWord,
                          ))),
          ],
        )));
  }
}

class WordDetail extends StatefulWidget {
  final Word? wordSearch;

  const WordDetail({Key? key, required this.wordSearch}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WordDetailState createState() => _WordDetailState();
}

class _WordDetailState extends State<WordDetail> {
  final wordNameInfo = <String>[
    "word",
    "special_collocations",
    "related_phrases",
    "pronunciation",
    "parts_of_speech",
    "english_meaning",
    "vietnamese_meaning"
  ];

  Widget listItem(BuildContext context, int index) {
    var listInfo = [
      widget.wordSearch!.word,
      widget.wordSearch!.specialCollocations,
      widget.wordSearch!.relatedPhrases,
      widget.wordSearch!.pronunciation,
      widget.wordSearch!.partsOfSpeech,
      widget.wordSearch!.englishMeaning,
      widget.wordSearch!.vietnameseMeaning,
    ];
    return Card(
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10), child: Text(wordNameInfo[index])),
          Container(
            height: 20,
            width: 1,
            color: Colors.blue,
          ),
          Expanded(
              child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(listInfo[index])))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: wordNameInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  return listItem(context, index);
                }))
      ],
    );
  }
}
