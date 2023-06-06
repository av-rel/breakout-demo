package game;

import sdl "vendor:sdl2";

state := State {
	width  	= 960,
	height 	= 540,
	active 	= true,
	dt	   	= 1.0/60.0,
	keys 	= sdl.GetKeyboardState(nil),
};

render :: proc() {
	_ = sdl.SetRenderDrawColor(state.ren, 0x16, 0x16, 0x16, 0x16);
	_ = sdl.RenderClear(state.ren);

	paddle_render();
	ball_render();

	sdl.RenderPresent(state.ren);
}

update :: proc(dt : f32) {
	for event:sdl.Event; sdl.PollEvent(&event); {
		#partial switch event.type {
			case .QUIT: state.active = false;
		}
	}

	if state.keys[sdl.SCANCODE_SPACE] != 0 && !state.started { state.started = true; }
	if state.over { reset(); }

	paddle_update(dt);
	ball_update(dt);

	sdl.Delay(1000/60);
}

reset :: proc () {
	state.over = false
	state.started = false

	paddle_rect = sdl.Rect {
		x = (state.width - state.width/10)/2,
		y = (state.height - state.height/30) - i32(f32(state.height) * 0.07),
		w = state.width/10,
		h = state.height/40,
	};

	ball_rect = sdl.Rect {
		x = paddle_rect.x + paddle_rect.w/2,
		y = paddle_rect.y - paddle_rect.h,
		w = (paddle_rect.w + paddle_rect.h)/10,
		h = (paddle_rect.w + paddle_rect.h)/10,
	};
	ball_dx = -1;
	ball_dy = -1;
}

State :: struct {
	width, height : i32,
	win 	: ^sdl.Window,
	ren 	: ^sdl.Renderer,
	active 	: bool,
	dt 		: f32,
	keys	: [^]u8,
	started, over : bool,
}
