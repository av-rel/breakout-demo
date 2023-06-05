package main;

import sdl "vendor:sdl2";
import "game";

main :: proc () {
	if sdl.Init(sdl.INIT_VIDEO | sdl.INIT_EVENTS) < 0 {
		sdl.LogCritical(-1, "%s", sdl.GetError());
		game.state.started = false;
	}
	defer sdl.Quit();

	if sdl.CreateWindowAndRenderer(
		game.state.width, game.state.height, sdl.WINDOW_SHOWN, &game.state.win, &game.state.ren
	) < 0 {
		sdl.LogCritical(-1, "%s", sdl.GetError());
		game.state.started = false;
	}
	defer sdl.DestroyWindow(game.state.win);
	defer sdl.DestroyRenderer(game.state.ren);

	for game.state.active {
		last := sdl.GetTicks();
		game.render();
		game.update(game.state.dt)
		game.state.dt = 1.0/f32(sdl.GetTicks() - last);
	}

}
