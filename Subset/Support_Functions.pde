// [DEBUG] Debug methods or help methods
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
