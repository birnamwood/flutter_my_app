import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home: FirstPage(),
    //Flutterでのルーティング設定の書き方
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second': (context) => SecondPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == 'second') {
          var messageFromFirst = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return SecondPage();
            },
          );
        }
        return null;
      },
    );
  }
}

class FirstPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: Center(
        child: RaisedButton(
          child: Text('Next Page'),
            onPressed: () {
            Navigator.pushNamed(
                context,
                '/second',
                arguments: 'messageFromFirst',
            );
          }
        ),
      )
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //受け取ったデータを定義
    var messageFromFirst = ModalRoute.of(context).settings.arguments;
    print(messageFromFirst);
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //popの第二引数で元画面に渡すデータを指定
            Navigator.pop<String>(context, "SecondPageから戻った");
          },
          child: Text('Go back'),
        )
      )
    );
  }
}