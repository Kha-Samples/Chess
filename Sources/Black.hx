package ;

class Black implements Color {
	static var instance : Black = new Black();
	
	function new() {
		
	}

	public function isBlack() : Bool {
		return true;
	}

	public function isDifferent(aColor : Color) : Bool {
		return aColor.isWhite();
	}

	public function isWhite() : Bool {
		return false;
	}

	public function other() : Color {
		return White.getInstance();
	}

	public static function getInstance() : Color {
		return instance;
	}
}