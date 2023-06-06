package game;

import sdl "vendor:sdl2";

block_has_intersect :: proc (base, obj : ^sdl.Rect) -> i32 {
	if sdl.HasIntersection(
		&sdl.Rect{ x = base.x, y = base.y, w = base.w/2, h = base.h }, obj
	) { return -1; }
	else if sdl.HasIntersection(
		&sdl.Rect{ x = base.x + base.w/2, y = base.y, w = base.w/2, h = base.h }, obj
	) { return 1; }
	else { return 0; }
}

get_color :: proc (color : u32, bit : u8) -> u8 {
	return u8((color >> (8 * bit)) & 0xFF);
}

render_circle :: proc(ren : ^sdl.Renderer, cx, cy, r : i32, color : u32 = 0xFFFFFFFF) {
	sdl.SetRenderDrawColor(state.ren, get_color(color, 3), get_color(color, 2), get_color(color, 1), get_color(color, 0));

	for y := (cy - r); y <= (cy + r); y += 1 {
		dy := y - cy;
        for x := (cx - r); x <= (cx + r); x += 1 {
			dx := x - cx
			if (dx*dx) + (dy*dy) <= (r*r) {
				sdl.RenderDrawPoint(state.ren, x, y);
			}
        }
	}
}
