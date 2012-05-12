package ;

class Move {
	var chessman : Chessman;
	var killed : Chessman;
	var position : Position;

	public function new(aChessman : Chessman, aPosition : Position, aKilled : Chessman = null) {
		chessman = aChessman;
		position = aPosition;
		killed = aKilled;
	}
	
	public function execute() : Move {
		var remove = chessman.move(position);
		if (killed != null) killed.revive();
		return remove;
	}

	//benötigt der HumanPlayer für die ListBox
	public function toString() : String {
		return chessman.getPosition().toString() + " to " + position.toString();
	}

	public function getPosition() : Position {
		return position;
	}
}