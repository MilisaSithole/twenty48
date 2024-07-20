import java.util.ArrayList;

public class Game{
    int rows, cols;
    float wid;

    Block[][] board;

    public Game(int boardSize){
        this.rows = boardSize;
        this.cols = boardSize;
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
        board[availBlocks[newBlock] / rows][availBlocks[newBlock] % cols].assign();
    }

    void update(){
        drawBoard();
        if(isGameOver())
            surface.setTitle("Game Over");
        
    }

    void drawBoard(){
        for(int r = 0; r < rows; r++)
            for(int c = 0; c < cols; c++)
                board[r][c].draw(r, c, wid);
    }

    void moveUp(){
        boolean moved = false;

        for(int c = 0; c < cols; c++){
            for(int r = 1; r < rows; r++){
                if(board[r][c].isEmpty())
                    continue;
                
                int moveToRow = r;
                for(int moveTo = moveToRow-1; moveTo >= 0; moveTo--){
                    if(board[moveTo][c].isEmpty())
                        moveToRow = moveTo;
                    else if(board[moveTo][c].equals(board[r][c])){
                        moveToRow = moveTo;
                        break;
                    } else
                        break;
                }

                if(moveToRow != r){
                    if(board[moveToRow][c].isEmpty())
                        board[moveToRow][c].newValue(board[r][c]);
                    else
                        board[moveToRow][c].merge();
                    board[r][c].empty();
                    moved = true;
                }
            }
        }

        if(moved)
            assignNewBlock();
    }

    void moveDown(){
        boolean moved = false;

        for(int c = 0; c < cols; c++){
            for(int r = rows-2; r >= 0; r--){
                if(board[r][c].isEmpty())
                    continue;

                int moveToRow = r;
                for(int moveTo = moveToRow+1; moveTo < rows; moveTo++){
                    if(board[moveTo][c].isEmpty())
                        moveToRow = moveTo;
                    else if(board[moveTo][c].equals(board[r][c])){
                        moveToRow = moveTo;
                        break;
                    } else
                        break;
                }

                if(moveToRow != r){
                    if(board[moveToRow][c].isEmpty())
                        board[moveToRow][c].newValue(board[r][c]);
                    else
                        board[moveToRow][c].merge();
                    board[r][c].empty();
                    moved = true;
                }
            }
        }

        if(moved)
            assignNewBlock();
    }

    void moveLeft(){
        boolean moved = false;

        for(int r = 0; r < rows; r++){
            for(int c = 1; c < cols; c++){
                if(board[r][c].isEmpty())
                    continue;
                
                int moveToCol = c;
                for(int moveTo = moveToCol-1; moveTo >= 0; moveTo--){
                    if(board[r][moveTo].isEmpty())
                        moveToCol = moveTo;
                    else if(board[r][moveTo].equals(board[r][c])){
                        moveToCol = moveTo;
                        break;
                    } else
                        break;
                }

                if(moveToCol != c){
                    if(board[r][moveToCol].isEmpty())
                        board[r][moveToCol].newValue(board[r][c]);
                    else
                        board[r][moveToCol].merge();
                    board[r][c].empty();
                    moved = true;
                }
            }
        }

        if(moved)
            assignNewBlock();
    }

    void moveRight(){
        boolean moved = false;

        for(int r = 0; r < rows; r++){
            for(int c = cols-2; c >= 0; c--){
                if(board[r][c].isEmpty())
                    continue;
                
                int moveToCol = c;
                for(int moveTo = moveToCol+1; moveTo < cols; moveTo++){
                    if(board[r][moveTo].isEmpty())
                        moveToCol = moveTo;
                    else if(board[r][moveTo].equals(board[r][c])){
                        moveToCol = moveTo;
                        break;
                    } else
                        break;
                }

                if(moveToCol != c){
                    if(board[r][moveToCol].isEmpty())
                        board[r][moveToCol].newValue(board[r][c]);
                    else
                        board[r][moveToCol].merge();
                    board[r][c].empty();
                    moved = true;
                }
            }
        }

        if(moved)
            assignNewBlock();
    }

    boolean isBoardFull(){
        for(int r = 0; r < rows; r++)
            for(int c = 0; c < cols; c++)
                if(board[r][c].value == -1)
                    return false;

        return true;
    }

    boolean isMovePossible(){
        if(isBoardFull()){
            for(int i = 0; i < rows * cols; i++){
                int r = i / rows;
                int c = i % cols;

                // Check above
                if(r > 0 && board[r][c].equals(board[r-1][c]))
                    return true;
                // Check left
                if(c > 0 && board[r][c].equals(board[r][c-1]))
                    return true;
            }
        }
        return false;
    }

    boolean isGameOver(){
        return !isMovePossible();
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
        if(value < 75) 
            value = 0;
        else 
            value = 1;

        blockCol = blockCols[value];
    }

    boolean isEmpty(){
        return value == -1;
    }

    void empty(){
        value = -1;
    }

    boolean equals(Block other){
        return value == other.value;
    }

    void newValue(Block other){
        value = other.value;
        blockCol = blockCols[value];
    }

    void merge(){
        value++;
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
