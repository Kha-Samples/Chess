package;

import kha.System;
import kha.Assets;
import kha.Scheduler;

class Main {
	public static function main() {
		// "Tiefe (1-9, 4 empfohlen)
		System.start({title: "Chess", width: 48 * 8, height: 48 * 8}, (window) -> {
			Assets.loadEverything(() -> {
				var board = new Chessboard();
				System.notifyOnFrames(board.render);
				Scheduler.addTimeTask(board.update, 0, 1 / 60);
			});
		});
	}
}
