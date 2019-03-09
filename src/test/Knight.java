package test;

public class Knight extends Piece{
	public Knight(int side, String imgFilePath, int coll) {
		super(3, coll, 7 * side, imgFilePath, side);
	}
	
}
