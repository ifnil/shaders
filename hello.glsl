#ifdef GL_ES
precision mediump float;
#endif

float plot(vec2 st, float pct) {
  return smoothstep(pct - 0.01, pct, st.y) - smoothstep(pct, pct + 0.2, st.y);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  // normalize the coordinate space between 0.0 and 1.0
  vec2 st = (fragCoord * 4.0 - iResolution.xy * 2.0) / iResolution.y;
  // vec2 st = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
  // vec2 st = fragCoord / iResolution.xy;

  ///-----------------------------//--
  float y = sin(st.x + iTime * 4.0);
  float y1 = cos(st.x + iTime * 5.0);

  vec3 color = vec3(y);
  float pct = 0.0;

  pct += plot(st, y + -2.0);
  pct += plot(st, y + -1.0);
  pct += plot(st, y +  0.0);
  pct += plot(st, y +  1.0);
  pct += plot(st, y +  2.0);

  pct += plot(st, y1 + -2.0);
  pct += plot(st, y1 + -1.0);
  pct += plot(st, y1 +  0.0);
  pct += plot(st, y1 +  1.0);
  pct += plot(st, y1 +  2.0);
  ///-----------------------------//--

  float d = length(abs(st) - 0.3) + iTime / 4.0;
  color = vec3(fract(d * 10.0));
  color = (1.0 - pct) * color + pct * vec3(0.0, 1.0, 0.0);

  fragColor = vec4(color, 1.0);
}
