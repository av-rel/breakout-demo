package game;

import sdl "vendor:sdl2";

ball_speed :: 120;
ball_dx := -1;
ball_dy := -1;
ball_rect := sdl.Rect {
	x = paddle_rect.x + paddle_rect.w/2,
	y = paddle_rect.y - paddle_rect.h,
	w = (paddle_rect.w + paddle_rect.h)/10,
	h = (paddle_rect.w + paddle_rect.h)/10,
};

ball_render :: proc () {
	shape_render_circle(state.ren, ball_rect.x, ball_rect.y, ball_rect.w)
}

ball_update :: proc (dt : f32) {
	if !state.started {
		ball_rect.x = paddle_rect.x + paddle_rect.w/2;
		ball_rect.y = paddle_rect.y - paddle_rect.h;
		return
	}

	if ball_rect.x < 0 || ball_rect.x + ball_rect.w > state.width {
		ball_dx *= -1;
	}
	if ball_rect.y < 0 || ball_rect.y + ball_rect.h > state.height {
		ball_dy *= -1;
	}
	if sdl.HasIntersection(&paddle_rect, &ball_rect) {
		ball_dy *= -1;
	}

	ball_rect.x = ball_rect.x + i32(f32(ball_speed * ball_dx) * dt);
	ball_rect.y = ball_rect.y + i32(f32(ball_speed * ball_dy) * dt);;

}
