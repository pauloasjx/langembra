import 'package:flutter/material.dart';
import 'package:langembra/services/article_service.dart';
import 'package:langembra/services/special_random_service.dart';
import 'package:langembra/widgets/sentence_widget.dart';

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

    final SentenceWidget sentence = SentenceWidget(sample);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Result"),
                    content: Text(sentence.isRight() ? "Ok" : "Not ok"),
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
          backgroundColor: Colors.white,
          label: Text("Confirmar", style: TextStyle(color: Colors.black)),
          icon: Icon(Icons.navigate_next, color: Colors.black)),
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
              child: sentence,
            )
          ],
        ),
      ),
    );
  }
}
