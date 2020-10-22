float skylight = lmcoord.y * lmcoord.y * (1.0 - rainStrength * 0.5);
float blocklight = square(max(lmcoord.x - skylight * day * 0.5, 0.0));
float heldlight = 0.0;