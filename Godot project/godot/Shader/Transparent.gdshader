shader_type canvas_item;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    color.a *= 0.5; // Adjust transparency (0.0 is fully transparent, 1.0 is fully opaque)
    COLOR = color;
}