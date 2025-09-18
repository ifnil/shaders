#ifdef GL_ES
precision mediump float;
#endif

float circle(vec2 uv, vec2 p, float r, float blur) {
  float d = length(uv - p);
  return smoothstep(r, r-blur, d);
}

vec2 rotate(vec2 v, float a) {
  float s = sin(a);
  float c = cos(a);
  mat2 m = mat2(c, s, -s, c);
  return m * v;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  float t  = iTime;
  vec3 res = iResolution;
  vec2 fc  = fragCoord;

  vec2 uv = (fc * 2.0 - res.xy) / res.y;
  uv = rotate(uv, -1.5);

  vec3 mask = vec3(0.0);
  mask += vec3(circle(uv, vec2(0.0), 0.5, 0.02));

  float eyes = 0.0;
  eyes -= circle(uv, vec2(-0.2, 0.2), 0.05, 0.01);
  eyes -= circle(uv, vec2(0.2, 0.2), 0.05, 0.01);

  float mouth = 0.0;
  mouth += circle(uv, vec2(-0.15, -0.02), 0.15, 0.01);
  mouth -= circle(uv, vec2(-0.15, 0.01), 0.15, 0.01);
  mouth += circle(uv, vec2(0.14, -0.02), 0.15, 0.01);
  mouth -= circle(uv, vec2(0.14, 0.01), 0.15, 0.01);

  mask -= mouth - eyes;
  vec3 col = vec3(1.0) * mask;

  fragColor = vec4(col, 1.0);
}

