#ifdef GL_ES
precision mediump float;
#endif

float plot(vec2 st, float pct) {
  return smoothstep(pct - 0.01, pct, st.y) - smoothstep(pct, pct + 0.05, st.y);
}

vec3 rgb(int r, int g, int b) {
  vec3 p = vec3(float(r), float(g), float(b));
  return normalize(p);
}

vec2 N22(vec2 p) {
  vec3 a = fract(p.xyx * vec3(123.34, 234.34, 345.65));
  a += dot(a, a + 34.45);
  return fract(vec2(a.x * a.y, a.y * a.z));
}

float circle(vec2 uv, vec2 p, float r, float blur) {
  float d = length(uv - p);
  return smoothstep(r, r - blur, d);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  float t  = iTime;
  vec3 res = iResolution;
  vec2 fc  = fragCoord;

  vec2 uv = (fc * 2.0 - res.xy) / res.y;
  vec3 color = vec3(0.0);

  float x = uv.x;
  float y = uv.y;

  float p = (x * x * mod(t, 2.0));
  for (float i = 0.0; i < 10.0; i++) {
    color += vec3(plot(uv, p + i));
  }

  fragColor = vec4(color, 1.0);
}

