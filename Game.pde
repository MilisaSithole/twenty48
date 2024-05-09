import java.util.ArrayList;

public class Game{
    int rows, cols;
    float wid;

    Block[][] board;

    public Game(int rows, int cols){
        this.rows = rows;
        this.cols = cols;
        wid = width / cols;

        board = new Block[rows][cols];
        for(int r = 0; r < rows; r++)
            for(int c = 0; c < cols; c++)
                board[r][c] = new Block();

        assignNewBlock();
        assignNewBlock();
    }

    int[] getAvailBlocks(){
        ArrayList<Integer> availBlocks = new ArrayList<Integer>();

        for(int r = 0; r < rows; r++)
            for(int c = 0; c < cols; c++)
                if(board[r][c].value == -1)
                    availBlocks.add(r * rows + c);

        int[] availableBlocks = new int[availBlocks.size()];
        for(int i = 0; i < availBlocks.size(); i++)
            availableBlocks[i] = availBlocks.get(i);
        return availableBlocks;
    }

    void assignNewBlock(){
        int[] availBlocks = getAvailBlocks();
        int newBlock = (int)random(availBlocks.length);
        int r = availBlocks[newBlock] / rows;
        int c = availBlocks[newBlock] % cols;

        board[r][c].assign();
    }

    void drawBoard(){
        for(int r = 0; r < rows; r++)
            for(int c = 0; c < cols; c++)
                board[r][c].draw(r, c, wid);
    }
}

class Block{
    color blockCol;
    int value; //-1 means empty

    color textCol = color(204, 204, 255);
    color[] blockCols = {color(50, 124, 255),
                         color(67, 112, 233),
                         color(84, 100, 211),
                         color(101, 88, 189),
                         color(118, 76, 168),
                         color(135, 64, 146),
                         color(152, 52, 124),
                         color(169, 40, 103),
                         color(186, 28, 81),
                         color(203, 16, 69),
                         color(221, 4, 38)};

    Block(){
        value = -1;
    }

    void assign(){
        value = (int)random(100);
        if(value < 75) value = 0;
        else value = 1;
        blockCol = blockCols[value];
    }

    void draw(int r, int c, float w){
        if(value == -1) return;

        noStroke();
        fill(blockCol);
        rect(c * w, r * w, w, w);

        fill(textCol);
        textAlign(CENTER, CENTER);
        textSize(w / 2);
        text((int)Math.pow(2, value+1), c * w + w/2, r * w + w/2);
    }
}
