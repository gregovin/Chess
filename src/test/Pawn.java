package test;

public class Pawn extends Piece{
	public Pawn(int side, String imgFilePath, int coll) {
		super(5, coll, 5 * side + 1, imgFilePath, side);
	}
}
