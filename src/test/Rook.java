package test;

public class Rook extends Piece {
	public Rook(int side, String imgFilePath, int coll) {
		super(2, coll, 7 * side, imgFilePath, side);
	}
	public boolean valid_move(int newRow, int newColl, Board board) {
		int tempRow = this.row;
		int tempColl = this.coll;
		this.teleport(newRow, newColl);
		if(board.kings()[side].inCheck(board)) {
			return false;
		}
		this.teleport(tempRow, tempColl);
		if(newRow == this.row) {
			int inc;
			if(newColl > this.coll) {
				inc = 1;
			} else if (newColl == this.coll) {
				return false;
			} else {
				inc = -1;
			}
			tempColl += inc;
			while(tempColl < 8 && tempColl > -1 && tempColl != newColl && !notNull(board.pieceAt(this.row, tempColl))) {
				tempColl += inc;
			}
			if(tempColl < 8 && tempColl > -1 && tempColl == newColl) {
				if(notNull(board.pieceAt(newRow, newColl))) {
					return board.pieceAt(newRow, newColl).side == 1 - this.side;
				}
				return true;
			}
			return false;
				
		}
		if(newColl == this.coll) {
			int inc;
			if(newRow > this.row) {
				inc = 1;
			} else {
				inc = -1;
			}
			tempRow += inc;
			while(tempRow < 8 && tempRow > -1 && tempRow != newRow && !notNull(board.pieceAt(tempRow, this.coll))) {
				tempRow += inc;
			}
			if(tempRow < 8 && tempRow > -1 && tempRow == newRow) {
				if(notNull(board.pieceAt(newRow, newColl))) {
					return board.pieceAt(newRow, newColl).side == 1 - this.side;
				}
				return true;
			}
			return false;
				
		}
		return false;
	}
}
