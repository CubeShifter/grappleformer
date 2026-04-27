shader_type canvas_item;
uniform bool enabled = false;


void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (enabled && (COLOR.a == 1.0)){
		COLOR = vec4(1.0,1.0,1.0,1.0);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
