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

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  float t  = iTime;
  vec3 res = iResolution;
  vec2 fc  = fragCoord;

  vec2 uv = (fc * 2.0 - res.xy) / res.y;
  
  float m = sin(uv.x * 8.0 + t) / 8.0;

  float x = uv.x;
  float y = uv.y + -x*x*1.6;

  vec3 color = vec3(0.0, 0.4, 0.45);

  vec2 lr = vec2(0.7, 0.701);
  vec2 tb = vec2(0.2, 0.201);

  float b1 = smoothstep( lr.x,  lr.y, x);
  float b2 = smoothstep(-lr.x, -lr.y, x);
  float b3 = smoothstep( tb.x,  tb.y, y);
  float b4 = smoothstep(-tb.x, -tb.y, y);
  float rect = b1 + b2 + b3 + b4;
  color += rect;

  // x = uv.x;
  // y = uv.y;
  //
  // float w = sin(uv.x * 8.0 + t) / 8.0;
  // float wx = smoothstep(w, w + 0.008, y);
  // float wy = smoothstep(w - 0.008, w, y);
  // float ww = wy - wx;
  // color += vec3(ww + rect);

  fragColor = vec4(color, 1.0);
}
