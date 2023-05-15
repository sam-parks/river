// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/material.dart';

import 'learning_shader_config.dart';

class LearningShaderPainter extends CustomPainter {
  LearningShaderPainter(
    this.shader, {
    required this.config,
    required this.time,
    required this.mousePos,
  });

  final FragmentShader shader;
  final LearningShaderConfig config;
  final double time;
  final Offset mousePos;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, 1);
    shader.setFloat(3, 0);
    shader.setFloat(4, 0);
    shader.setFloat(5, time);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant LearningShaderPainter oldDelegate) {
    return oldDelegate.shader != shader ||
        oldDelegate.config != config ||
        oldDelegate.time != time ||
        oldDelegate.mousePos != mousePos;
  }
}
