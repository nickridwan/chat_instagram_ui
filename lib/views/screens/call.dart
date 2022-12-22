import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_apps/models/models.dart';
import 'package:music_apps/theme.dart';
import 'dart:math' as math show sin, pi, sqrt;
import 'package:flutter/animation.dart';

class CallingPage extends StatefulWidget {
  UserModel user;
  CallingPage({Key? key, required this.user}) : super(key: key);

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.chevron_down,
                      size: 30.0,
                      color: AppColor.kWhiteColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.kRedColor,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.phone_arrow_up_right,
                        size: 24.0,
                        color: AppColor.kWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.user.avatar,
                ),
                radius: 80,
              ),
              CustomPaint(
                painter: CirclePainter(
                  _controller!,
                  color: AppColor.kRedColor,
                ),
                child: SizedBox(
                  width: 80.0 * 4.125,
                  height: 80.0 * 4.125,
                  child: _button(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                AppColor.kRedColor,
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
              child: const Icon(
                Icons.speaker_phone,
                size: 44,
              )),
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
