package;

import kha.Worker;

class ComputerChessplayer extends Chessplayer {
	var maxdepth: Int;
	var worker: Worker;
	var nextMove: Move = null;
	var thinking: Bool = false;

	public function new(aChessboard: Chessboard, aColor: Color, maxdepth: Int) {
		super(aChessboard, aColor);
		this.maxdepth = maxdepth;

		worker = kha.Worker.create(ComputerWorker);
		worker.notify(function(data: Dynamic) {
			var piece1 = chessboard.at(new ChessPosition(data.x1, data.y1));
			nextMove = new Move(piece1, new ChessPosition(data.x2, data.y2), null);
		});
	}

	override public function move(): Bool {
		if (!thinking) {
			thinking = true;
			nextMove = null;
			worker.post({maxdepth: maxdepth, color: color.isWhite(), data: chessboard.toData()});
		}

		if (nextMove != null) {
			nextMove.execute();
			nextMove = null;
			thinking = false;
			return true;
		}
		else {
			return false;
		}
	}
}
