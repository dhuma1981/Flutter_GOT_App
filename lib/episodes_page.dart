import 'package:flutter/material.dart';
import 'package:got_app/got.dart';

class EpisodesPage extends StatelessWidget {
  final List<Episodes> episodes;
  final MyImage image;

  EpisodesPage({this.episodes, this.image});

  Widget myBody() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.0),
      itemCount: episodes.length,
      itemBuilder: (context, index) => Card(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(
                  episodes[index].image.original,
                  fit: BoxFit.cover,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      episodes[index].name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: Container(
                    color: Colors.red,
                    child: Text("${episodes[index].season.toString()}"),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Hero(
              tag: "got",
              child: CircleAvatar(
                backgroundImage: NetworkImage(image.original),
              ),
            ),
            Text("All Episodes")
          ],
        ),
      ),
      body: myBody(),
    );
  }
}
