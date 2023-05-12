// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

class AssetPaths {
  /// Shaders
  static const String _shaders = 'assets/shaders';
  static const String orbShader = '$_shaders/river_shader.frag';
}

typedef Shaders = ({FragmentShader river});

Future<Shaders> loadShaders() async =>
    (river: (await _loadShader(AssetPaths.orbShader)),);

Future<FragmentShader> _loadShader(String path) async {
  return (await FragmentProgram.fromAsset(path)).fragmentShader();
}
