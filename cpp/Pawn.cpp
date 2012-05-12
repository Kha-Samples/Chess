#include "stdafx.h"
#include "Chessman.h"

char Pawn::getChar() {
	if (color->isWhite()) return 'p';
	return 'P';
}

std::list<Move> Pawn::moves() {
	std::list<Move> moves;

	int newy;
	if (color->isWhite()) newy = position.getY() - 1;
	else newy = position.getY() + 1;

	Position newposition(position.getX(), newy);
	if (chessboard->isFreeAt(newposition)) {
		moves.push_back(Move(this, newposition));

		if (color->isWhite() && position.getY() == 6) {
			newposition = Position(position.getX(), newy - 1);
			if (chessboard->isFreeAt(newposition)) moves.push_back(Move(this, newposition));
		}
		else if (color->isBlack() && position.getY() == 1) {
			newposition = Position(position.getX(), newy + 1);
			if (chessboard->isFreeAt(newposition)) moves.push_back(Move(this, newposition));
		}
	}

	newposition = Position(position.getX() + 1, newy);
	if (chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() - 1, newy);
	if (chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	return moves;
}

int Pawn::value() {
	return 10;
}