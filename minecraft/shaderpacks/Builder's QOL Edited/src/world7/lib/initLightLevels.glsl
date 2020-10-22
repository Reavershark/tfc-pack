float skylight = lmcoord.y * lmcoord.y;
float blocklight = square(max(lmcoord.x - skylight * 0.5, 0.0));
float heldlight = 0.0;