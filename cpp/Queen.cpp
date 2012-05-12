#include "stdafx.h"
#include "Chessman.h"

char Queen::getChar() {
	if (color->isWhite()) return 'q';
	return 'Q';
}

std::list<Move> Queen::moves() {
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

	newposition = Position(position.getX() + 1, position.getY());
	while (chessboard->isFreeAt(newposition)) {
		moves.push_back(Move(this, newposition));
		newposition = Position(newposition.getX() + 1, newposition.getY());
	}
	if (chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX() - 1, position.getY());
	while (chessboard->isFreeAt(newposition)) {
		moves.push_back(Move(this, newposition));
		newposition = Position(newposition.getX() - 1, newposition.getY());
	}
	if (chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX(), position.getY() + 1);
	while (chessboard->isFreeAt(newposition)) {
		moves.push_back(Move(this, newposition));
		newposition = Position(newposition.getX(), newposition.getY() + 1);
	}
	if (chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	newposition = Position(position.getX(), position.getY() - 1);
	while (chessboard->isFreeAt(newposition)) {
		moves.push_back(Move(this, newposition));
		newposition = Position(newposition.getX(), newposition.getY() - 1);
	}
	if (chessboard->hasDifferentColorThan(color, newposition)) moves.push_back(Move(this, newposition));

	return moves;
}

int Queen::value() {
	return 90;
}