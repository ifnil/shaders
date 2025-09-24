#ifdef GL_ES
precision mediump float;
#endif

float noise21(in vec2 uv) {
  float s = uv.x * 100.0 + uv.y * 8098.0;
  float c = fract(sin(s) * 4987.0);

  return c;
}

float smooth_noise(vec2 uv) {
  vec2 lv = fract(uv);
  vec2 id = floor(uv);

  lv = lv * lv * (3.0 - 2.0 * lv);

  float bl = noise21(id);
  float br = noise21(id + vec2(1.0, 0.0));
  float b = mix(bl, br, lv.x);

  float tl = noise21(id + vec2(0.0, 1.0));
  float tr = noise21(id + vec2(1.0, 1.0));
  float tm = mix(tl, tr, lv.x);

  return mix(b, tm, lv.y);
}

float smooth_octaves(vec2 uv) {
  float c = smooth_noise(uv * 4.0);
  c += smooth_noise(uv * 8.0)  * 0.5;
  c += smooth_noise(uv * 16.0) * 0.25;
  c += smooth_noise(uv * 32.0) * 0.125;
  c += smooth_noise(uv * 65.0) * 0.0625;
  c /= 2.0;

  return c;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  float t  = iTime;
  vec3 res = iResolution;
  vec2 fc  = fragCoord;

  vec2 uv = (fc * 2.0 - res.xy) / res.y;

  vec3 color = vec3(0.0);

  uv.x += t;
  float f1 = sin(uv.x * 2.0 + t) / 4.0;
  float c = smooth_octaves(uv * 10.0);
  c += f1;
  
  float p = smoothstep(c - 0.1, c, uv.y) - smoothstep(c, c + 1.0, uv.y);

  color = vec3(p);

  fragColor = vec4(color, 1.0);
}

