package;

class PieceConfig {
	public var type: Int;
	public var x: Int;
	public var y: Int;
	public var white: Bool;

	public function new(type: Int, x: Int, y: Int, white: Bool) {
		this.type = type;
		this.x = x;
		this.y = y;
		this.white = white;
	}
}

class Chessboard {
	var board: Array<Array<Chessman>>;

	public var white: Array<Chessman>;
	public var black: Array<Chessman>;

	public function at(aPosition: ChessPosition): Chessman {
		return board[aPosition.getX()][aPosition.getY()];
	}

	public function putat(aPosition: ChessPosition, aChessman: Chessman): Chessman {
		var old = at(aPosition);
		board[aPosition.getX()][aPosition.getY()] = aChessman;
		return old;
	}

	public function create(type: ChessmanType, x: Int, y: Int, color: Color): Void {
		var position = new ChessPosition(x, y);
		var chessman: Chessman = null;
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
		if (color.isWhite())
			white.push(chessman);
		else
			black.push(chessman);

		chessman.x = x * 48;
		chessman.y = y * 48;
	}

	function updateChessmanPosition(chessman: Chessman) {
		if (chessman.isAlive()) {
			chessman.x = chessman.getPosition().getX() * 48;
			chessman.y = chessman.getPosition().getY() * 48;
		}
		else {
			chessman.x = -100;
			chessman.y = -100;
		}
	}

	public function updateChessmenPositions() {
		for (chessman in white) {
			updateChessmanPosition(chessman);
		}
		for (chessman in black) {
			updateChessmanPosition(chessman);
		}
	}

	public function getChessmen(aColor: Color): Array<Chessman> {
		if (aColor.isWhite())
			return white;
		return black;
	}

	public function getChessmenNotIn(aColor: Color): Array<Chessman> {
		if (aColor.isWhite())
			return black;
		return white;
	}

	// wenn an der Position niemand steht oder die Position außerhalb des Brettes ist, wird auch false zurückgegeben
	public function hasDifferentColorThan(aColor: Color, aPosition: ChessPosition): Bool {
		if (aPosition.getX() > 7 || aPosition.getX() < 0 || aPosition.getY() > 7 || aPosition.getY() < 0)
			return false;
		if (at(aPosition) == null)
			return false;
		if (at(aPosition).getColor().isDifferent(aColor))
			return true;
		return false;
	}

	// durchsucht die Figurenlisten nach dem König
	public function hasWon(aColor: Color): Bool {
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
		white = new Array<Chessman>();
		black = new Array<Chessman>();

		board = new Array<Array<Chessman>>();
		for (x in 0...8) {
			board.push(new Array<Chessman>());
			for (y in 0...8) {
				board[x].push(null);
			}
		}

		create(ROOK, 0, 7, White.getInstance());
		create(KNIGHT, 1, 7, White.getInstance());
		create(BISHOP, 2, 7, White.getInstance());
		create(QUEEN, 3, 7, White.getInstance());
		create(KING, 4, 7, White.getInstance());
		create(BISHOP, 5, 7, White.getInstance());
		create(KNIGHT, 6, 7, White.getInstance());
		create(ROOK, 7, 7, White.getInstance());
		for (i in 0...8)
			create(PAWN, i, 6, White.getInstance());

		create(ROOK, 0, 0, Black.getInstance());
		create(KNIGHT, 1, 0, Black.getInstance());
		create(BISHOP, 2, 0, Black.getInstance());
		create(QUEEN, 3, 0, Black.getInstance());
		create(KING, 4, 0, Black.getInstance());
		create(BISHOP, 5, 0, Black.getInstance());
		create(KNIGHT, 6, 0, Black.getInstance());
		create(ROOK, 7, 0, Black.getInstance());
		for (i in 0...8)
			create(PAWN, i, 1, Black.getInstance());
	}

	public function newFromData(data: Array<PieceConfig>): Void {
		white = new Array<Chessman>();
		black = new Array<Chessman>();

		board = new Array<Array<Chessman>>();
		for (x in 0...8) {
			board.push(new Array<Chessman>());
			for (y in 0...8) {
				board[x].push(null);
			}
		}

		for (config in data) {
			create(ChessmanType.createByIndex(config.type), config.x, config.y, config.white ? White.getInstance() : Black.getInstance());
		}
	}

	public function toData(): Array<PieceConfig> {
		var array = new Array<PieceConfig>();
		for (piece in white) {
			array.push(new PieceConfig(piece.type.getIndex(), piece.getPosition().getX(), piece.getPosition().getY(), piece.color.isWhite()));
		}
		for (piece in black) {
			array.push(new PieceConfig(piece.type.getIndex(), piece.getPosition().getX(), piece.getPosition().getY(), piece.color.isWhite()));
		}
		return array;
	}

	// gibt auch false zurück, wenn eine Position außerhalb des Brettes angesprochen wird
	public function isFreeAt(aPosition: ChessPosition): Bool {
		if (aPosition.getX() > 7 || aPosition.getX() < 0 || aPosition.getY() > 7 || aPosition.getY() < 0)
			return false;
		if (at(aPosition) == null)
			return true;
		return false;
	}
}
