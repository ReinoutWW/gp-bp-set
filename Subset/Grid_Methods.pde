// [GRID] Grid methods
public void fillEmptySlotsWithCards() {
  LinkedList<String> randomCards = getRandomCardsFromActiveDeck(countEmptyCardsInGrid(this.cardPlayfieldGrid));
  println("Got random cards.." + randomCards);
  
  this.cardPlayfieldGrid = addCardsToEmptyCardDeckSlots(this.cardPlayfieldGrid, randomCards);
}

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
  LinkedList<String> randomCards = new LinkedList<String>();
  for(int i = 0; i < randomCardsAmount && deckHasCardsLeft(); i++) {
    String randomCard = getRandomItem(this.activeCardDeck);
    randomCards.add(randomCard);
    activeCardDeck.remove(randomCard);
  }
  
  println("Got "+ randomCards.size() + " empty cards..");
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

public int countEmptyCardsInGrid(String[][] grid) {
  int emptyCards = 0;
  for(int row = 0; row < grid.length; row++) {
    for(int column = 0; column < grid[0].length; column++) {
      if(strIsNullOrEmpty(grid[row][column])) {
        emptyCards += 1;
      }
    }
  }
  
  return emptyCards;
}

public void expandGrid() {
  String[][] newField = new String[3][4];
  
  for(int row = 0; row < this.cardPlayfieldGrid.length; row++) {
    for(int column = 0; column < this.cardPlayfieldGrid[0].length; column++) {
      if(!strIsNullOrEmpty(this.cardPlayfieldGrid[row][column])) {
        newField[row][column] = this.cardPlayfieldGrid[row][column];
      }
    }
  }
  
  this.cardPlayfieldGrid = newField;
  fillEmptySlotsWithCards();
  this.CONTROLBARWIDTH = this.cardPlayfieldGrid[0].length * CARDWIDTH;
  this.fieldExandUsed = true;
}
