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

	paddle_update(dt);
	ball_update(dt);

	if state.keys[sdl.SCANCODE_SPACE] != 0  && !state.started {
		state.started = true;
	}
	sdl.Delay(1000/60);
}

State :: struct {
	width, height : i32,
	win 	: ^sdl.Window,
	ren 	: ^sdl.Renderer,
	active 	: bool,
	dt 		: f32,
	keys	: [^]u8,
	started	: bool,
	won		: bool,
	lost	: bool,
};
