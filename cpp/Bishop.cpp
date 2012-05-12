#include "stdafx.h"
#include "Chessman.h"

char Bishop::getChar() {
	if (color->isWhite()) return 'b';
	return 'B';
}

//Läufer
std::list<Move> Bishop::moves() {
	std::list<Move> moves;

	Position newposition(position.getX() + 1, position.getY() + 1);
	while (chessboard->isFreeAt(newposition)) {
		moves.push_back(Move(this, newposition));
		newposition = Position(newposition.getX() + 1, newposition.getY() + 1);
	}
	if (chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() + 1, position.getY() - 1);
	while (chessboard->isFreeAt(newposition)) {
		moves.push_back(Move(this, newposition));
		newposition = Position(newposition.getX() + 1, newposition.getY() - 1);
	}
	if (chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() - 1, position.getY() + 1);
	while (chessboard->isFreeAt(newposition)) {
		moves.push_back(Move(this, newposition));
		newposition = Position(newposition.getX() - 1, newposition.getY() + 1);
	}
	if (chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() - 1, position.getY() - 1);
	while (chessboard->isFreeAt(newposition)) {
		moves.push_back(Move(this, newposition));
		newposition = Position(newposition.getX() - 1, newposition.getY() - 1);
	}
	if (chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	return moves;
}

int Bishop::value() {
	return 30;
}