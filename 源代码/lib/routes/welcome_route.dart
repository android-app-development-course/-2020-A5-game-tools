import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class WelcomeRoute extends StatelessWidget {
  const WelcomeRoute({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
              decoration: BoxDecoration(color: Colors.redAccent),
              child: Column(children: [
                Container(
                  height: 128,
                ),
                Center(
                  child: Text('社交游戏百宝箱',
                      style: TextStyle(color: Colors.white, fontSize: 32)),
                ),
                Container(
                  height: 64,
                ),
                Container(
                    height: 300,
                    child: Stack(
                      children: [
                        LightBubbleWidget(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FlareActor("assets/flares/chest.flr",
                              animation: 'box'),
                        ),
                      ],
                    )),
                Expanded(
                    child: Center(
                        child: Text('… 点击空白处开始 …',
                            style: TextStyle(
                                color: Colors.white.withAlpha(192),
                                fontSize: 18))))
              ]))),
    );
  }
}

class LightBubbleWidget extends StatefulWidget {
  @override
  _LightBubbleWidgetState createState() => _LightBubbleWidgetState();
}

class _LightBubbleWidgetState extends State<LightBubbleWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat(reverse: true);
    _animation =
    Tween<double>(begin: 0.3, end: 1.0).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: [
          Colors.white.withAlpha((255 * _animation.value).round()),
          Colors.white.withAlpha(0)
        ]),
      ),
    );
  }
}
