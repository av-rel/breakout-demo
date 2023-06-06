package game;

import sdl "vendor:sdl2";

paddle_speed :: 150;
paddle_rect := sdl.Rect {};

paddle_render :: proc () {
	sdl.SetRenderDrawColor(state.ren, 0xff, 0xff, 0xff, 0xff);
	sdl.RenderFillRect(state.ren, &paddle_rect);
}

paddle_update :: proc (dt : f32) {
	left	:= (state.keys[sdl.SCANCODE_A] != 0 || state.keys[sdl.SCANCODE_LEFT] != 0) && paddle_rect.x > 0;
	right	:= (state.keys[sdl.SCANCODE_D] != 0 || state.keys[sdl.SCANCODE_RIGHT] != 0) && paddle_rect.x + paddle_rect.w < state.width;

	if left {
		paddle_rect.x -= i32(f32(paddle_speed) * state.dt)
	}
	if right {
		paddle_rect.x += i32(f32(paddle_speed) * state.dt)
	}

}
