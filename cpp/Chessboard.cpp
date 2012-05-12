#include "stdafx.h"
#include "Chessboard.h"
#include "Chessplayer.h"
#include "Chessman.h"

#include <iostream>
#include <string>
#include <ctype.h>

int theDepth = 4;

enum {
	BISHOP, KING, KNIGHT, PAWN, QUEEN, ROOK
};

Chessman* Chessboard::at(Position aPosition) {
	return board[aPosition.getX()][aPosition.getY()];
}

Chessman* Chessboard::putat(Position aPosition, Chessman* aChessman) {
	Chessman* old = at(aPosition);
	board[aPosition.getX()][aPosition.getY()] = aChessman;
	return old;
}

void Chessboard::create(int type, int x, int y, Color* color) {
	Position position(x, y);
	Chessman* chessman = NULL;
	switch (type) {
	case BISHOP:
		chessman = new Bishop(position, color, this);
		break;
	case KING:
		chessman = new King(position, color, this);
		break;
	case KNIGHT:
		chessman = new Knight(position, color, this);
		break;
	case PAWN:
		chessman = new Pawn(position, color, this);
		break;
	case QUEEN:
		chessman = new Queen(position, color, this);
		break;
	case ROOK:
		chessman = new Rook(position, color, this);
		break;
	}
	board[x][y] = chessman;
	if (color->isWhite()) white.push_back(chessman);
	else black.push_back(chessman);
}

void Chessboard::draw() {
	std::cout << "\n  abcdefgh\n";
	for (int y = 1; y <= 8; ++y) {
		std::cout << std::endl << (9 - y) << ' ';
		for (int x = 1; x <= 8; ++x) {
			if (board[x - 1][y - 1] == NULL) {
				std::cout << ' ';
			}
			else {
				std::cout << board[x - 1][y - 1]->getChar();
			}
		}
		std::cout << ' ' << (9 - y);
	}
	std::cout << "\n\n  abcdefgh\n";
	std::cout << std::endl;
}

std::list<Chessman*> Chessboard::getChessmen(Color* aColor) {
	if (aColor->isWhite()) return white;
	return black;
}

std::list<Chessman*> Chessboard::getChessmenNotIn(Color* aColor) {
	if (aColor->isWhite()) return black;
	return white;
}

//wenn an der Position niemand steht oder die Position außerhalb des Brettes ist, wird auch false zurückgegeben
bool Chessboard::hasDifferentColorThan(Color* aColor, Position aPosition) {
	if (aPosition.getX() > 7 || aPosition.getX() < 0 || aPosition.getY() > 7 || aPosition.getY() < 0) return false;
	if (at(aPosition) == NULL) return false;
	if (at(aPosition)->getColor()->isDifferent(aColor)) return true;
	return false;
}

//durchsucht die Figurenlisten nach dem König
bool Chessboard::hasWon(Color* aColor) {
	std::list<Chessman*> men = getChessmenNotIn(aColor);
	for (std::list<Chessman*>::iterator it = men.begin(); it != men.end(); ++it) {
		if ((*it)->isKing()) {
			return false;
		}
	}
	return true;
}

//	"Initialisiert das Schachbrett und stellt insbesondere die Figuren auf das Brett"

//
//	whiteplayer_HumanChessplayer newWith: self In: w.
//	blackplayer_ComputerChessplayer newWith: self In: b.
Chessboard::Chessboard() {
	for (int x = 0; x < 8; ++x) for (int y = 0; y < 8; ++y) board[x][y] = 0;
	whiteplayer = new HumanChessplayer(this, White::getInstance());
	blackplayer = new ComputerChessplayer(this, Black::getInstance(), theDepth);

	//whiteplayer = new ComputerChessplayer(this, White::getInstance(), 4);
	//blackplayer = new ComputerChessplayer(this, Black::getInstance(), 3);

	create(ROOK, 0, 7, White::getInstance());
	create(KNIGHT, 1, 7, White::getInstance());
	create(BISHOP, 2, 7, White::getInstance());
	create(QUEEN, 3, 7, White::getInstance());
	create(KING, 4, 7, White::getInstance());
	create(BISHOP, 5, 7, White::getInstance());
	create(KNIGHT, 6, 7, White::getInstance());
	create(ROOK, 7, 7, White::getInstance());
	for (int i = 0; i < 8; ++i) create(PAWN, i, 6, White::getInstance());

	create(ROOK, 0, 0, Black::getInstance());
	create(KNIGHT, 1, 0, Black::getInstance());
	create(BISHOP, 2, 0, Black::getInstance());
	create(QUEEN, 3, 0, Black::getInstance());
	create(KING, 4, 0, Black::getInstance());
	create(BISHOP, 5, 0, Black::getInstance());
	create(KNIGHT, 6, 0, Black::getInstance());
	create(ROOK, 7, 0, Black::getInstance());
	for (int i = 0; i < 8; ++i) create(PAWN, i, 1, Black::getInstance());

	/*create(KING, 4, 7, White::getInstance());
	create(KING, 4, 0, Black::getInstance());
	//create(ROOK, 4, 2, Black::getInstance());
	create(PAWN, 5, 5, Black::getInstance());*/
}

//gibt auch false zurück, wenn eine Position außerhalb des Brettes angesprochen wird
bool Chessboard::isFreeAt(Position aPosition) {
	if (aPosition.getX() > 7 || aPosition.getX() < 0 || aPosition.getY() > 7 || aPosition.getY() < 0) return false;
	if (at(aPosition) == NULL) return true;
	return false;
}

//Spielt Schach bis einer der beiden Könige sich verabschiedet
Color* Chessboard::play() {
	draw();
	for (;;) {
		whiteplayer->move();
		draw();
		if (hasWon(White::getInstance())) {
			std::cout << "\n\nWeiss hat gewonnen." << std::endl;
			std::cout << "Das Losungswort lautet \"";
			switch (theDepth) {
			case 1:
				std::cout << "Regelkenner";
				break;
			case 2:
				std::cout << "Regelanwender";
				break;
			case 3:
				std::cout << "Hobby Schachi";
				break;
			case 4:
				std::cout << "Profi Schachlik";
				break;
			default:
				std::cout << "Geduldige " << theDepth;
				break;
			}
			std::cout << "\"" << std::endl;
			return White::getInstance();
		}
		blackplayer->move();
		draw();
		if (hasWon(Black::getInstance())) {
			std::cout << "\n\nSchwarz hat gewonnen.";
			return Black::getInstance();
		}
	}
}

int _tmain(int argc, _TCHAR* argv[]) {
	std::cout << "Chessykon v0.13\n" << std::endl;
	do {
		std::cout << "Tiefe (1-9, 4 empfohlen): ";
		std::cin >> theDepth;
	} while (theDepth < 1 || theDepth > 9);
	std::cout << "Rechne bis Tiefe " << theDepth << std::endl;
	Chessboard board;
	board.play();
	std::string end;
	std::cin >> end;
}