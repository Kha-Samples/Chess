#ifndef COLOR_HEADER
#define COLOR_HEADER

class Color {
public:
	virtual bool isBlack() = 0;
	virtual bool isDifferent(Color*) = 0;
	virtual bool isWhite() = 0;
	virtual Color* other() = 0;
};

class Black;

class White : public Color {
private:
	White() { }
public:
	bool isBlack() {
		return false;
	}

	bool isDifferent(Color* aColor) {
		return aColor->isBlack();
	}

	bool isWhite() {
		return true;
	}

	Color* other();

	static Color* getInstance() {
		static White instance;
		return &instance;
	}
};

class Black : public Color {
private:
	Black() { }
public:
	bool isBlack() {
		return true;
	}

	bool isDifferent(Color* aColor) {
		if (aColor->isWhite()) return true;
		return false;
	}

	bool isWhite() {
		return false;
	}

	Color* other() {
		return White::getInstance();
	}

	static Color* getInstance() {
		static Black instance;
		return &instance;
	}
};

#endif