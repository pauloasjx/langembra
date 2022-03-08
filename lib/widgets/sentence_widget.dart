import 'package:flutter/material.dart';

class SentenceWidget extends StatelessWidget {
  late final String text;
  late final List<Widget> subsentences;

  SentenceWidget(String text) {
    final List<Widget> subsentences = text
        .split(" ")
        .asMap()
        .map((idx, s) =>
            MapEntry(idx, idx % 2 == 0 ? WordInputWidget(s) : WordWidget(s)))
        .values
        .toList();
    this.text = text;
    this.subsentences = subsentences;
  }

  bool isRight() => subsentences
      .where((s) => s.runtimeType == WordInputWidget)
      .every((s) => (s as WordInputWidget).isRight());

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: subsentences,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center);
  }
}

class WordWidget extends StatelessWidget {
  final String value;

  WordWidget(this.value);

  @override
  build(BuildContext context) {
    return Text(" " + value, style: TextStyle(fontSize: 20.0));
  }

  WordInputWidget toInput() => WordInputWidget(this.value);
}

class WordInputWidget extends StatelessWidget {
  final String value;
  final TextEditingController _controller = TextEditingController();

  WordInputWidget(this.value);

  bool isRight() => _controller.value.text == this.value;

  @override
  build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(0.0)),
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center),
        width: 100,
      ),
    );
  }
}
