package;

import kha.Assets;
import kha.Framebuffer;
import kha.Image;
import kha.input.Mouse;

class Game {
	static var theDepth: Int = 4;

	var whiteplayer: Chessplayer;
	var blackplayer: Chessplayer;
	var currentplayer: Chessplayer = null;
	var winner: Chessplayer;

	public var board: Chessboard;

	public function new() {
		board = new Chessboard();

		whiteplayer = new HumanChessplayer(board, White.getInstance());
		blackplayer = new ComputerChessplayer(board, Black.getInstance(), theDepth);
		currentplayer = whiteplayer;
		winner = null;

		// whiteplayer = new ComputerChessplayer(this, White::getInstance(), 4);
		// blackplayer = new ComputerChessplayer(this, Black::getInstance(), 3);

		Mouse.get().notify(mouseDown, null, null, null);
	}

	public function update(): Void {
		if (currentplayer == null)
			return;
		if (winner != null)
			return;
		if (currentplayer.move()) {
			if (board.hasWon(White.getInstance())) {
				winner = whiteplayer;
			}
			if (board.hasWon(Black.getInstance())) {
				winner = blackplayer;
			}
			if (currentplayer == whiteplayer)
				currentplayer = blackplayer;
			else
				currentplayer = whiteplayer;
			board.updateChessmenPositions();
		}
	}

	function mouseDown(button: Int, x: Int, y: Int): Void {
		currentplayer.mouseDown(x, y);
	}

	function renderChessman(g: kha.graphics2.Graphics, piece: Chessman): Void {
		var image: Image = null;
		if (piece.color.isWhite()) {
			switch (piece.type) {
				case BISHOP:
					image = Assets.images.WhiteB;
				case KING:
					image = Assets.images.WhiteK;
				case KNIGHT:
					image = Assets.images.WhiteN;
				case PAWN:
					image = Assets.images.WhiteP;
				case QUEEN:
					image = Assets.images.WhiteQ;
				case ROOK:
					image = Assets.images.WhiteR;
			}
		}
		else {
			switch (piece.type) {
				case BISHOP:
					image = Assets.images.BlackB;
				case KING:
					image = Assets.images.BlackK;
				case KNIGHT:
					image = Assets.images.BlackN;
				case PAWN:
					image = Assets.images.BlackP;
				case QUEEN:
					image = Assets.images.BlackQ;
				case ROOK:
					image = Assets.images.BlackR;
			}
		}
		g.drawImage(image, piece.x, piece.y);
	}

	public function render(frames: Array<Framebuffer>): Void {
		var g = frames[0].g2;
		g.begin();
		for (x in 0...8) {
			for (y in 0...8) {
				if (y % 2 == 0 && x % 2 == 0)
					g.color = kha.Color.White;
				if (y % 2 == 1 && x % 2 == 0)
					g.color = kha.Color.Black;
				if (y % 2 == 0 && x % 2 == 1)
					g.color = kha.Color.Black;
				if (y % 2 == 1 && x % 2 == 1)
					g.color = kha.Color.White;
				g.fillRect(x * 48, y * 48, 48, 48);
			}
		}
		for (piece in board.white) {
			renderChessman(g, piece);
		}
		for (piece in board.black) {
			renderChessman(g, piece);
		}
		g.end();
	}
}
