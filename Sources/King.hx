package;

class King extends Chessman {
	public function new(aPosition: ChessPosition, aColor: Color, aChessboard: Chessboard) {
		super(KING, aPosition, aColor, aChessboard);
	}

	override public function getChar(): String {
		if (color.isWhite())
			return "k";
		return "K";
	}

	override public function isKing(): Bool {
		if (killed)
			return false;
		return true;
	}

	override public function moves(): Array<Move> {
		var moves = new Array<Move>();

		var newposition = new ChessPosition(position.getX(), position.getY() + 1);
		if (chessboard.isFreeAt(newposition) || chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		newposition = new ChessPosition(position.getX() + 1, position.getY() + 1);
		if (chessboard.isFreeAt(newposition) || chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		newposition = new ChessPosition(position.getX() + 1, position.getY());
		if (chessboard.isFreeAt(newposition) || chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		newposition = new ChessPosition(position.getX() + 1, position.getY() - 1);
		if (chessboard.isFreeAt(newposition) || chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		newposition = new ChessPosition(position.getX(), position.getY() - 1);
		if (chessboard.isFreeAt(newposition) || chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		newposition = new ChessPosition(position.getX() - 1, position.getY() - 1);
		if (chessboard.isFreeAt(newposition) || chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		newposition = new ChessPosition(position.getX() - 1, position.getY());
		if (chessboard.isFreeAt(newposition) || chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		newposition = new ChessPosition(position.getX() - 1, position.getY() + 1);
		if (chessboard.isFreeAt(newposition) || chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		return moves;
	}

	override public function value(): Int {
		return 5000;
	}
}
