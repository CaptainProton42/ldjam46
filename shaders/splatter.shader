shader_type spatial;
render_mode specular_toon;

uniform float size : hint_range(0.0f, 2.0f);
uniform float alpha : hint_range(0.0f, 1.0f);
uniform vec4 color : hint_color;

void vertex() {
	VERTEX = size * VERTEX;
}

void fragment() {
	RIM = 0.2;
	ROUGHNESS = 0.01;
	METALLIC = 0.0;
	ALBEDO = color.rgb;
	ALPHA = alpha;
}