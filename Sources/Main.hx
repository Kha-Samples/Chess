package ;

import kha.Starter;

class Main {
	public static function main() {
		/*std::cout << "Chess v0.14\n" << std::endl;
		do {
			std::cout << "Tiefe (1-9, 4 empfohlen): ";
			std::cin >> theDepth;
		} while (theDepth < 1 || theDepth > 9);
		std::cout << "Rechne bis Tiefe " << theDepth << std::endl;*/
	//	var board = new Chessboard();
	//	board.play();
		/*std::string end;
		std::cin >> end;*/
		new Starter().start(new Chessboard());
	}
}