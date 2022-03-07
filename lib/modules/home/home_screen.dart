import 'dart:math';

import 'package:flutter/material.dart';
import 'package:langembra/services/article_service.dart';
import 'package:langembra/services/special_random_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void fetch() async {
    try {
      final specialRandom = await SpecialRandomService().generate();
      final article = await ArticleService().fetch(specialRandom.pageName);

      print(article.getSentence());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String sample = "You can get some cash from the ATM";

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: SentenceWidget(sample),
        ),
      ),
    );
  }
}

class SentenceWidget extends StatelessWidget {
  String? text;
  List<Widget>? subsentences;

  SentenceWidget(String text) {
    final List<Widget> subsentences =
        text.split(" ").map((s) => WordWidget(s)).toList();
    final rnd = Random();
    final idx = rnd.nextInt(subsentences.length);
    // final subsentence = subsentences[idx] as WordWidget;
    // if (subsentence.runtimeType == WordWidget) {
    // subsentences[idx] = subsentence.toInput();
    // }

    this.text = text;
    this.subsentences = subsentences;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: subsentences!,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center);
  }
}

class WordWidget extends StatelessWidget {
  final String value;

  WordWidget(this.value);

  @override
  build(BuildContext context) {
    return Text(" " + value);
  }

  WordInputWidget toInput() => WordInputWidget(this.value);
}

class WordInputWidget extends StatefulWidget {
  final String value;

  WordInputWidget(this.value);

  @override
  _WordInputWidgetState createState() => _WordInputWidgetState();
}

class _WordInputWidgetState extends State<WordInputWidget> {
  String current = "";

  @override
  build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        child: TextField(),
        width: 100,
      ),
    );
  }
}
