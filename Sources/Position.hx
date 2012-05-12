package ;

class Position {
	var x : Int;
	var y : Int;

	public function new(aX : Int, aY : Int) {
		x = aX;
		y = aY;
	}

	public function toString() : String {
		return x + "-" + y;
	}

	public function getX() : Int {
		return x;
	}

	public function getY() : Int {
		return y;
	}
}