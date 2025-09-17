#ifdef GL_ES
precision mediump float;
#endif

float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))
                 * 43758.5453123);
}

// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    // Smooth Interpolation

    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f*f*(3.0-2.0*f);
    // u = smoothstep(0.,1.,f);

    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

float plot(vec2 st, float pct) {
  return smoothstep(pct - 0.01, pct, st.y) - smoothstep(pct, pct + 0.05, st.y);
}

vec3 rgb(int r, int g, int b) {
  vec3 p = vec3(float(r), float(g), float(b));
  return normalize(p);
}

// 2D noise
float noise2d(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// 1D noise
float noise1d(float v){
  return cos(v + cos(v * 90.1415) * 100.1415) * 0.5 + 0.5;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  float t  = iTime;
  vec3 res = iResolution;
  vec2 fc  = fragCoord;

  vec2 st = (fc * 4.0 - res.xy * 2.0) / res.y;
  // vec2 st = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
  // vec2 st = fragCoord / iResolution.xy;

  vec3 color = vec3(0.0);
  float f1 = sin(st.x + iTime);
  float pct = plot(st, f1);

  color = pct * rgb(231, 160, 167) - rgb(169, 242, 255);

  // float f2 = noise2d(st) * st.x + f1;
  float f2 = noise(st) * st.x + f1;
  pct = plot(st, f2);
  color += pct * rgb(231, 71, 167);

  // float f3 = noise1d(st.x * 2.0 + t) + f1;
  float f3 = noise(st) + f1;
  pct = plot(st, f3);
  color += pct * rgb(232, 97, 76);

  fragColor = vec4(color, 1.0);
}
