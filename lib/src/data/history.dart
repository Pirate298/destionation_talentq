import 'package:hive/hive.dart';
import 'dart:io';

@HiveType(typeId: 0)
class History extends HiveObject {
  @HiveField(0)
  final String time;
  @HiveField(1)
  final String word;
//DateTime now = DateTime.now();
//String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
  History(this.time, this.word);
}
