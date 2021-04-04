package;

class Bishop extends Chessman {
	public function new(aPosition: ChessPosition, aColor: Color, aChessboard: Chessboard) {
		super(BISHOP, aPosition, aColor, aChessboard);
	}

	override public function getChar(): String {
		if (color.isWhite())
			return "b";
		return "B";
	}

	// Läufer
	override public function moves(): Array<Move> {
		var moves = new Array<Move>();

		var newposition = new ChessPosition(position.getX() + 1, position.getY() + 1);
		while (chessboard.isFreeAt(newposition)) {
			moves.push(new Move(this, newposition));
			newposition = new ChessPosition(newposition.getX() + 1, newposition.getY() + 1);
		}
		if (chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		newposition = new ChessPosition(position.getX() + 1, position.getY() - 1);
		while (chessboard.isFreeAt(newposition)) {
			moves.push(new Move(this, newposition));
			newposition = new ChessPosition(newposition.getX() + 1, newposition.getY() - 1);
		}
		if (chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		newposition = new ChessPosition(position.getX() - 1, position.getY() + 1);
		while (chessboard.isFreeAt(newposition)) {
			moves.push(new Move(this, newposition));
			newposition = new ChessPosition(newposition.getX() - 1, newposition.getY() + 1);
		}
		if (chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		newposition = new ChessPosition(position.getX() - 1, position.getY() - 1);
		while (chessboard.isFreeAt(newposition)) {
			moves.push(new Move(this, newposition));
			newposition = new ChessPosition(newposition.getX() - 1, newposition.getY() - 1);
		}
		if (chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		return moves;
	}

	override public function value(): Int {
		return 30;
	}
}
