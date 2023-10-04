import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<AnimatedProvider>.value(
        value: AnimatedProvider(),
        child: const MyAnimatedPage(),
      ),
    );
  }
}

class MyAnimatedPage extends StatefulWidget {
  const MyAnimatedPage({super.key});

  @override
  State<MyAnimatedPage> createState() => _MyAnimatedPageState();
}

class _MyAnimatedPageState extends State<MyAnimatedPage> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    AnimatedProvider state = Provider.of<AnimatedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homework Provider',
          style: TextStyle(color: state.colorAppBar),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 200,
              height: 200,
              color: state.colorContainer,
            ),
            const SizedBox(height: 10),
            Switch(
              value: light,
              onChanged: (bool value) {
                setState(() {
                  light = value;
                  state
                    ..changeRandomColorAppBar()
                    ..changeRandomColorContainer();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedProvider extends ChangeNotifier {
  Color _colorContainer = Colors.green;
  Color _colorAppBar = Colors.orangeAccent;

  Color get colorContainer => _colorContainer;

  Color get colorAppBar => _colorAppBar;

  void changeRandomColorContainer() {
    final random = Random();
    _colorContainer = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  void changeRandomColorAppBar() {
    final random = Random();
    _colorAppBar = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
    notifyListeners();
  }
}
