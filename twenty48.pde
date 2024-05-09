Game game;
color bg = color(39, 39, 75);

void setup() {
    size(800, 800);
    game = new Game(4, 4);
}

void draw() {
    background(bg);    
    game.drawBoard();
}

void keyPressed() {
    if(key == 'r')
        game = new Game(4, 4);   
}
