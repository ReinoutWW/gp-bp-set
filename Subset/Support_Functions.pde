// [DEBUG] Debug methods or help methods
// simular to extension methods

public int[] calculateSymbolPosition(int row, int column, int index, int totalSymbols, int symbolWidth, int symbolHeight) {
    // Ensure even spacing by calculating the vertical spacing correctly
    int spacing = (CARDHEIGHT - (symbolHeight * totalSymbols)) / (totalSymbols + 1);  
    int x = column * CARDWIDTH + ((CARDWIDTH - symbolWidth) / 2); // Center horizontally within the card
    int y = row * CARDHEIGHT + spacing + (index * (symbolHeight + spacing)); // Adjust vertical spacing
    return new int[]{x, y};
}

public void reduceScoreMultiplier() {
  this.userScoreMultiplier = 0.5f;
}

public void addScore() {
  this.userScore = this.userScore + round(SETFOUNDSCORE * this.userScoreMultiplier);
}

void clearSelection() {
  this.selectedCards = new LinkedList<String>();
}

public boolean userHasSetSelection() {
  return (this.selectedCards.size() == MAXCARDSELECTION);
}

public boolean cardIsInSelection(String card) {
  return this.selectedCards.contains(card);
}

public boolean isValidSetSelection() {
    return isValidSet(this.selectedCards.get(0), this.selectedCards.get(1), this.selectedCards.get(2));
}

public void addOrRemoveCardToSelection(String card) {
  if(this.selectedCards.contains(card)) {
    this.selectedCards.remove(card);
  } else {
    this.selectedCards.add(card);
  }
}

public String getRandomItem(LinkedList<String> items) {
  int randomIndex = (int) ((Math.random() * items.size()));
  return items.get(randomIndex);
}

public void printSetStatistics() {
  println("");
  int validSetsInPlayfield = countValidSetsInGrid(this.cardPlayfieldGrid);
  println("Valid sets found: " + validSetsInPlayfield + ". And possible unique combinations: " + printPossibleTrioCombinations(this.cardPlayfieldGrid));
  println("");
}

public void printGrid(String[][] playfield) {
  for(int rowI = 0; rowI < playfield.length; rowI++) {
    String row = "grd: ";
    for(int columnI = 0; columnI < playfield[rowI].length; columnI++) {
      row += " " + playfield[rowI][columnI];
    }
    println(row);
  }
}

private void printWindowGridSize(String[][] grid) {
  int gridWidth = grid[0].length * CARDWIDTH;
  int gridHeight = grid.length * CARDHEIGHT;
  println("Gridsize: " + gridWidth + " x " + gridHeight);
}

// To see the effect on space and time complexity.
public long printPossibleTrioCombinations(String[][] cardsGrid) {
   int n = getGridSize(cardsGrid); // Total number of items
   int r = 3; // Number of combinations
   return calculateCombination(n, r);
}

public static long calculateCombination(int n, int r) {
    return factorial(n) / (factorial(r) * factorial(n - r));
}

public static long factorial(int n) {
    long result = 1;
    for (int i = 2; i <= n; i++) {
        result *= i;
    }
    return result;
}

public boolean betweenNums(int from, int to, int value) {
  return (value >= from && value <= to);
}

public static boolean strIsNullOrEmpty(String str) {
  if(str == null) {
    return true;
  } else if(str.trim().isEmpty()) {
    return true;
  }
  return false;
}
