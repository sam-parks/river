// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../assets.dart';
import '../common/reactive_widget.dart';
import 'learning_shader_config.dart';
import 'learning_shader_painter.dart';

class LearningShaderWidget extends StatefulWidget {
  const LearningShaderWidget({
    super.key,
    required this.config,
    required this.mousePos,
  });

  final LearningShaderConfig config;
  final Offset mousePos;

  @override
  State<LearningShaderWidget> createState() => LearningShaderWidgetState();
}

class LearningShaderWidgetState extends State<LearningShaderWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => Consumer<Shaders?>(
        builder: (context, shaders, _) {
          if (shaders == null) return const SizedBox.expand();
          return TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 0),
            duration: 300.ms,
            curve: Curves.easeOutCubic,
            builder: (context, minEnergy, child) {
              return ReactiveWidget(
                builder: (context, time, size) {
          
                  return CustomPaint(
                    size: size,
                    painter: LearningShaderPainter(
                      shaders.learning,
                      config: widget.config,
                      time: time,
                      mousePos: widget.mousePos,
                    ),
                  );
                },
              );
            },
          );
        },
      );
}
