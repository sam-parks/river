// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../assets.dart';
import '../common/reactive_widget.dart';
import 'river_shader_config.dart';
import 'river_shader_painter.dart';

class RiverShaderWidget extends StatefulWidget {
  const RiverShaderWidget({
    super.key,
    required this.config,
    required this.mousePos,
  });

  final RiverShaderConfig config;
  final Offset mousePos;

  @override
  State<RiverShaderWidget> createState() => RiverShaderWidgetState();
}

class RiverShaderWidgetState extends State<RiverShaderWidget>
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
                    painter: RiverShaderPainter(
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
