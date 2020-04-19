shader_type spatial;
render_mode specular_toon;

uniform vec4 color : hint_color;

void fragment() {
	RIM = 0.2;
	ROUGHNESS = 0.01;
	METALLIC = 0.0;
	ALBEDO = color.rgb;
}