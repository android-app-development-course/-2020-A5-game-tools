import 'package:flutter/material.dart';
import 'package:flutter_game_box/games_metadata.dart';

class GameDetailsRoute extends StatelessWidget {
  final GameMetadata gm;

  GameDetailsRoute(this.gm, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
        data: ThemeData(primarySwatch: gm.color),
        child: Scaffold(
            appBar: AppBar(
              title: Text("游戏介绍"),
            ),
            body: Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                          child: Text(
                        gm.name,
                        style: TextStyle(fontSize: 24.0),
                      )),
                    ),
                    AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Padding(
                        padding: const EdgeInsets.all(26.0),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey),
                        ),
                      ),
                    ),
                    Text(gm.desc)
                  ],
                )),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    width: double.infinity,
                    child: gm.builder != null
                        ? ElevatedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                        appBar: AppBar(
                                          title: Text(gm.name),
                                        ),
                                        body: gm.builder(context)))),
                            child: Text("开始游戏"),
                          )
                        : ElevatedButton(
                            onPressed: null,
                            child: Text("敬请期待"),
                          ))
              ],
            )));
  }
}
