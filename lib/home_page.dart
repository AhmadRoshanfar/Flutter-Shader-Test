import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shader_test/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.fragmentProgram});

  final FragmentProgram fragmentProgram;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: CustomPaint(
          painter: MyPainter(const Color.fromARGB(255, 16, 92, 168),
              shader: fragmentProgram.fragmentShader()),
          child: const Center(child: Text("Bright")),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter(this.color, {required this.shader});

  final Color color;
  final FragmentShader shader;
  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, color.red.toDouble() / 255);
    shader.setFloat(3, color.green.toDouble() / 255);
    shader.setFloat(4, color.blue.toDouble() / 255);
    shader.setFloat(5, color.alpha.toDouble() / 255);

    Paint paint = Paint()
      // ..color = color
      // ..strokeWidth = 3
      ..shader = shader;
    // Size center = size / 2;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 150, paint);
    // canvas.drawRect(
    //     Rect.fromLTWH(0, 0, size.width, size.height), Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => color != oldDelegate.color;
}
