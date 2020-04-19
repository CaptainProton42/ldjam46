shader_type spatial;

uniform sampler2D texture_alpha : hint_albedo;
uniform vec4 color_active : hint_color;
uniform vec4 color_inactive : hint_color;
uniform bool active = true;

void fragment() {
	vec4 tex = texture(texture_alpha, UV);
	if (active) {
		ALBEDO = color_active.rgb;
	} else {
		ALBEDO = color_inactive.rgb;
	}
	ALPHA = tex.a;
}
