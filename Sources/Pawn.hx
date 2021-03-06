package;

class Pawn extends Chessman {
	public function new(aPosition: ChessPosition, aColor: Color, aChessboard: Chessboard) {
		super(PAWN, aPosition, aColor, aChessboard);
	}

	override public function getChar(): String {
		if (color.isWhite())
			return "p";
		return "P";
	}

	override public function moves(): Array<Move> {
		var moves = new Array<Move>();

		var newy: Int;
		if (color.isWhite())
			newy = position.getY() - 1;
		else
			newy = position.getY() + 1;

		var newposition = new ChessPosition(position.getX(), newy);
		if (chessboard.isFreeAt(newposition)) {
			moves.push(new Move(this, newposition));

			if (color.isWhite() && position.getY() == 6) {
				newposition = new ChessPosition(position.getX(), newy - 1);
				if (chessboard.isFreeAt(newposition))
					moves.push(new Move(this, newposition));
			}
			else if (color.isBlack() && position.getY() == 1) {
				newposition = new ChessPosition(position.getX(), newy + 1);
				if (chessboard.isFreeAt(newposition))
					moves.push(new Move(this, newposition));
			}
		}

		newposition = new ChessPosition(position.getX() + 1, newy);
		if (chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		newposition = new ChessPosition(position.getX() - 1, newy);
		if (chessboard.hasDifferentColorThan(color, newposition))
			moves.push(new Move(this, newposition));

		return moves;
	}

	override public function value(): Int {
		return 10;
	}
}
