package;

import kha.Worker;

class ComputerWorker {
	static var chessboard: Chessboard;

	public static function main(): Void {
		Worker.notifyWorker((message) -> {
			var maxdepth: Int = message.maxdepth;
			var color: Color = message.color ? White.getInstance() : Black.getInstance();
			chessboard = new Chessboard();
			chessboard.newFromData(message.data);

			var alpha: Int = -10000;
			var max: Int = -10000;
			var maxmove: Move = null;
			var moves = collectMoves(color);
			for (move in moves) {
				var oldm = move.execute();
				var newmax: Int = Std.int(Math.max(-alphaBeta(maxdepth, -10000, -alpha, color.other()), max));
				if (newmax > max) {
					maxmove = move;
					max = newmax;
				}
				oldm.execute();
				if (newmax > alpha)
					alpha = newmax;
			}
			if (maxmove != null) {
				// maxmove.execute();
				Worker.postFromWorker({
					x1: maxmove.getOldPosition().getX(),
					y1: maxmove.getOldPosition().getY(),
					x2: maxmove.getPosition().getX(),
					y2: maxmove.getPosition().getY()
				});
			}
			else {
				Worker.postFromWorker({
					x1: -1,
					y1: -1,
					x2: -1,
					y2: -1
				});
			}
		});
	}

	static function alphaBeta(depth: Int, al: Int, beta: Int, aColor: Color) {
		if (depth == 0)
			return heuristic(aColor);
		var alpha = al;
		var moves = collectMoves(aColor);
		// if (moves.size() == 0) return heuristic(aColor);
		for (move in moves) {
			var oldmove = move.execute();
			var value: Int = -alphaBeta(depth - 1, -beta, -alpha, aColor.other());
			oldmove.execute();
			if (value >= beta)
				return beta;
			if (value > alpha)
				alpha = value;
		}
		return alpha;
	}

	static function collectMoves(aColor: Color): Array<Move> {
		var moves = new Array<Move>();
		var men = chessboard.getChessmen(aColor);
		for (man in men) {
			if (man.isAlive()) {
				var newmoves = man.moves();
				for (move in newmoves)
					moves.push(move);
			}
		}
		return moves;
	}

	// ala Shannon
	static function heuristic(aColor: Color): Int {
		var value: Int = 0;
		var men = chessboard.getChessmen(aColor);
		for (man in men)
			if (man.isAlive())
				value += man.value();
		value += collectMoves(aColor).length;

		men = chessboard.getChessmenNotIn(aColor);
		for (man in men)
			if (man.isAlive())
				value -= man.value();
		value -= collectMoves(aColor.other()).length;

		return value;
	}
}
