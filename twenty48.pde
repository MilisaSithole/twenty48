Game game;
int gameSize = 4;
color bg = color(39, 39, 75);

void setup() {
    size(800, 800);
    game = new Game(gameSize);
}

void draw() {
    background(bg);    
    game.drawBoard();
}

void keyPressed() {
    if(key == 'r')
        game = new Game(gameSize);

    if(key == 'w' || keyCode == UP)
        game.moveUp();
    if(key == 's' || keyCode == DOWN)
        game.moveDown();
    if(key == 'a' || keyCode == LEFT)
        game.moveLeft();
    if(key == 'd' || keyCode == RIGHT)
        game.moveRight();
}
