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

float band(float t, float start, float end, float blur) {
  float s1 = smoothstep(start - blur, start + blur, t);
  float s2 = smoothstep(end + blur, end - blur, t);

  return s1 * s2;
}

float rectangle(vec2 uv, float left, float right, 
    float bottom, float top, float blur) 
{
  float b1 = band(uv.x, left, right, blur);
  float b2 = band(uv.y, bottom, top, blur);
  return b1 * b2;
}

float rectangle(vec2 uv, vec2 lr, vec2 bt, float blur) {
  float b1 = band(uv.x, lr.x, lr.y, blur);
  float b2 = band(uv.y, bt.x, bt.y, blur);
  return b1 * b2;
}


void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  float t  = iTime;
  vec3 res = iResolution;
  vec2 fc  = fragCoord;

  vec2 uv = (fc * 2.0 - res.xy) / res.y;

  vec3 col = vec3(0.0);
  float mask = 0.0;

  float x = uv.x;
  float y = uv.y;
  x += y * -0.9;
  y *= 2.0;
  uv = vec2(x, y);

  // mask = rectangle(vec2(x, y), -0.2 + y * 0.2, 0.2, -0.3, 0.3, 0.01);

  vec2 lr = vec2(-0.5, 0.5);
  vec2 bt = vec2(-0.5, 0.5);
  mask = rectangle(uv, lr, bt, 0.01);

  uv = (fc * 2.0 - res.xy) / res.y;

  lr = vec2(-0.72, 0.26);
  bt = vec2(-0.255, 0.5);
  float rec = rectangle(uv, lr, bt, 0.01);

  // col += vec3(1.0, 1.0, 1.0) * mask + rec * vec3(1.0, 0.0, 0.0);
  col += vec3(1.0, 0.0, 0.0) * mask + rec * vec3(1.0, 0.0, 0.0);

  fragColor = vec4(col, 1.0);
}

