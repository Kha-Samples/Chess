package ;

class ComputerChessplayer extends Chessplayer {
	var maxdepth : Int;
	
	public function new(aChessboard : Chessboard, aColor : Color, maxdepth : Int) {
		super(aChessboard, aColor);
		this.maxdepth = maxdepth;
	}

	//Führt eine AlphaBeta Suche durch
	override public function move() {
		var alpha : Int = -10000;
		var max : Int = -10000;
		var maxmove : Move = null;
		var moves = collectMoves(color);
		for (move in moves) {
			var oldm = move.execute();
			var newmax : Int = Std.int(Math.max(-alphaBeta(maxdepth, -10000, -alpha, color.other()), max));
			if (newmax > max) {
				maxmove = move;
				max = newmax;
			}
			oldm.execute();
			if (newmax > alpha) alpha = newmax;
		}
		if (maxmove != null) maxmove.execute();
	}
	
	public function alphaBeta(depth : Int, al : Int, beta : Int, aColor : Color) {
		if (depth == 0) return heuristic(aColor);
		var alpha = al;
		var moves = collectMoves(aColor);
		//if (moves.size() == 0) return heuristic(aColor);
		for (move in moves) {
			var oldmove = move.execute();
			var value : Int = -alphaBeta(depth - 1, -beta, -alpha, aColor.other());
			oldmove.execute();
			if (value >= beta) return beta;
			if (value > alpha) alpha = value;
		}
		return alpha;
	}
	
	//erstellt eine OrderedCollection, die alle für den Spieler möglichen Züge enthält
	public function collectMoves(aColor : Color) : Array<Move> {
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
	
	//ala Shannon
	public function heuristic(aColor : Color) : Int {
		var value : Int = 0;
		var men = chessboard.getChessmen(aColor);
		for (man in men)
			if (man.isAlive()) value += man.value();
		value += collectMoves(aColor).length;

		men = chessboard.getChessmenNotIn(aColor);
		for (man in men)
			if (man.isAlive()) value -= man.value();
		value -= collectMoves(aColor.other()).length;

		return value;
	}
}