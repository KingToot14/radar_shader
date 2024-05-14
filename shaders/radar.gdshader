shader_type canvas_item;

// --- Constants --- //
const float TWO_PI = 6.28318530718;

// --- Uniforms --- //
uniform float speed: hint_range(0.0, 10.0, 0.1) = 2.0;
group_uniforms line;
uniform vec4 line_color: source_color = vec4(0.0, 1.0, 1.0, 0.85);
group_uniforms trail;
uniform vec4 trail_color: source_color = vec4(0.0, 1.0, 1.0, 0.20);
uniform float trail_length: hint_range(0.0, 1.0, 0.1) = 0.10;

// --- Functions --- //
vec2 rotate(vec2 _pos, float _angle) {
	return vec2(_pos.x * cos(_angle) - _pos.y * sin(_angle), _pos.x * sin(_angle) + _pos.y * cos(_angle));
}

void fragment() {
	vec2 pos = rotate(UV - 0.5, -TIME * speed);
	
	float angle = (atan(pos.y, pos.x) + PI) / TWO_PI;
	float len = step(0.5, 1.0 - distance(pos, vec2(0.0)));
	COLOR *= trail_color;
	COLOR.a *= smoothstep(1.0 - trail_length, 1.0, angle);
	COLOR = mix(COLOR, line_color, step(0.998, angle));
	COLOR *= len;
}
