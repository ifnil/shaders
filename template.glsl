#ifdef GL_ES
precision mediump float;
#endif

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  float t  = iTime;
  vec3 res = iResolution;
  vec2 fc  = fragCoord;

  vec2 uv = (fc * 2.0 - res.xy) / res.y;

  vec3 color = vec3(50.0);
  fragColor = vec4(color, 1.0);
}

