shader_type canvas_item;

uniform sampler2D tex;
uniform float speed:hint_range(0.0, 5.0, 0.01) = 1.0;

void fragment() {
	COLOR = texture(tex,vec2(UV.x-TIME*speed,UV.y ));
}

