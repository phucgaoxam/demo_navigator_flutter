import 'package:demo_navigator/child/child_a.dart';
import 'package:demo_navigator/child/child_b.dart';
import 'package:demo_navigator/child/child_c.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BuildContext _c1;
  BuildContext _c2;

  Queue<BuildContext> _queue = Queue();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_queue.isNotEmpty) {
          Navigator.of(_queue.removeLast()).pop();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Navigator(
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(builder: (context) {
                      _c1 = context;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChildA()));
                          _queue.addLast(context);
                        },
                        child: Center(
                          child: Text('Fragment A'),
                        ),
                      );
                    });
                  },
                ),
              ),
              Expanded(
                child: Navigator(
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(builder: (context) {
                      _c2 = context;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChildB()));
                          _queue.addLast(context);
                        },
                        child: Center(
                          child: Text('Fragment B'),
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(_c1).push(MaterialPageRoute(builder: (context) => ChildA()));
              _queue.addLast(_c1);
            },
            child: Text('Replace A'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(_c2).push(MaterialPageRoute(builder: (context) => ChildB()));
              _queue.addLast(_c2);
            },
            child: Text('Replace B'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChildC()));
            },
            child: Text('Replace All'),
          ),
        ],
      ),
    );
  }
}
