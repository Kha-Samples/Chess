#include "stdafx.h"
#include "Chessboard.h"
#include "Chessplayer.h"
#include "Chessman.h"

int ComputerChessplayer::alphaBeta(int depth, int al, int beta, Color* aColor) {
	if (depth == 0) return heuristic(aColor);
	int alpha = al;
	std::list<Move> moves = collectMoves(aColor);
	//if (moves.size() == 0) return heuristic(aColor);
	for (std::list<Move>::iterator it = moves.begin(); it != moves.end(); ++it) {
		Move oldmove = it->execute();
		int value = -alphaBeta(depth - 1, -beta, -alpha, aColor->other());
		oldmove.execute();
		if (value >= beta) return beta;
		if (value > alpha) alpha = value;
	}
	return alpha;
}

//erstellt eine OrderedCollection, die alle für den Spieler möglichen Züge enthält
std::list<Move> ComputerChessplayer::collectMoves(Color* aColor) {
	std::list<Move> moves;
	std::list<Chessman*> men = chessboard->getChessmen(aColor);
	for (std::list<Chessman*>::iterator it = men.begin(); it != men.end(); ++it) {
		if ((*it)->isAlive()) {
			std::list<Move> newmoves = (*it)->moves();
			for (std::list<Move>::iterator it2 = newmoves.begin(); it2 != newmoves.end(); ++it2)
				moves.push_back(*it2);
		}
	}
	return moves;
}

//ala Shannon
int ComputerChessplayer::heuristic(Color* aColor) {
	int value = 0;
	std::list<Chessman*> men = chessboard->getChessmen(aColor);
	for (std::list<Chessman*>::iterator it = men.begin(); it != men.end(); ++it)
		if ((*it)->isAlive()) value += (*it)->value();
	value += collectMoves(aColor).size();

	men = chessboard->getChessmenNotIn(aColor);
	for (std::list<Chessman*>::iterator it = men.begin(); it != men.end(); ++it)
		if ((*it)->isAlive()) value -= (*it)->value();
	value -= collectMoves(aColor->other()).size();

	return value;
}

int ComputerChessplayer::maxOf(int aValue, int anotherValue) {
	if (aValue > anotherValue) return aValue;
	return anotherValue;
}

int ComputerChessplayer::minOf(int aValue, int anotherValue) {
	if (aValue < anotherValue) return aValue;
	return anotherValue;
}

//Führt eine AlphaBeta Suche durch
void ComputerChessplayer::move() {
	int alpha = -10000;
	int max = -10000;
	Move* maxmove = NULL;
	std::list<Move> moves = collectMoves(color);
	for (std::list<Move>::iterator it = moves.begin(); it != moves.end(); ++it) {
		Move oldm = it->execute();
		int newmax = maxOf(-alphaBeta(maxdepth, -10000, -alpha, color->other()), max);
		if (newmax > max) {
			maxmove = &(*it);
			max = newmax;
		}
		oldm.execute();
		if (newmax > alpha) alpha = newmax;
	}
	if (maxmove != NULL) maxmove->execute();
}