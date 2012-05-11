#include "stdafx.h"
#include "Position.h"

std::string Position::toString() {
	std::string s;
	s += x;
	s += '-';
	s += y;
	return s;
}