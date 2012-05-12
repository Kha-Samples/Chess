package ;

class Chessboard {
	static var theDepth : Int = 4;
	var board : Array<Array<Chessman>>;
	var whiteplayer : Chessplayer;
	var blackplayer : Chessplayer;
	var white : Array<Chessman>;
	var black : Array<Chessman>;

	public function at(aPosition : Position) : Chessman {
		return board[aPosition.getX()][aPosition.getY()];
	}
	
	public function putat(aPosition : Position, aChessman : Chessman) : Chessman {
		var old = at(aPosition);
		board[aPosition.getX()][aPosition.getY()] = aChessman;
		return old;
	}

	public function create(type : ChessmanType, x : Int, y : Int, color : Color) : Void {
		var position = new Position(x, y);
		var chessman : Chessman = null;
		switch (type) {
		case BISHOP:
			chessman = new Bishop(position, color, this);
		case KING:
			chessman = new King(position, color, this);
		case KNIGHT:
			chessman = new Knight(position, color, this);
		case PAWN:
			chessman = new Pawn(position, color, this);
		case QUEEN:
			chessman = new Queen(position, color, this);
		case ROOK:
			chessman = new Rook(position, color, this);
		}
		board[x][y] = chessman;
		if (color.isWhite()) white.push(chessman);
		else black.push(chessman);
	}
	
	public function draw() : Void {
		/*std::cout << "\n  abcdefgh\n";
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
		std::cout << std::endl;*/
	}
	
	public function getChessmen(aColor : Color) : Array<Chessman> {
		if (aColor.isWhite()) return white;
		return black;
	}
	
	public function getChessmenNotIn(aColor : Color) : Array<Chessman> {
		if (aColor.isWhite()) return black;
		return white;
	}
	
	//wenn an der Position niemand steht oder die Position außerhalb des Brettes ist, wird auch false zurückgegeben
	public function hasDifferentColorThan(aColor : Color, aPosition : Position) : Bool {
		if (aPosition.getX() > 7 || aPosition.getX() < 0 || aPosition.getY() > 7 || aPosition.getY() < 0) return false;
		if (at(aPosition) == null) return false;
		if (at(aPosition).getColor().isDifferent(aColor)) return true;
		return false;
	}
	
	//durchsucht die Figurenlisten nach dem König
	public function hasWon(aColor : Color) : Bool {
		var men = getChessmenNotIn(aColor);
		for (man in men) {
			if (man.isKing()) {
				return false;
			}
		}
		return true;
	}
	
	//	"Initialisiert das Schachbrett und stellt insbesondere die Figuren auf das Brett"
	public function new() {
		for (x in 0...8) for (y in 0...8) board[x][y] = null;
		whiteplayer = new HumanChessplayer(this, White.getInstance());
		blackplayer = new ComputerChessplayer(this, Black.getInstance(), theDepth);

		//whiteplayer = new ComputerChessplayer(this, White::getInstance(), 4);
		//blackplayer = new ComputerChessplayer(this, Black::getInstance(), 3);

		create(ROOK, 0, 7, White.getInstance());
		create(KNIGHT, 1, 7, White.getInstance());
		create(BISHOP, 2, 7, White.getInstance());
		create(QUEEN, 3, 7, White.getInstance());
		create(KING, 4, 7, White.getInstance());
		create(BISHOP, 5, 7, White.getInstance());
		create(KNIGHT, 6, 7, White.getInstance());
		create(ROOK, 7, 7, White.getInstance());
		for (i in 0...8) create(PAWN, i, 6, White.getInstance());

		create(ROOK, 0, 0, Black.getInstance());
		create(KNIGHT, 1, 0, Black.getInstance());
		create(BISHOP, 2, 0, Black.getInstance());
		create(QUEEN, 3, 0, Black.getInstance());
		create(KING, 4, 0, Black.getInstance());
		create(BISHOP, 5, 0, Black.getInstance());
		create(KNIGHT, 6, 0, Black.getInstance());
		create(ROOK, 7, 0, Black.getInstance());
		for (i in 0...8) create(PAWN, i, 1, Black.getInstance());
	}
	
	//gibt auch false zurück, wenn eine Position außerhalb des Brettes angesprochen wird
	public function isFreeAt(aPosition : Position) : Bool {
		if (aPosition.getX() > 7 || aPosition.getX() < 0 || aPosition.getY() > 7 || aPosition.getY() < 0) return false;
		if (at(aPosition) == null) return true;
		return false;
	}
	
	//Spielt Schach bis einer der beiden Könige sich verabschiedet
	public function play() : Color {
		draw();
		while (true) {
			whiteplayer.move();
			draw();
			if (hasWon(White.getInstance())) {
				/*std::cout << "\n\nWeiss hat gewonnen." << std::endl;
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
				std::cout << "\"" << std::endl;*/
				return White.getInstance();
			}
			blackplayer.move();
			draw();
			if (hasWon(Black.getInstance())) {
				//std::cout << "\n\nSchwarz hat gewonnen.";
				return Black.getInstance();
			}
		}
		return Black.getInstance();
	}
}