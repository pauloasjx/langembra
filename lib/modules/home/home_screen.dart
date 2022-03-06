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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'nothing',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetch,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
