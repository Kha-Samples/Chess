package ;

import kha.Game;
import kha.Loader;
import kha.Painter;
import kha.Scene;

class Chessboard extends Game {
	static var theDepth : Int = 4;
	var board : Array<Array<Chessman>>;
	var whiteplayer : Chessplayer;
	var blackplayer : Chessplayer;
	var currentplayer : Chessplayer = null;
	var white : Array<Chessman>;
	var black : Array<Chessman>;
	var winner : Chessplayer;

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
		
		chessman.x = x * 48;
		chessman.y = y * 48;
		Scene.the.addEnemy(chessman);
	}
	
	function updateChessmanPosition(chessman : Chessman) {
		if (chessman.isAlive()) {
			chessman.x = chessman.getPosition().getX() * 48;
			chessman.y = chessman.getPosition().getY() * 48;
		}
		else {
			chessman.x = -100;
			chessman.y = -100;
		}
	}
	
	function updateChessmenPositions() {
		for (chessman in white) {
			updateChessmanPosition(chessman);
		}
		for (chessman in black) {
			updateChessmanPosition(chessman);
		}
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
		super("Chess", false);
		white = new Array<Chessman>();
		black = new Array<Chessman>();
		winner = null;
	}
	
	override public function init() : Void {
		Loader.the.loadRoom("start", init2);
	}
	
	private function init2(): Void {
		board = new Array<Array<Chessman>>();
		for (x in 0...8) {
			board.push(new Array<Chessman>());
			for (y in 0...8) {
				board[x].push(null);
			}
		}
		whiteplayer = new HumanChessplayer(this, White.getInstance());
		blackplayer = new ComputerChessplayer(this, Black.getInstance(), theDepth);
		currentplayer = whiteplayer;

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
	
	override public function update() : Void {
		if (currentplayer == null) return;
		if (winner != null) return;
		if (currentplayer.move()) {
			if (hasWon(White.getInstance())) {
				winner = whiteplayer;
			}
			if (hasWon(Black.getInstance())) {
				winner = blackplayer;
			}
			if (currentplayer == whiteplayer) currentplayer = blackplayer;
			else currentplayer = whiteplayer;
			updateChessmenPositions();
		}
	}
	
	override public function mouseDown(x : Int, y : Int) : Void {
		currentplayer.mouseDown(x, y);
	}
	
	override public function render(painter : Painter) : Void {
		for (x in 0...8) {
			for (y in 0...8) {
				if (y % 2 == 0 && x % 2 == 0) painter.setColor(255, 255, 255);
				if (y % 2 == 1 && x % 2 == 0) painter.setColor(0, 0, 0);
				if (y % 2 == 0 && x % 2 == 1) painter.setColor(0, 0, 0);
				if (y % 2 == 1 && x % 2 == 1) painter.setColor(255, 255, 255);
				painter.fillRect(x * 48, y * 48, 48, 48);
			}
		}
		super.render(painter);
	}
}