import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter http Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter http Demo'),
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
  dynamic _data;
  int statusCode = 0;
  final String url = 'https://jsonplaceholder.typicode.com';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(onPressed: get, child: Text("Get")),
            RaisedButton(onPressed: post, child: Text("Post")),
            RaisedButton(onPressed: formPost, child: Text("Post Form")),
            RaisedButton(onPressed: put, child: Text("Put")),
            RaisedButton(onPressed: patch, child: Text("Patch")),
            RaisedButton(onPressed: delete, child: Text("Delete")),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Status Code: ", style: Theme.of(context).textTheme.display1),
                  statusCode != null
                    ? Text(statusCode.toString(), style: Theme.of(context).textTheme.display1)
                    : CircularProgressIndicator()
                ],
              )
            ),
            Expanded(
              child: SingleChildScrollView(
                child: _data != null && _data.isNotEmpty
                  ? JsonViewerWidget(_data)
                  : Text("Click above buttons to get data"),
              )
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void get() async{
    setState(() {
      statusCode = null;
    });

    /// Sending http get request
    var response = await http.get(
      url + "/posts/1",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
    ).timeout(Duration(seconds: 60)) /// This timeout for request. If response not get in 60 seconds. The request generates time our error
    .catchError((error) { /// Catches http error like 404, 403 etc
      /// NEED TO IMPLEMENT: Do what you want to show in the screen
    });

    /// Saving response in variables
    statusCode = response.statusCode;
    _data = jsonDecode(response.body);
    setState(() {});
  }

  void post() async{
    setState(() {
      statusCode = null;
    });

    /// This json going to post
    Map<String, dynamic> postJson = {
      "title": 'foo',
      "body": 'bar',
      "userId": 1,
    };

    /// Sending http post request
    var response = await http.post(
      url + "/posts",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: json.encode(postJson) /// Convert json to string
    ).timeout(Duration(seconds: 60)) /// This timeout for request. If response not get in 60 seconds. The request generates time our error
    .catchError((error) { /// Catches http error like 404, 403 etc
      /// NEED TO IMPLEMENT: Do what you want to show in the screen
    });

    /// Saving response in variables
    statusCode = response.statusCode;
    _data = jsonDecode(response.body);
    setState(() {});
  }

  void formPost() async{
    setState(() {
      statusCode = null;
    });

    /// This json going to post
    Map<String, String> postJson = {
      "title": 'foo',
      "body": 'bar'
    };

    /// converting url to uri
    var uri = Uri.parse("https://postman-echo.com/post");

    /// creating http form request
    var request = http.MultipartRequest(
      'POST',
      uri,
    )..fields.addAll(postJson);/// This timeout for request. If response not get in 60 seconds. The request generates time our error;

    /// sending http form request
    var response = await request.send()
        .timeout(Duration(seconds: 60)) /// This timeout for request. If response not get in 60 seconds. The request generates time our error
        .catchError((error) { /// Catches http error like 404, 403 etc
          /// NEED TO IMPLEMENT: Do what you want to show in the screen
        });

    /// Saving response in variables
    statusCode = response.statusCode;
    _data = {};
    setState(() {});
  }

  void put() async{
    setState(() {
      statusCode = null;
    });

    /// This json going to post
    Map<String, dynamic> postJson = {
      "id": 1,
      "title": 'foo',
      "body": 'bar',
      "userId": 1,
    };

    /// sending http put request
    var response = await http.put(
      url + "/posts/1",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: json.encode(postJson) /// Convert json to string
    ).timeout(Duration(seconds: 60))/// This timeout for request. If response not get in 60 seconds. The request generates time our error
    .catchError((error) { /// Catches http error like 404, 403 etc
      /// NEED TO IMPLEMENT: Do what you want to show in the screen
    });

    /// Saving response in variables
    statusCode = response.statusCode;
    _data = jsonDecode(response.body);
    setState(() {});
  }

  void patch() async{
    setState(() {
      statusCode = null;
    });

    /// This json going to post
    Map<String, dynamic> postJson = {
      "title": 'foo',
    };

    /// sending http patch request
    var response = await http.patch(
      url + "/posts/1",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: json.encode(postJson) /// Convert json to string
    ).timeout(Duration(seconds: 60))/// This timeout for request. If response not get in 60 seconds. The request generates time our error
    .catchError((error) { /// Catches http error like 404, 403 etc
      /// NEED TO IMPLEMENT: Do what you want to show in the screen
    });

    /// Saving response in variables
    statusCode = response.statusCode;
    _data = jsonDecode(response.body);
    setState(() {});
  }

  void delete() async{
    setState(() {
      statusCode = null;
    });

    /// sending http delete request
    var response = await http.delete(url + "/posts/1")
        .timeout(Duration(seconds: 60))/// This timeout for request. If response not get in 60 seconds. The request generates time our error
        .catchError((error) { /// Catches http error like 404, 403 etc
          /// NEED TO IMPLEMENT: Do what you want to show in the screen
        });

    /// Saving response in variables
    statusCode = response.statusCode;
    _data = jsonDecode(response.body);
    setState(() {});
  }
}
