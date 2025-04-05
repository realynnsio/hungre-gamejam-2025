shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}
uniform float alpha = 1.0; // you can assign a default value to uniforms

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = texture(TEXTURE, UV); // Read from texture
  	if (COLOR.a > 0.0) {
		COLOR += vec4(1, 0, 0, 0);
		float opacity = 1.0 - alpha;
		COLOR -= vec4(opacity, 0, 0, 0);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
