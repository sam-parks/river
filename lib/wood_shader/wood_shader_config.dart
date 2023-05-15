import 'dart:ui';

class WoodShaderConfig {
  const WoodShaderConfig({
    this.uLightColor = const Color(0xffbb905d),
    this.uDarkColor = const Color(0xff7d490b),
    this.uFrequency = 2.0,
    this.uNoiseScale = 6.0,
    this.uRingScale = 0.6,
    this.uContrast = 3.0,
  });

  final Color uLightColor;
  final Color uDarkColor;

  final double uFrequency;
  final double uNoiseScale;
  final double uRingScale;
  final double uContrast;

  WoodShaderConfig copyWith({
    Color? uLightColor,
    Color? uDarkColor,
    double? uFrequency,
    double? uNoiseScale,
    double? uRingScale,
    double? uContrast,
  }) {
    return WoodShaderConfig(
      uLightColor: uLightColor ?? this.uLightColor,
      uDarkColor: uDarkColor ?? this.uDarkColor,
      uFrequency: uFrequency ?? this.uFrequency,
      uNoiseScale: uNoiseScale ?? this.uNoiseScale,
      uRingScale: uRingScale ?? this.uRingScale,
      uContrast: uContrast ?? this.uContrast,
    );
  }
}
