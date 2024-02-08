import 'dart:ui';

import 'package:flutter/material.dart';

double time = 0;

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<FragmentProgram>(
        future: FragmentProgram.fromAsset("assets/shaders/my_fragment.frag"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            /// Shader is loading
            return const CircularProgressIndicator();
          }
          return SizedBox.expand(
            child: CustomPaint(
              painter: SecondPainter(
                  color: Colors.teal, fragmentProgram: snapshot.data!),
            ),
          );
        },
      ),
    );
  }
}

class SecondPainter extends CustomPainter {
  SecondPainter({required this.color, required this.fragmentProgram});

  final Color color;
  final FragmentProgram fragmentProgram;

  @override
  void paint(Canvas canvas, Size size) {
    FragmentShader shader = fragmentProgram.fragmentShader();

    // shader
    //   ..setFloat(0, 0.5)
    //   ..setFloat(1, size.width)
    //   ..setFloat(2, size.height);

    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, color.red.toDouble() / 255);
    shader.setFloat(3, color.green.toDouble() / 255);
    shader.setFloat(4, color.blue.toDouble() / 255);
    shader.setFloat(5, color.alpha.toDouble() / 255);

    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(SecondPainter oldDelegate) => color != oldDelegate.color;
}
