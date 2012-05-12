#ifndef CHESSMAN_HEADER
#define CHESSMAN_HEADER

#include "Chessboard.h"
#include "Position.h"
#include "Color.h"
#include "Move.h"

#include <list>

class Chessman {
protected:
	Position position;
	Chessboard* chessboard;
	Color* color;
	bool killed;
public:
	//für die Ausgabe
	virtual char getChar() = 0;

	Color* getColor() {
		return color;
	}
	
	Chessman(Position aPosition, Color* aColor, Chessboard* aChessboard) : position(aPosition), color(aColor), chessboard(aChessboard), killed(false) { }

	bool isAlive() {
		return !killed;
	}

	virtual bool isKing() {
		return false;
	}

	void kill() {
		killed = true;
	}

	//da macht sich die Schachfigur auf zu einer neuen Position und wenn sie die Gelegenheit dazu bekommt,
	//rämpelt sie dabei gleich noch jemanden um
	Move move(Position aPosition) {
		chessboard->putat(position, NULL);
		Chessman* oldman = chessboard->putat(aPosition, this);
		if (oldman != NULL) oldman->kill();
		Move remove(this, position, oldman);
		position = aPosition;
		return remove;
	}

	//gibt alle möglichen Bewegungen der Schachfigur zurück
	virtual std::list<Move> moves() = 0;

	Position getPosition() {
		return position;
	}

	void revive() {
		chessboard->putat(position, this);
		killed = false;
	}

	//gibt einen Wert für die Heuristik zurück
	virtual int value() = 0;
};

class Bishop : public Chessman {
public:
	Bishop(Position aPosition, Color* aColor, Chessboard* aChessboard) : Chessman(aPosition, aColor, aChessboard) { }
	char getChar();
	std::list<Move> moves();
	int value();
};

class King : public Chessman {
public:
	King(Position aPosition, Color* aColor, Chessboard* aChessboard) : Chessman(aPosition, aColor, aChessboard) { }
	char getChar();
	bool isKing();
	std::list<Move> moves();
	int value();
};

class Knight : public Chessman {
public:
	Knight(Position aPosition, Color* aColor, Chessboard* aChessboard) : Chessman(aPosition, aColor, aChessboard) { }
	char getChar();
	std::list<Move> moves();
	int value();
};

class Pawn : public Chessman {
public:
	Pawn(Position aPosition, Color* aColor, Chessboard* aChessboard) : Chessman(aPosition, aColor, aChessboard) { }
	char getChar();
	std::list<Move> moves();
	int value();
};

class Queen : public Chessman {
public:
	Queen(Position aPosition, Color* aColor, Chessboard* aChessboard) : Chessman(aPosition, aColor, aChessboard) { }
	char getChar();
	std::list<Move> moves();
	int value();
};

class Rook : public Chessman {
public:
	Rook(Position aPosition, Color* aColor, Chessboard* aChessboard) : Chessman(aPosition, aColor, aChessboard) { }
	char getChar();
	std::list<Move> moves();
	int value();
};

#endif