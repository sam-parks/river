import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:river/assets.dart';
import 'package:river/learning_shader/learning_shader_config.dart';
import 'package:river/learning_shader/learning_shader_widget.dart';
import 'package:river/wood_shader/wood_shader_config.dart';
import 'package:river/wood_shader/wood_shader_widget.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:window_size/window_size.dart';

void main() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowMinSize(const Size(800, 500));
  }
  Animate.restartOnHotReload = true;
  runApp(
    FutureProvider<Shaders?>(
      create: (context) => loadShaders(),
      initialData: null,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _shader1Key = GlobalKey<WoodShaderWidgetState>();
  final _shader2Key = GlobalKey<WoodShaderWidgetState>();
  final _shader3Key = GlobalKey<WoodShaderWidgetState>();
  final _waterKey = GlobalKey<LearningShaderWidgetState>();

  /// Internal
  var _mousePos = Offset.zero;

  /// Update mouse position so the orbWidget can use it, doing it here prevents
  /// btns from blocking the mouse-move events in the widget itself.
  void _handleMouseMove(PointerHoverEvent e) {
    setState(() {
      _mousePos = e.localPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        onHover: _handleMouseMove,
        child: Center(
          child: Stack(
            children: [
              Transform(
                transform: Matrix4.identity()..rotateX(1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: SizedBox(
                    height: 500,
                    width: 500,
                    child: LearningShaderWidget(
                      key: _waterKey,
                      mousePos: _mousePos,
                      config: const LearningShaderConfig(),
                    ),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..rotateZ(-.4)
                  ..rotateY(.2)
                  ..rotateX(-.4)
                  ..translate(Vector3(100, 100, 100)),
                child: Stack(
                  children: [
                    Transform(
                      transform: Matrix4.identity()..rotateX(-pi / 2),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 5)),
                        ]),
                        child: WoodShaderWidget(
                          key: _shader3Key,
                          mousePos: _mousePos,
                          config: const WoodShaderConfig(),
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.identity(),
                      child: Container(
                        height: 75,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 5)),
                            ]),
                        child: WoodShaderWidget(
                          key: _shader1Key,
                          mousePos: _mousePos,
                          config: const WoodShaderConfig(),
                        ),
                      ),
                    ),
                    Transform(
                      //rotate 90 degrees
                      transform: Matrix4.identity()..rotateY(pi / 2),
                      child: Container(
                        height: 75,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 5)),
                            ]),
                        child: WoodShaderWidget(
                          key: _shader2Key,
                          mousePos: _mousePos,
                          config: const WoodShaderConfig(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
