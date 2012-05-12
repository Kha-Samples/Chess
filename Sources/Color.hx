package ;

interface Color {
	function isBlack() : Bool;
	function isDifferent(aColor : Color) : Bool;
	function isWhite() : Bool;
	function other() : Color;
}