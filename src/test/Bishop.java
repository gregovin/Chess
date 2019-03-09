package test;

public class Bishop extends Piece{
	public Bishop(int side, String imgFilePath, int coll) {
		super(4, coll, 7 * side, imgFilePath, side);
	}
}
