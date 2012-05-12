package ;

class Rook extends Chessman {
	public function new(aPosition : Position, aColor : Color, aChessboard : Chessboard) {
		super(aPosition, aColor, aChessboard);
	}

	override public function getChar() : String {
		if (color.isWhite()) return "r";
		return "R";
	}
	
	//Turm
	override public function moves() : Array<Move> {
		var moves = new Array<Move>();
		var newposition = new Position(position.getX() + 1, position.getY());
		while (chessboard.isFreeAt(newposition)) {
			moves.push(new Move(this, newposition));
			newposition = new Position(newposition.getX() + 1, newposition.getY());
		}
		if (chessboard.hasDifferentColorThan(color, newposition)) moves.push(new Move(this, newposition));

		newposition = new Position(position.getX() - 1, position.getY());
		while (chessboard.isFreeAt(newposition)) {
			moves.push(new Move(this, newposition));
			newposition = new Position(newposition.getX() - 1, newposition.getY());
		}
		if (chessboard.hasDifferentColorThan(color, newposition)) moves.push(new Move(this, newposition));

		newposition = new Position(position.getX(), position.getY() + 1);
		while (chessboard.isFreeAt(newposition)) {
			moves.push(new Move(this, newposition));
			newposition = new Position(newposition.getX(), newposition.getY() + 1);
		}
		if (chessboard.hasDifferentColorThan(color, newposition)) moves.push(new Move(this, newposition));

		newposition = new Position(position.getX(), position.getY() - 1);
		while (chessboard.isFreeAt(newposition)) {
			moves.push(new Move(this, newposition));
			newposition = new Position(newposition.getX(), newposition.getY() - 1);
		}
		if (chessboard.hasDifferentColorThan(color, newposition)) moves.push(new Move(this, newposition));

		return moves;
	}
	
	override public function value() : Int {
		return 50;
	}
}