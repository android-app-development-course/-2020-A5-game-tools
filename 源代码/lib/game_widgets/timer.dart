import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerGameWidget extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TimerGameWidget> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /// Display stop watch time
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snap) {
                final value = snap.data;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value, hours: _isHours);
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        displayTime,
                        style: const TextStyle(
                            fontSize: 40,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        value.toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          /// Display every minute.
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.minuteTime,
              initialData: _stopWatchTimer.minuteTime.value,
              builder: (context, snap) {
                final value = snap.data;
                print('Listen every minute. $value');
                return Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                '分钟',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Helvetica',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                value.toString(),
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                  ],
                );
              },
            ),
          ),

          /// Display every second.
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.secondTime,
              initialData: _stopWatchTimer.secondTime.value,
              builder: (context, snap) {
                final value = snap.data;
                return Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                '秒钟',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Helvetica',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                value.toString(),
                                style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                  ],
                );
              },
            ),
          ),

          /// Lap time.
          Container(
            height: 120,
            margin: const EdgeInsets.all(8),
            child: StreamBuilder<List<StopWatchRecord>>(
              stream: _stopWatchTimer.records,
              initialData: _stopWatchTimer.records.value,
              builder: (context, snap) {
                final value = snap.data;
                if (value.isEmpty) {
                  return Container();
                }
                Future.delayed(const Duration(milliseconds: 100), () {
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut);
                });
                return ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final data = value[index];
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '${index + 1} ${data.displayTime}',
                            style: const TextStyle(
                                fontSize: 17,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(
                          height: 1,
                        )
                      ],
                    );
                  },
                  itemCount: value.length,
                );
              },
            ),
          ),

          /// Button
          Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Theme.of(context).primaryColor,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.start);
                          },
                          child: const Text('开始'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.grey,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.stop);
                          },
                          child: const Text('暂停'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.red,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.reset);
                          },
                          child: const Text(
                            '重置',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0).copyWith(right: 8),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.deepPurpleAccent,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                          },
                          child: const Text(
                            '记录',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
