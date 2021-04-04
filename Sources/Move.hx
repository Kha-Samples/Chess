package;

import haxe.macro.Expr.Position;

class Move {
	var chessman: Chessman;
	var killed: Chessman;
	var position: ChessPosition;

	public function new(aChessman: Chessman, aPosition: ChessPosition, aKilled: Chessman = null) {
		chessman = aChessman;
		position = aPosition;
		killed = aKilled;
	}

	public function execute(): Move {
		var remove = chessman.move(position);
		if (killed != null)
			killed.revive();
		return remove;
	}

	// benötigt der HumanPlayer für die ListBox
	public function toString(): String {
		return chessman.getPosition().toString() + " to " + position.toString();
	}

	public function getOldPosition(): ChessPosition {
		return chessman.getPosition();
	}

	public function getPosition(): ChessPosition {
		return position;
	}
}
