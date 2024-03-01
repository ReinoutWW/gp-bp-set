// [GRID] Card grid methods

// [DECK] Deck management methods
public String[][] addCardsToEmptyCardDeckSlots(String[][] cardsGrid, LinkedList<String> cards) {
  if(cards.size() != countEmptyCardsInGrid(cardsGrid)) {
     return new String[][]{};
  };
  
  println("Adding cards to empty grid..");
  for(int rowI = 0; rowI < cardsGrid.length; rowI++) {
    for(int columnI = 0; columnI < cardsGrid[rowI].length; columnI++) {
      if(strIsNullOrEmpty(cardsGrid[rowI][columnI])) {
        cardsGrid[rowI][columnI] = cards.pop();
      }
    }
  }
  
  return cardsGrid;
}

public LinkedList<String> generateCards(String[] colors, String[] shapes, int maxShapesPerCard) {
  if(colors.length == 0 || shapes.length == 0 || maxShapesPerCard < 1) {
    return new LinkedList<String>();
  }
    
  LinkedList<String> cards = new LinkedList<String>();
  
  for(int colorI = 0; colorI < colors.length; colorI++) {
     for(int shapeI = 0; shapeI < shapes.length; shapeI++) { 
       for(int maxShapesI = 0; maxShapesI < maxShapesPerCard; maxShapesI++) { 
          String colorSymbol = colors[colorI].substring(0, 1);
          String shapeSymbol = shapes[shapeI].substring(0, 1);
          String shapeAmount = str(maxShapesI + 1);
          
          String card = shapeAmount + colorSymbol + shapeSymbol;
          cards.add(card);
       }
     }
  }
  
  return cards;
};

void replaceSelectedCardsWithNewCards() {
  for(int row = 0; row < this.cardPlayfieldGrid.length; row++) {
    for(int column = 0; column < this.cardPlayfieldGrid[0].length; column++) {
      String card = this.cardPlayfieldGrid[row][column];
      String newCard = "";
      
      if(cardIsInSelection(card)) {
        this.activeCardDeck.remove(card);
        LinkedList<String> newCards = getRandomCardsFromActiveDeck(1);
        
        if(newCards.size() != 0) {
          newCard = newCards.get(0);
        }
        
        this.cardPlayfieldGrid[row][column] = newCard;
      }
    }
  }
}

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
  int gridWidth = grid[0].length * CARD_WIDTH;
  int gridHeight = grid.length * CARD_HEIGHT;
  int windowHeight = gridHeight + CONTROL_BAR_HEIGHT;
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
  int currentWidth = this.cardPlayfieldGrid[0].length;
  int currentHeight = this.cardPlayfieldGrid.length;
  
  int newWidth = currentWidth; // new column
  int newHeight = currentHeight + 1; // Same as before
  String[][] newField = new String[newHeight][newWidth];
  
  for(int row = 0; row < this.cardPlayfieldGrid.length; row++) {
    for(int column = 0; column < this.cardPlayfieldGrid[0].length; column++) {
      if(!strIsNullOrEmpty(this.cardPlayfieldGrid[row][column])) {
        newField[row][column] = this.cardPlayfieldGrid[row][column];
      }
    }
  }
  
  println("Print grid");
  printGrid(newField);
  
  this.cardPlayfieldGrid = newField;
  fillEmptySlotsWithCards();
  width = this.cardPlayfieldGrid[0].length * CARD_WIDTH;
  this.fieldExandUsed = true;
}
