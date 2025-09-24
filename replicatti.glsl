#ifdef GL_ES
precision mediump float;
#endif

// goal is to blind replicate this 
// https://substack-post-media.s3.amazonaws.com/public/images/a38ec24b-c356-4521-9448-84d7f35823ec_2400x675.png


void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  float t  = iTime;
  vec3 res = iResolution;
  vec2 fc  = fragCoord;

  vec2 uv = (fc * 2.0 - res.xy) / res.y;
  vec3 color = vec3(50.0);



  fragColor = vec4(color, 1.0);
}

