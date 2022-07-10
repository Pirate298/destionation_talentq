/*
 * File: country_model.dart
 * Project: None
 * File Created: Wednesday, 1st September 2021 1:58:27 pm
 * Author: Mahesh Jamdade
 * -----
 * Last Modified: Wednesday, 1st September 2021 2:06:27 pm
 * Modified By: Mahesh Jamdade
 * -----
 * Copyright 2021 - 2021 None
 */

class Word {
  final String word;
  final String specialCollocations;
  final String relatedPhrases;
  final String pronunciation;
  final String partsOfSpeech;
  final String englishMeaning;
  final String vietnameseMeaning;

  Word(
      this.word,
      this.specialCollocations,
      this.relatedPhrases,
      this.pronunciation,
      this.partsOfSpeech,
      this.englishMeaning,
      this.vietnameseMeaning);

  Word.init()
      : word = '',
        specialCollocations = '',
        relatedPhrases = '',
        pronunciation = '',
        partsOfSpeech = '',
        englishMeaning = '',
        vietnameseMeaning = '';

  Word.fromMap(Map<String, Object> map)
      : word = map['word'] as String,
        specialCollocations = map['special_collocations'] as String,
        relatedPhrases = map['related_phrases'] as String,
        pronunciation = map['pronunciation'] as String,
        partsOfSpeech = map['parts_of_speech'] as String,
        englishMeaning = map['english_meaning'] as String,
        vietnameseMeaning = map['vietnamese_meaning'] as String;
}

// data test
List<Map<String, Object>> data = [
  // {
  //   'country': 'Afghanistan',
  //   'population': 38928346,
  //   'density': 60,
  //   'land Area': 652860
  // }
  {
    'word': 'break a habit',
    'special_collocations': 'COLLOCATIONS',
    'related_phrases': 'break a habit',
    'pronunciation': '',
    'parts_of_speech': '',
    'english_meaning':
        'to stop doing something that is a habit, especially something bad or harmful',
    'vietnamese_meaning': 'loại bỏ thói quen xấu',
  },
  {
    'word': 'break with tradition',
    'special_collocations': 'COLLOCATIONS',
    'related_phrases': 'break with tradition',
    'pronunciation': '',
    'parts_of_speech': '',
    'english_meaning': 'To do something in a new, different, or unique way.',
    'vietnamese_meaning': 'phá vỡ truyền thống',
  },
  {
    'word': 'break down',
    'special_collocations': 'PHRASAL VERBS',
    'related_phrases': '',
    'pronunciation': '',
    'parts_of_speech': '',
    'english_meaning':
        'divide something such as a total amount into separate parts breakdown (n) the process of a substance breaking into the parts of which it is made',
    'vietnamese_meaning':
        'chia thành từng phần quá trình chia cái gì thành từng phần',
  },
  {
    'word': 'break even',
    'special_collocations': 'IDIOMS',
    'related_phrases': '',
    'pronunciation': '',
    'parts_of_speech': '',
    'english_meaning':
        'if a person or business breaks even, they neither make a profit nor lose money',
    'vietnamese_meaning': 'hòa vốn',
  },
  {
    'word': 'break the mould',
    'special_collocations': 'IDIOMS',
    'related_phrases': '',
    'pronunciation': '',
    'parts_of_speech': '',
    'english_meaning':
        'to do something differently after it has been done in the same way for a long time',
    'vietnamese_meaning': 'phá vỡ khuôn mẫu',
  }
];
