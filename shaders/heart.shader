shader_type spatial;

uniform vec4 heart_color : hint_color;
uniform float bloat = 1.0f;
uniform float squish : hint_range(0.0f, 1.0f);
uniform vec3 squish_dir = vec3(0.0f, 1.0f, 0.0f);
uniform vec3 offset = vec3(1.0f, 0.9f, 0.0f);

void fragment() {
	ALBEDO = heart_color.rgb;
}

void vertex() {
	VERTEX = VERTEX * bloat;
	mat3 world = mat3(WORLD_MATRIX);
	mat3 inv_world = mat3(inverse(WORLD_MATRIX));
	mat3 scale = mat3(vec3(1.0f + 0.2f * squish, 0.0f, 0.0f), vec3(0.0f, 1.0f - 0.5f * squish, 0.0f), vec3(0.0f, 0.0f, 1.0f + 0.2f * squish));
	//VERTEX = inv_world * ((scale * world * VERTEX) + vec3(0.02f * squish, -0.12f * squish, 0.0f));
	vec3 scalevec = world * (VERTEX + offset);
	scalevec = scalevec - dot(scalevec, squish_dir) * 1.0 * squish * squish_dir;
	VERTEX = inv_world * scalevec - offset;
}