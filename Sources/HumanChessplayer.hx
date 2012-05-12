package ;

class HumanChessplayer extends Chessplayer {
	public function new(aChessboard : Chessboard, aColor : Color) {
		super(aChessboard, aColor);
	}

	override public function move() : Void {
		/*while (true) {
			trace("Ihr Zug bitte (in der Form a2b3): ");
			std::string in;
			std::cin >> in;
			if (in.length() < 4) goto start;
			if (!isalpha(in[0]) || !isalpha(in[2])) goto start;
			if (!isdigit(in[1]) || !isdigit(in[3])) goto start;
			char c1 = tolower(in[0]);
			char c2 = tolower(in[2]);
			int i1 = c1 - 'a';
			int i3 = c2 - 'a';
			int i2 = in[1] - '1';
			int i4 = in[3] - '1';
			if (i1 < 0 || i1 > 7 || i2 < 0 || i2 > 7 || i3 < 0 || i3 > 7 || i4 < 0 || i4 > 7) goto start;
			i2 = 7 - i2;
			i4 = 7 - i4;
			Chessman* man = chessboard->at(Position(i1, i2));
			if (man == NULL) goto start;
			if (man->getColor()->isDifferent(color)) goto start;
			std::list<Move> moves = man->moves();
			for (std::list<Move>::iterator it = moves.begin(); it != moves.end(); ++it) {
				if (it->getPosition().getX() == i3 && it->getPosition().getY() == i4) {
					it->execute();
					return;
				}
			}
		}*/
	}
}