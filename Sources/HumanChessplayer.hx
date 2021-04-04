package;

class HumanChessplayer extends Chessplayer {
	var man: Chessman;
	var nextMove: Move;

	public function new(aChessboard: Chessboard, aColor: Color) {
		super(aChessboard, aColor);
		man = null;
		nextMove = null;
	}

	override public function move(): Bool {
		if (nextMove != null) {
			nextMove.execute();
			nextMove = null;
			man = null;
			return true;
		}
		else
			return false;
	}

	override public function mouseDown(x: Int, y: Int): Void {
		if (man == null) {
			man = chessboard.at(new Position(Std.int(x / 48), Std.int(y / 48)));
			if (man.getColor().isDifferent(color))
				man = null;
		}
		else {
			var moves = man.moves();
			for (move in moves) {
				if (move.getPosition().getX() == Std.int(x / 48) && move.getPosition().getY() == Std.int(y / 48)) {
					nextMove = move;
					return;
				}
			}
			man = null;
		}
	}
}
