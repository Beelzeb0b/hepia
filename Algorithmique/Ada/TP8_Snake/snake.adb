with Ada.Calendar; use Ada.Calendar;
with pkg_ncurses; use pkg_ncurses;
with Text_Io; use Text_Io;

procedure snake is
	x,y   : integer := 0;
	max_x : integer;
	max_y : integer;
	dir_x : integer := 1;
	dir_y : integer := 0;
	quit  : boolean := false;
	color : positive := COLOR_YELLOW;
	key   : integer;

begin
	term_init;

	-- Retrieve the terminal's dimensions
	term_getsize(max_x,max_y);
	-- Initial position
	x := max_x/2;
	y := max_y/2;

	while not quit loop
		term_setcolor(COLOR_WHITE);
		term_print(0,0,"Position ("&Integer'Image(x)&","&Integer'Image(y)&") "&ASCII.nul);

		key := term_getchar;
		case key is
			-- left
			when ARROW_LEFT =>
				dir_x := -1;
				dir_y := 0;
				color := COLOR_BLUE;
				term_print(0,1,"key ("&Integer'Image(key)&")"&ASCII.nul);
			-- right
			when ARROW_RIGHT =>
				dir_x := 1;
				dir_y := 0;
				color := COLOR_YELLOW;
				term_print(0,1,"key ("&Integer'Image(key)&")"&ASCII.nul);
			-- up
			when ARROW_UP =>
				dir_x := 0;
				dir_y := -1;
				color := COLOR_MAGENTA;
				term_print(0,1,"key ("&Integer'Image(key)&")"&ASCII.nul);
			-- down
			when ARROW_DOWN =>
				dir_x := 0;
				dir_y := 1;
				color := COLOR_GREEN;
				term_print(0,1,"key ("&Integer'Image(key)&")"&ASCII.nul);
			-- quit
			when character'pos('q') =>
				quit := true;
			when others =>
				null;
		end case;

		term_setcolor(color);
		term_setreverse(1);
		term_print(x,y,"  "&ASCII.nul);
		term_setreverse(0);

		term_refresh;
		delay 0.1;

		x := x+dir_x*2;
		y := y+dir_y;
	end loop;

	term_close;

end snake;