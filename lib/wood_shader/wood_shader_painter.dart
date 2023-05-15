// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/material.dart';

import 'wood_shader_config.dart';

class WoodShaderPainter extends CustomPainter {
  WoodShaderPainter(
    this.shader, {
    required this.config,
    required this.time,
    required this.mousePos,
  });

  final FragmentShader shader;
  final WoodShaderConfig config;
  final double time;
  final Offset mousePos;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, config.uLightColor.red / 255);
    shader.setFloat(3, config.uLightColor.green / 255);
    shader.setFloat(4, config.uLightColor.blue / 255);
    shader.setFloat(5, config.uDarkColor.red / 255);
    shader.setFloat(6, config.uDarkColor.green / 255);
    shader.setFloat(7, config.uDarkColor.blue / 255);
    shader.setFloat(8, config.uFrequency);
    shader.setFloat(9, config.uNoiseScale);
    shader.setFloat(10, config.uRingScale);
    shader.setFloat(11, config.uContrast);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant WoodShaderPainter oldDelegate) {
    return oldDelegate.shader != shader ||
        oldDelegate.config != config ||
        oldDelegate.time != time ||
        oldDelegate.mousePos != mousePos;
  }
}
