#ifndef CHESSBOARD_HEADER
#define CHESSBOARD_HEADER

#include "Position.h"
#include "Color.h"

#include <list>

class Chessplayer;
class Chessman;

class Chessboard {
private:
	Chessman* board[8][8];
	Chessplayer* whiteplayer;
	Chessplayer* blackplayer;
	std::list<Chessman*> white, black;
public:
	Chessman* at(Position aPosition);
	Chessman* putat(Position aPosition, Chessman* aChessman);
	void create(int type, int x, int y, Color* color);
	void draw();
	std::list<Chessman*> getChessmen(Color* aColor);
	std::list<Chessman*> getChessmenNotIn(Color* aColor);
	bool hasDifferentColorThan(Color* aColor, Position aPosition);
	bool hasWon(Color* aColor);
	Chessboard();
	bool isFreeAt(Position aPosition);
	Color* play();
};

#endif