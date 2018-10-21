import 'package:flutter/material.dart';
import 'package:got_app/episodes_page.dart';
import 'package:got_app/got.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      'http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes';

  GOT got;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEpisodes();
  }

  fetchEpisodes() async {
    var res = await http.get(url);
    var decRes = jsonDecode(res.body);
    print(decRes);
    got = GOT.fromJson(decRes);
    setState(() {});
  }

  Widget myCard() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Hero(
            tag: "got",
            child: CircleAvatar(
              radius: 100.0,
              backgroundImage: NetworkImage(got.image.original),
            ),
          ),
          Text(
            got.name,
            style: TextStyle(
                color: Colors.green,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Runtime: ${got.runtime.toString()} minutes",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            got.summary,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RaisedButton(
            child: Text(
              "All Episodes",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EpisodesPage(
                            image: got.image,
                            episodes: got.eEmbedded.episodes,
                          )));
            },
          )
        ],
      ),
    );
  }

  Widget myBody() {
    return got == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : myCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game of Thrones"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.refresh),
      ),
      body: myBody(),
    );
  }
}
