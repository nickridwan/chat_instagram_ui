import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_apps/models/models.dart';
import 'package:music_apps/theme.dart';
import 'package:music_apps/views/widgets/camera.dart';
import 'dart:math' as math show sin, pi, sqrt;

import 'package:stop_watch_timer/stop_watch_timer.dart';

class CallingPage extends StatefulWidget {
  UserModel user;
  CallingPage({Key? key, required this.user}) : super(key: key);

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  String waiting = "";
  bool isAnswer = false;
  bool micAccess = false;
  bool cameraAccess = false;
  String status = "Berdering...";
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  Stream<int>? timerStream;
  StreamSubscription<int>? timerSubscription;
  String hoursStr = '00';
  String minutesStr = '00';
  String secondsStr = '00';
  Timer? timer;
  StreamController<int>? streamController;
  Duration timerInterval = const Duration(seconds: 1);
  int counter = 0;

  Stream<int> stopWatchStream() {
    void stopTimer() {
      if (timer != null) {
        timer!.cancel();
        timer = null;
        counter = 0;
        streamController!.close();
      }
    }

    void tick(_) {
      counter++;
      streamController!.add(counter);
      if (isAnswer == false) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController!.stream;
  }

  @override
  void initState() {
    super.initState();
    waitAnswer();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    log("initState()");
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
    log("Calling dispose()");
  }

  Future waitAnswer() async {
    setState(() {
      isAnswer = false;
    });
    return Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        isAnswer = true;
        timerStream = stopWatchStream();
        timerSubscription = timerStream!.listen((int newTick) {
          setState(() {
            hoursStr =
                ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
            minutesStr =
                ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
            secondsStr = (newTick % 60).floor().toString().padLeft(2, '0');
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    log(isAnswer == false
        ? "panggilan sedang tidak berlangsung"
        : "panggilan sedang berlangsung");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.person_add_rounded,
            size: 30.0,
            color: AppColor.kWhiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.arrow_2_circlepath,
              size: 30.0,
              color: AppColor.kWhiteColor,
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomPaint(
                painter: CirclePainter(
                  _controller!,
                  color: AppColor.kRedColor,
                ),
                child: SizedBox(
                  width: 80.0 * 4.125,
                  height: 80.0 * 4.125,
                  child: wave(),
                ),
              ),
              !isAnswer
                  ? Text(
                      status,
                      style: Style.whiteTextStyle.copyWith(fontSize: 25),
                    )
                  : Text(
                      "$hoursStr:$minutesStr:$secondsStr",
                      style: Style.whiteTextStyle.copyWith(fontSize: 30),
                    ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.kRedColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          cameraAccess = !cameraAccess;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.videocam_fill,
                        size: 30.0,
                        color: cameraAccess
                            ? AppColor.kWhiteColor
                            : AppColor.kGreyColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.kRedColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isAnswer = false;
                          status = "Panggilan Berakhir...";
                        });
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pop(context);
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.phone_arrow_up_right,
                        size: 24.0,
                        color: AppColor.kWhiteColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.kRedColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          micAccess = !micAccess;
                        });
                      },
                      icon: Icon(
                        micAccess ? CupertinoIcons.mic_off : CupertinoIcons.mic,
                        size: 24.0,
                        color: AppColor.kWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List fake = [];

  Widget wave() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                AppColor.kBlueColor,
                AppColor.kBlackColor,
              ],
            ),
          ),
          child: ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller!,
                curve: CurveWave(),
              ),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                widget.user.avatar,
              ),
              radius: 80,
            ),
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter(
    this._animation, {
    required this.color,
  }) : super(repaint: _animation);
  final Color color;
  final Animation<double> _animation;
  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity);
    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);
    final Paint paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}

class CurveWave extends Curve {
  @override
  double transform(double t) {
    if (t == 0 || t == 1) {
      return 0.01;
    }
    return math.sin(t * math.pi);
  }
}
