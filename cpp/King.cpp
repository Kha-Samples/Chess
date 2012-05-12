#include "stdafx.h"
#include "Chessman.h"

char King::getChar() {
	if (color->isWhite()) return 'k';
	return 'K';
}

bool King::isKing() {
	if (killed) return false;
	return true;
}

std::list<Move> King::moves() {
	std::list<Move> moves;

	Position newposition(position.getX(), position.getY() + 1);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() + 1, position.getY() + 1);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() + 1, position.getY());
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() + 1, position.getY() - 1);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX(), position.getY() - 1);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() - 1, position.getY() - 1);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() - 1, position.getY());
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() - 1, position.getY() + 1);
	if (chessboard->isFreeAt(newposition) || chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	return moves;
}

int King::value() {
	return 5000;
}