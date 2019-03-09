package test;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class Piece {
	public int type;
	// 0 is king, 1 is Queen, 2 is Rook, 3 is knight, 4 is bishop, 5 is pawn
	public int moves_made;
	public int coll;
	public int row;
	public int side;
	// 0 is white 1 is black
	public BufferedImage img;
	public Piece(int type, int coll, int row, String imgFilePath, int side) {
		this.type = type;
		this.coll = coll;
		this.row = row;
		this.moves_made = 0;
		this.side = side;
		try {
			
			img = ImageIO.read(new File(imgFilePath));
		} catch (IOException e) {
			System.out.println(e + "hi");
		}
	}
	public void draw(Graphics g) {
		g.drawImage(img, coll * 32, (7-row) * 32, 32, 32, null);
	}
	public boolean valid_move(int newRow, int newColl, Board board) {
		return true;
	}
	public boolean move(int newRow, int newColl, Board board) {
		if(this.valid_move(newRow, newColl, board)) {
			if(notNull(board.pieceAt(newRow, newColl))) {
				board.captureOn(newRow, newColl);
			}
			this.row = newRow;
			this.coll = newColl;
			moves_made ++;
			return true;
		}
		return false;
	}
	public static boolean notNull(Piece piece) {
		if (piece == null) {
			return false;
		}
		return true;
	}
	public void teleport(int newRow, int newColl) {
		this.row = newRow;
		this.coll = newColl;
	}
	public boolean inCheck(Board board) {
		return false;
	}
}
