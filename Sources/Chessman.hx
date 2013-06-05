package ;

import kha.Loader;
import kha.Sprite;

class Chessman extends Sprite {
	var position : Position;
	var chessboard : Chessboard;
	var color : Color;
	var killed : Bool;

	//für die Ausgabe
	public function getChar() : String {
		return "";
	}

	public function getColor() : Color {
		return color;
	}
	
	public function new(name : String, aPosition : Position, aColor : Color, aChessboard : Chessboard) {
		super(Loader.the.getImage((aColor.isBlack() ? "Black" : "White") + name), 48, 48, 0);
		collides = false;
		accy = 0;
		position = aPosition;
		color = aColor;
		chessboard = aChessboard;
		killed = false;
	}

	public function isAlive() : Bool {
		return !killed;
	}

	public function isKing() : Bool {
		return false;
	}

	public function kill() : Void {
		killed = true;
	}

	//da macht sich die Schachfigur auf zu einer neuen Position und wenn sie die Gelegenheit dazu bekommt,
	//rämpelt sie dabei gleich noch jemanden um
	public function move(aPosition : Position) : Move {
		chessboard.putat(position, null);
		var oldman = chessboard.putat(aPosition, this);
		if (oldman != null) oldman.kill();
		var remove = new Move(this, position, oldman);
		position = aPosition;
		return remove;
	}

	//gibt alle möglichen Bewegungen der Schachfigur zurück
	public function moves() : Array<Move> {
		return [];
	}

	public function getPosition() : Position {
		return position;
	}

	public function revive() : Void {
		chessboard.putat(position, this);
		killed = false;
	}

	//gibt einen Wert für die Heuristik zurück
	public function value() : Int {
		return 0;
	}
}