shader_type canvas_item;

uniform vec4 base_color: source_color;

void fragment() {
	vec3 fog_color_1 = texture(TEXTURE, vec2(UV.x / 5.0 + TIME / 200.0, UV.y / -8.0 - TIME / 80.0)).rgb;
	vec3 fog_color_2 = texture(TEXTURE, vec2(UV.x / 12.0 + TIME / 50.0, UV.y / - 5.0 - TIME / 60.0)).rgb;
	vec3 fog_color = mix(fog_color_1, fog_color_2, 0.5);
	COLOR.a *= base_color.a * fog_color.r * 1.5;
	COLOR.rgb = fog_color * base_color.rgb;
}