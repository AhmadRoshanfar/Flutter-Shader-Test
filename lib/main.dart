import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shader_test/second_page.dart';

late FragmentProgram fragmentProgram;

Future<void> main() async {
  /* Sending fragmentProgram to HomePage */
  fragmentProgram =
      await FragmentProgram.fromAsset('assets/shaders/my_fragment.frag');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SecondPage(),
      // home: HomePage(fragmentProgram: fragmentProgram)
    );
  }
}
