shader_type spatial;

varying vec3 pos;

void vertex() {
	pos = (MODEL_MATRIX* vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	ALBEDO = vec3(pos.y*10.0,pos.y*10.0,pos.y*10.5);
}

