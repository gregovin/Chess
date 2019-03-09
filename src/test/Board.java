package test;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import javax.swing.JApplet;
/* Images By en:User:Cburnett - 
 * Own workThis W3C-unspecified vector image was created with Inkscape.,
 * CC BY-SA 3.0, https://commons.wikimedia.org/w/index.php?curid=1499809
 */
public class Board extends JApplet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Piece[][] piecelist = new Piece[8][8];
	public void init() {
		piecelist[0][0] = new Rook(0, "test/img/whiteRook.png", 0);
		piecelist[0][7] = new Rook(0, "test/img/whiteRook.png", 7);
		piecelist[7][0] = new Rook(1, "test/img/blackRook.png", 0);
		piecelist[7][7] = new Rook(1, "test/img/blackRook.png", 7);
		piecelist[0][1] = new Knight(0, "test/img/whiteKnight.png", 1);
		piecelist[0][6] = new Knight(0, "test/img/whiteKnight.png", 6);
		piecelist[7][1] = new Knight(1, "test/img/blackKnight.png", 1);
		piecelist[7][6] = new Knight(1, "test/img/blackKnight.png", 6);
		piecelist[0][2] = new Bishop(0, "test/img/whiteBishop.png", 2);
		piecelist[0][5] = new Bishop(0, "test/img/whiteBishop.png", 5);
		piecelist[7][2] = new Bishop(1, "test/img/blackBishop.png", 2);
		piecelist[7][5] = new Bishop(1, "test/img/blackBishop.png", 5);
		piecelist[0][3] = new King(0, "test/img/whiteKing.png");
		piecelist[7][3] = new King(1, "test/img/blackKing.png");
		piecelist[0][4] = new Queen(0, "test/img/whiteQueen.png");
		piecelist[7][4] = new Queen(1, "test/img/blackQueen.png");
		for(int i = 0; i < 8; i++) {
			piecelist[1][i] = new Pawn(0, "test/img/whitePawn.png", i);
			piecelist[6][i] = new Pawn(1, "test/img/blackPawn.png", i);
		}
		setSize(256,256);
		setBackground(Color.WHITE);
		repaint();
	}
	public void paint(Graphics g) {
		
		Graphics2D g2 = (Graphics2D) g;
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, 256, 256);
		g.setColor(new Color(50, 50, 50));
		for(int row = 0; row < 8; row ++) {
			for(int coll = row % 2; coll < 8; coll +=2) {
				g.fillRect(coll * 32, row * 32, 32, 32);
			}
		}
		for(int i = 0; i < this.piecelist.length; i ++) {
			for(int j = 0; j < this.piecelist[i].length; j ++) {
				if(Piece.notNull(piecelist[i][j])) {
					piecelist[i][j].draw(g2);
				}
			}
		}
	}
	public Piece pieceAt(int row, int coll) {
		return piecelist[row][coll];
	}
	public void captureOn(int row, int coll) {
		piecelist[row][coll] = null;
	}
	public Piece[] kings() {
		Piece[] res = new Piece[2];
		for(int row = 0; row < piecelist.length; row++) {
			for(int coll = 0; coll<piecelist[row].length;coll++) {
				if(Piece.notNull(this.pieceAt(row, coll)) && (this.pieceAt(row,coll).type==0)) {
					res[this.pieceAt(row, coll).side] = this.pieceAt(row, coll);
				}
			}
		}
		return res;
	}
}
