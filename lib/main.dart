import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:river/assets.dart';
import 'package:river/river_shader/river_shader_config.dart';
import 'package:river/river_shader/river_shader_widget.dart';
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
  final _riverKey = GlobalKey<RiverShaderWidgetState>();

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
        child: Stack(
          children: [
            Positioned.fill(
              child: Stack(
                children: [
                  // River
                  RiverShaderWidget(
                    key: _riverKey,
                    mousePos: _mousePos,
                    minEnergy: 0,
                    config: const RiverShaderConfig(
                      ambientLightColor: Colors.lightBlue,
                      materialColor: Colors.blue,
                      lightColor: Colors.white,
                    ),
                    onUpdate: (energy) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
