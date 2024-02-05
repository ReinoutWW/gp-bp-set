// [DRAW] Drawing methods

public void drawControlBar() {
  int x =  0; 
  int y = this.cardPlayfieldGrid.length * CARDHEIGHT;
  int controlBarWidth = this.cardPlayfieldGrid[0].length * CARDWIDTH;
  
  println("X: " + x + ". Y: " + y);
  
  fill(STYLES.get("ControlBarBackground"));
  rect(x, y, controlBarWidth, this.CONTROLBARHEIGHT);
}

public void drawCardInGrid(int row, int column, String cardSymbol) {
  int x = column * CARDHEIGHT;
  int y = row * CARDWIDTH;
  int z = 0;
  int cardWith = CARDWIDTH;
  int cardHeight = CARDHEIGHT;
  
  // Background
  fill(getCardBackground(cardSymbol));
  
  // Hover styling
  if(cardSymbol == this.hoveredCard) {
    fill(STYLES.get("CardBackground__Hover"));
    //cardWith += 5;
    //cardHeight += 5;
    //x -= 2.5;
    //y -= 2.5;
    //z += 1;
  }
  
  rect(x, y, cardWith, cardHeight, z);

  drawSymbol(row, column, cardSymbol);
}

public int getCardBackground(String cardSymbol) {
  return selectedCards.contains(cardSymbol) ? STYLES.get("CardBackground__Active") : STYLES.get("CardBackground");
}

public void drawSymbol(int row, int column, String cardSymbol) {
    // Validate if valid symbol
    Matcher cardSymbolMatcher = this.cardSymbolPattern.matcher(cardSymbol);
    if(!cardSymbolMatcher.matches()) {
      return;
    }
  
    int symbolAmount = Integer.parseInt(cardSymbol.substring(0, 1));
    char symbolColor = cardSymbol.charAt(1);
    char symbolShape = cardSymbol.charAt(2);

    // Set the color for drawing
    setDrawColor(symbolColor);

    // Calculate and draw each symbol directly within the loop
    for (int i = 0; i < symbolAmount; i++) {
        int[] symbolPosition = calculateSymbolPosition(row, column, i, symbolAmount, this.SYMBOLWIDTH, this.SYMBOLHEIGHT);
        drawShape(symbolPosition[0], symbolPosition[1], this.SYMBOLWIDTH, this.SYMBOLHEIGHT, symbolShape);
    }
}

public void setDrawColor(char symbolColor) {
    switch (symbolColor) {
        case 'r': fill(this.STYLES.get("Symbol__Red")); break; // Red
        case 'g': fill(this.STYLES.get("Symbol__Green")); break; // Green
        case 'b': fill(this.STYLES.get("Symbol__Blue")); break; // Blue
        default: fill(0); // Default to black if unrecognized
    }
}

public int[] calculateSymbolPosition(int row, int column, int index, int totalSymbols, int symbolWidth, int symbolHeight) {
    // Ensure even spacing by calculating the vertical spacing correctly
    int spacing = (CARDHEIGHT - (symbolHeight * totalSymbols)) / (totalSymbols + 1);  
    int x = column * CARDWIDTH + ((CARDWIDTH - symbolWidth) / 2); // Center horizontally within the card
    int y = row * CARDHEIGHT + spacing + (index * (symbolHeight + spacing)); // Adjust vertical spacing
    return new int[]{x, y};
}

public void drawShape(int x, int y, int width, int height, char shape) {
    switch (shape) {
        case 't': drawTriangle(x, y, width, height); break;
        case 's': drawSquare(x, y, width, height); break;
        case 'e': drawEllipse(x, y, width, height); break;
    }
}


public void drawTriangle(int x, int y, int width, int height) {
    triangle(
        x + width / 2, y, 
        x + width, y + height, 
        x - width + width,  y + height
    );
}

public void drawSquare(int x, int y, int width, int height) {
    rect(x, y, width, height);
}

public void drawEllipse(int x, int y, int width, int height) {
    ellipse(x + width / 2, y, width, height);
}
