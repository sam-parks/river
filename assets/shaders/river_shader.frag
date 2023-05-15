
#version 460 core

#include <flutter/runtime_effect.glsl>

#define RAY_STEPS 30

uniform vec2 uResolution;
uniform vec4 uPackedData;
float uTime = uPackedData[0];

out vec4 oColor;

void main() {
  vec2 st = gl_FragCoord.xy / uResolution.xy;
  vec3 color = vec3(0.0);

  // Add noise to the position
  float noise = 0.5 * (sin(uTime * 0.5) + 1.0);
  st += vec2(noise, 0.0);

  // Create waves with sine functions
  float wave1 = 0.05 * sin(st.x * 5.0 + uTime * 0.5);
  float wave2 = 0.1 * sin(st.x * 20.0 + uTime * 0.2);
  float wave3 = 0.15 * sin(st.x * 10.0 + uTime * 0.8);

  // Combine waves and add color
  float wave = wave1 + wave2 + wave3;
  color += vec3(1.0, 1.0, 1.0) * (0.4 - abs(wave));

  // Add foam to the peaks of the waves
  float foam = smoothstep(1.0, 0.5, abs(wave));
  color += vec3(0.0, 0.0, 1.0) * foam;

  // Output final color
  oColor = vec4(color, 1.0);
}