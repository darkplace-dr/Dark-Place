return love.graphics.newShader([[
// tried and true
float edge_stretch_str = 1.5; // the higher the more stretched
float edge_stretch_lim = 1.5; // the higher the less stretched

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    texture_coords.x -= (texture_coords.x - .5) * edge_stretch_str * pow(abs(texture_coords.y - .5), edge_stretch_lim);
    return Texel(tex, texture_coords) * color;
}
]])