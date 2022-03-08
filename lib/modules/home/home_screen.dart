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
    final String sample2 = "Você pode obter algum dinheiro no caixa eletrônico";

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              child: Text(sample2, style: TextStyle(fontSize: 18)),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: SentenceWidget(sample),
            )
          ],
        ),
      ),
    );
  }
}

class SentenceWidget extends StatelessWidget {
  late String text;
  late List<Widget> subsentences;

  SentenceWidget(String text) {
    final List<Widget> subsentences = text
        .split(" ")
        .asMap()
        .map((idx, s) =>
            MapEntry(idx, idx == 2 ? WordInputWidget(s) : WordWidget(s)))
        .values
        .toList();
    this.text = text;
    this.subsentences = subsentences;
  }

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

class WordInputWidget extends StatefulWidget {
  final String value;

  WordInputWidget(this.value);

  @override
  _WordInputWidgetState createState() => _WordInputWidgetState();
}

class _WordInputWidgetState extends State<WordInputWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isRight() => _controller.value.text == widget.value;

  @override
  build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        child: TextField(
            controller: _controller,
            onSubmitted: (String value) async {
              await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Result"),
                      content: Text(isRight() ? "Ok" : "Not ok"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ok"))
                      ],
                    );
                  });
            },
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
