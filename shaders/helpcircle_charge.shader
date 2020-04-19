shader_type spatial;

uniform sampler2D texture_alpha : hint_albedo;
uniform vec4 color_active : hint_color;
uniform vec4 color_inactive : hint_color;
uniform bool active = true;

const float PI = 3.14159265358979323846;
uniform float fill : hint_range(0.0f, 1.0f);

void fragment() {
	vec4 tex = texture(texture_alpha, UV);
	if (active) {
		ALBEDO = color_active.rgb;
	} else {
		ALBEDO = color_inactive.rgb;
	}
	ALPHA = tex.a;
	vec2 centered_uv = 2.0f * UV - 1.0f;
	float phi = acos(dot(centered_uv, vec2(0.0f, -1.0f)) / length(centered_uv));
	if (centered_uv.x >= 0.0f) // right
	{
		phi = 2.0 * PI - phi;
	}
	if (phi >= fill * 2.0f * PI) ALPHA *= 0.0f;
}
