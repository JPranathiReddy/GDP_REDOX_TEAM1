shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, vec2(UV.x, UV.y - TIME * 0.03));
}


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
