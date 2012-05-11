#include "stdafx.h"
#include "Chessman.h"

char Knight::getChar() {
	if (color->isWhite()) return 'n';
	return 'N';
}

//Springer
std::list<Move> Knight::moves() {
	std::list<Move> moves;
	
	Position newposition(position.getX() - 1, position.getY() + 2);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() + 1, position.getY() + 2);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() + 2, position.getY() + 1);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() + 2, position.getY() - 1);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() + 1, position.getY() - 2);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() - 1, position.getY() - 2);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() - 2, position.getY() - 1);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() - 2, position.getY() + 1);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	return moves;
}

int Knight::value() {
	return 30;
}