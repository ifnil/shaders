#ifdef GL_ES
precision mediump float;
#endif

vec2 N22(vec2 p) {
  vec3 a = fract(p.xyx * vec3(123.34, 234.34, 345.65));
  a += dot(a, a + 34.45);
  return fract(vec2(a.x * a.y, a.y * a.z));
}

float naive(vec2 uv, float t) {
  float mdist = 100.0;
  float cidx  = 0.0;
  float m     = 0.0;

  for (float i = 0.0; i < 50.0; i++) {
    vec2 n = N22(vec2(i));
    vec2 p = sin(n * t);
    float d = length(uv - p);

    m += smoothstep(0.02, 0.01, d);

    if (d < mdist) {
      mdist = d;
      cidx = i;
    }
  }

  // return m + mdist;
  // return mdist;
  return cidx;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  float t  = iTime;
  vec3 res = iResolution;
  vec2 fc  = fragCoord;

  vec2 uv = (fc * 2.0 - res.xy) / res.y;

  // vec3 color = vec3(naive(uv, t) / 50.0) + vec3(N22(uv).xyx * 0.2);
  // vec3 color = vec3(naive(uv, t)) + vec3(N22(uv).xyx * 0.2);
  // vec3 color = vec3(naive(uv, t));

  vec3 color = vec3(naive(uv, t) / 50.0);
  fragColor = vec4(color, 1.0);
}

