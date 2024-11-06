shader_type canvas_item;

uniform float outline_thickness = 2.0; // hint_range(0.0, 5.0)
uniform vec4 outline_color = vec4(1.0, 0.0, 0.0, 1.0); // hint_color
uniform vec2 viewport_size; // This will be set from the script

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    
    // Check neighboring pixels for edges to apply outline
    float threshold = 0.1;
    float outline = 0.0;
    
    // Offsets for sampling pixels around the current one
    vec2 offsets[8] = vec2[](
        vec2(-outline_thickness / viewport_size.x, 0.0),
        vec2(outline_thickness / viewport_size.x, 0.0),
        vec2(0.0, -outline_thickness / viewport_size.y),
        vec2(0.0, outline_thickness / viewport_size.y),
        vec2(-outline_thickness / viewport_size.x, -outline_thickness / viewport_size.y),
        vec2(outline_thickness / viewport_size.x, -outline_thickness / viewport_size.y),
        vec2(-outline_thickness / viewport_size.x, outline_thickness / viewport_size.y),
        vec2(outline_thickness / viewport_size.x, outline_thickness / viewport_size.y)
    );
    
    // Check each offset position
    for (int i = 0; i < 8; i++) {
        vec4 neighbor_color = texture(TEXTURE, UV + offsets[i]);
        outline += step(threshold, neighbor_color.a - original_color.a);
    }
    
    if (outline > 0.0) {
        COLOR = outline_color; // Apply outline color
    } else {
        COLOR = original_color; // Use original color where there is no outline
    }
}
