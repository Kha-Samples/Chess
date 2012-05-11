#ifndef CHESSPLAYER_HEADER
#define CHESSPLAYER_HEADER

#include "Color.h"
#include "Chessboard.h"
#include "Move.h"

class Chessplayer {
protected:
	Chessboard* chessboard;
	Color* color;
public:
	Chessplayer(Chessboard* aChessboard, Color* aColor) : chessboard(aChessboard), color(aColor) { }
	//fordert den Spieler freundlich dazu auf, gefälligst seinen nächsten Zug auszuführen
	virtual void move() = 0;
};

class HumanChessplayer : public Chessplayer {
public:
	HumanChessplayer(Chessboard* aChessboard, Color* aColor) : Chessplayer(aChessboard, aColor) { }
	void move();
};

class ComputerChessplayer : public Chessplayer {
	int maxdepth;
public:
	ComputerChessplayer(Chessboard* aChessboard, Color* aColor, int maxdepth) : Chessplayer(aChessboard, aColor), maxdepth(maxdepth) { }
	void move();
	int alphaBeta(int depth, int al, int beta, Color* aColor);
	std::list<Move> collectMoves(Color* aColor);
	int heuristic(Color* aColor);
	int maxOf(int aValue, int anotherValue);
	int minOf(int aValue, int anotherValue);
};

#endif