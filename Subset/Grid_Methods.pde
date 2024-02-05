// [GRID] Grid methods
public void drawCardsInGrid(String[][] playfieldGrid) {
  for(int row = 0; row < playfieldGrid.length; row++) {
    for(int column = 0; column < playfieldGrid[0].length; column++) {
      drawCardInGrid(row, column, playfieldGrid[row][column]);
    }
  }
}

public int getGridSize(String[][] grid) {
  return grid.length * grid[0].length;
}

public LinkedList<String> getRandomCardsFromActiveDeck(int randomCardsAmount) {
  println("Getting random cards..");
  
  LinkedList<String> randomCards = new LinkedList<String>();
  for(int i = 0; i < randomCardsAmount && deckHasCardsLeft(); i++) {
    String randomCard = getRandomCard(this.activeCardDeck);
    randomCards.add(randomCard);
    activeCardDeck.remove(randomCard);
  }
  
  return randomCards;
}

public boolean deckHasCardsLeft() {
  return this.activeCardDeck.size() > 0;
}

private void sizeWindowToGridAndControlbar(String[][] grid) {
  int gridWidth = grid[0].length * CARDWIDTH;
  int gridHeight = grid.length * CARDHEIGHT;
  int windowHeight = gridHeight + CONTROLBARHEIGHT;
  int windowWidth = gridWidth;
  
  windowResize(windowWidth, windowHeight);
}

// o(n*m) complexity
public String[] gridToArray(String[][] grid) {
  String[] itemsArray = new String[getGridSize(grid)];
  int i = 0;
  for(int row = 0; row < grid.length; row++) {
    for(int column = 0; column < grid[0].length; column++) {
      itemsArray[i] = grid[row][column];
      i++;
    }
  }
  return itemsArray;
}
