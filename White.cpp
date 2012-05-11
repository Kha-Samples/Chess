#include "stdafx.h"
#include "Color.h"

Color* White::other() {
	return Black::getInstance();
}