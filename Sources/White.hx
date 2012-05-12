package ;

class White implements Color {
	static var instance : White = new White();
	
	function new() {
		
	}

	public function isBlack() : Bool {
		return false;
	}

	public function isDifferent(aColor : Color) : Bool {
		return aColor.isBlack();
	}

	public function isWhite() : Bool {
		return true;
	}

	public function other() : Color {
		return Black.getInstance();
	}

	public static function getInstance() : Color {
		return instance;
	}
}