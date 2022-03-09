import 'package:flutter/material.dart';
import 'package:langembra/widgets/sentence_widget.dart';

enum AnswerState { nothing, correct, wrong }

extension AnswerStateExtension on AnswerState {
  String get title {
    switch (this) {
      case AnswerState.correct:
        return "Correto";
      case AnswerState.wrong:
        return "Errado";
      default:
        return "";
    }
  }

  Color get color {
    switch (this) {
      case AnswerState.correct:
        return Colors.green;
      case AnswerState.wrong:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<String> samples;
  int current = 0;
  AnswerState answerState = AnswerState.nothing;

  @override
  void initState() {
    super.initState();
    this.samples = [
      "You can get some cash from the ATM",
      "Civilian casualties reach 1,335 since Russia’s full-scale invasion began",
      "474 civilians have been killed and 861 injured"
    ];
    this.current = 0;
  }

  @override
  Widget build(BuildContext context) {
    final SentenceWidget sentence =
        SentenceWidget(samples.elementAt(this.current));

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            setState(() {
              answerState =
                  sentence.isRight() ? AnswerState.correct : AnswerState.wrong;
            });
            final SnackBar snackBar = SnackBar(
                content: Text(answerState.title,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                duration: Duration(seconds: 1),
                backgroundColor: answerState.color);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          label: Text("Confirmar"),
          icon: Icon(Icons.navigate_next)),
      body: Center(
        child: Column(
          children: [
            Container(
                child: Row(children: [Text("Langembra")]),
                margin: EdgeInsets.all(16.0)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(16.0),
                    child: Text(
                        "Você pode obter algum dinheiro no caixa eletrônico",
                        style: TextStyle(fontSize: 18)),
                  ),
                  Container(
                    margin: EdgeInsets.all(16.0),
                    child: sentence,
                  ),
                  Container(
                    margin: EdgeInsets.all(16.0),
                    child: Text(sentence.text, style: TextStyle(fontSize: 18)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
