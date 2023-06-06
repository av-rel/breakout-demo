package game;

import sdl "vendor:sdl2";

ball_speed :: 120;
ball_dx := -1;
ball_dy := -1;
ball_rect := sdl.Rect {};

ball_render :: proc () {
	render_circle(state.ren, ball_rect.x, ball_rect.y, ball_rect.w)
}

ball_update :: proc (dt : f32) {
	if !state.started {
		ball_rect.x = paddle_rect.x + paddle_rect.w/2;
		ball_rect.y = paddle_rect.y - paddle_rect.h;
		return
	}

	if ball_rect.x < 0  {
		ball_dx *= -1;
		ball_rect.x = 0;
	} else if ball_rect.x > state.width - ball_rect.w {
		ball_dx *= -1;
		ball_rect.x = state.width - ball_rect.w;
	}

	if ball_rect.y < 0 {
		ball_dy *= -1;
		ball_rect.y = 0;
	} else if ball_rect.y > state.height - ball_rect.h {
		state.over = true;
		ball_rect.y = state.height - ball_rect.h;
	}

	intersection := block_has_intersect(&paddle_rect, &ball_rect);
	if (intersection == -1 && ball_dx == 1) || (intersection == 1 && ball_dx == -1) { ball_dx *= -1; }
	if intersection != 0 { ball_dy *= -1; }

	ball_rect.x = ball_rect.x + i32(f32(ball_speed * ball_dx) * dt);
	ball_rect.y = ball_rect.y + i32(f32(ball_speed * ball_dy) * dt);;
}

