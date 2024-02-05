// [DRAW] Drawing methods

// This method is called often on runtime to update the UI
public void drawControlBar() {
  int controlbarStartX =  0; 
  int controlbarStartY = this.cardPlayfieldGrid.length * CARDHEIGHT;
  
  fill(STYLES.get("ControlBarBackground"));
  rect(controlbarStartX, controlbarStartY, this.CONTROLBARWIDTH, this.CONTROLBARHEIGHT);
  
  drawInfoText(controlbarStartX, controlbarStartY);
  drawExpandButton(controlbarStartX, controlbarStartY);
}

public void drawExpandButton(int controlbarStartx, int controlbarStartY) {  
  int buttonWidth = 125;
  int buttonHeight = 50;
  
  int buttonStartX = controlbarStartx + CONTROLBARWIDTH - buttonWidth - COMPONENTPADDING[0];
  int buttonStartY = controlbarStartY + COMPONENTPADDING[1];
  color buttonTextColor = color(245, 245, 245);
  
  String buttonId = "Button__ExpandGrid";
  int[] buttonClickData = new int[] { buttonStartX, (buttonStartX + buttonWidth), buttonStartY, (buttonStartY + buttonHeight)}; // fromX, toX, fromY, toY
  this.BUTTONS.put(buttonId, buttonClickData);
  
  fill(this.hoveredButton == buttonId ? this.STYLES.get("ControlBarButton__Hover") : this.STYLES.get("ControlBarButton"));
  drawSquare(buttonStartX, buttonStartY, buttonWidth, buttonHeight);
  
  fill(255, 255, 255);
  drawText("Ik zie geen set", buttonStartX + COMPONENTPADDING[0], buttonStartY + buttonHeight / 2, buttonTextColor);
}

public void drawInfoText(int controlbarStartx, int controlbarStartY) {
  int textStartX = controlbarStartx + COMPONENTPADDING[0]; // Padding x
  int textStartY = controlbarStartY + COMPONENTPADDING[1]; // Padding y
  int textSpacingCorrection = FONTSIZE;
  int textSpacing = COMPONENTPADDING[0];
  int cardsDealt = this.initialCardDeck.size() - this.activeCardDeck.size();
  color textColor = this.STYLES.get("ControlBarText");
  
  // First value is for the found sets, second value is for the amount of sets still on the table + the given cards count from the deck.
  String setsFound = "Sets gevonden: " + this.setsFound;
  String setsOnTableAndGivenCards = "Sets op het veld: " + this.setsOnTable + ". (Aantal kaarten gedekt: " + cardsDealt + ")";
  String gameActive = "Spel actief: " + this.gameActive;
  
  drawText(setsFound, textStartX, textStartY + textSpacingCorrection * 1, textColor); // Text spacing correct = 1x text
  drawText(setsOnTableAndGivenCards, textStartX, textStartY + (textSpacingCorrection * 2) + textSpacing, textColor); // Text spacing correct = 2x text
  drawText(gameActive, textStartX, textStartY + (textSpacingCorrection * 3) + (textSpacing * 2), textColor); // Text spacing correct = 3x text
}

public void drawText(String text, int x, int y, color textColor) {
  fill(textColor);
  textLeading(FONTSIZE);
  textSize(FONTSIZE);
  text(text, x, y);  
}

public void drawCardInGrid(int row, int column, String cardSymbol) {
  int x = column * CARDHEIGHT;
  int y = row * CARDWIDTH;
  int cardWith = CARDWIDTH;
  int cardHeight = CARDHEIGHT;
  
  // Background
  fill(getCardBackground(cardSymbol));
  
  // Hover styling
  if(cardSymbol == this.hoveredCard) {
    fill(STYLES.get("CardBackground__Hover"));
  }
  
  drawSquare(x, y, cardWith, cardHeight);
  drawSymbol(row, column, cardSymbol);
}

public int getCardBackground(String cardSymbol) {
  return selectedCards.contains(cardSymbol) ? STYLES.get("CardBackground__Active") : STYLES.get("CardBackground");
}

public void drawSymbol(int row, int column, String cardSymbol) {
    // Validate if valid symbol
    //Matcher cardSymbolMatcher = this.cardSymbolPattern.matcher(cardSymbol);
    if(strIsNullOrEmpty(cardSymbol)) {
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
    rect(x, y, width, height, this.STYLES.get("BorderRadius__Element"));
}

public void drawEllipse(int x, int y, int width, int height) {
    ellipse(x + width / 2, y, width, height);
}
