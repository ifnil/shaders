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

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  // normalize the coordinate space between 0.0 and 1.0
  vec2 st = (fragCoord * 4.0 - iResolution.xy * 2.0) / iResolution.y;
  // vec2 st = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
  // vec2 st = fragCoord / iResolution.xy;

  ///-----------------------------//--
  float y = sin(st.x + iTime);
  // y = sin(st.x * 6.0 + iTime) + y;

  vec3 color = vec3(y);
  float pct = plot(st, y);

  color = pct * vec3(0.0, 1.0, 0.0);

  // sin(x * 10 + t) / 2 + F(x, t)
  float px = sin(st.x * 10.0 + iTime)/2.0 + y;
  pct = plot(st, px);
  // color += pct * vec3(0.169, 0.749, 0.655);
  // color += pct * normalizeRGB(vec3(231.0, 71.0, 167.0));
  color += pct * rgb(231, 71, 167);

  fragColor = vec4(color, 1.0);
}
