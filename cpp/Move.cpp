#include "stdafx.h"
#include "Move.h"
#include "Chessman.h"

Move Move::execute() {
	Move remove = chessman->move(position);
	if (killed != NULL) killed->revive();
	return remove;
}

//ben�tigt der HumanPlayer f�r die ListBox
std::string Move::toString() {
	return chessman->getPosition().toString() + " to " + position.toString();
}