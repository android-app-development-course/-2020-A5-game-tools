import 'package:flutter/material.dart';
import 'package:flutter_game_box/game_widgets/timer.dart';

import 'game_widgets/dice.dart';

final gamesMetadataList = <GameMetadata>[
  GameMetadata(
      name: "摇骰子",
      desc: "单击屏幕开始摇骰子",
      color: Colors.pink,
      icon: Icons.casino,
      builder: (_) => DicesGameWidget()),
  GameMetadata(
      name: "秒表计时器",
      desc: "用于游戏计时",
      color: Colors.amber,
      icon: Icons.timer,
      builder: (context) => TimerGameWidget()),
  GameMetadata(
      name: "真心话大冒险",
      desc: "随机抽取真心话或大冒险惩罚",
      color: Colors.deepPurple,
      icon: Icons.face,
      ratio: 0.8),
  GameMetadata(
      name: "听歌识曲",
      desc: "请朋友来唱唱歌吧",
      color: Colors.green,
      icon: Icons.hearing,
      ratio: 0.8),
  GameMetadata(
      name: "你画我猜",
      desc: "查看完题目后隐藏，在绘画板上创作，让朋友猜猜你在画什么",
      color: Colors.orange,
      icon: Icons.palette,
      span: 2),
  GameMetadata(
      name: "猜拳",
      desc: "双方点击按钮随机出拳",
      color: Colors.lightBlue,
      icon: Icons.cake_outlined),
  GameMetadata(
      name: "转动指针",
      desc: "指针旋转随机指向一个幸运方向",
      color: Colors.yellow,
      icon: Icons.radio_button_checked)
];

class GameMetadata {
  final String name;
  final String desc;
  final MaterialColor color;
  final IconData icon;
  final int span;
  final num ratio;

  //final WidgetBuilder image;
  final WidgetBuilder builder;

  GameMetadata(
      {@required this.name,
      @required this.desc,
      @required this.color,
      @required this.icon,
      this.builder,
      this.span = 1,
      this.ratio = 1});
}
