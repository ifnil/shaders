vec2 p = (FC.xy*2.-r) / r.y;
float d = 0.7 - dot(p, p); 
o = tanh(.2*(cos(3.0 * (d - p.y) - vec4(6, 1, 2, 0)) + 2.) / sqrt(max(d, -d/.1)));
