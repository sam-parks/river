// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/material.dart';

import 'river_shader_config.dart';

class RiverShaderPainter extends CustomPainter {
  RiverShaderPainter(
    this.shader, {
    required this.config,
    required this.time,
    required this.mousePos,
  });
  final FragmentShader shader;
  final RiverShaderConfig config;
  final double time;
  final Offset mousePos;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant RiverShaderPainter oldDelegate) {
    return oldDelegate.shader != shader ||
        oldDelegate.config != config ||
        oldDelegate.time != time ||
        oldDelegate.mousePos != mousePos;
  }
}
