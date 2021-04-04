package;

import kha.System;
import kha.Assets;

class Main {
	static var board: Chessboard;

	public static function main() {
		// "Tiefe (1-9, 4 empfohlen)
		System.start({}, (window) -> {
			Assets.loadEverything(() -> {
				board = new Chessboard();
			});
		});
	}
}
