// [DRAW] Drawing methods
// Shapes will draw without a standard color.
// Text will default to the selected color in the STYLES HashMap.

// Styling
PFont FONT_FAMILY;
final int FONT_SIZE = 16;
final int[] COMPONENT_PADDING = new int[] { 10, 10 }; // x, y
HashMap<String, Integer> STYLES = new HashMap<String, Integer>() {{
  put("TextColor", color(20, 20, 20)); 
  put("Card__Background", color(245, 245, 245));
  put("Card__Active", color(249, 239, 219));
  put("Card__Hover", color(245, 242, 235));
  put("Symbol__Red", color(204, 110, 110));
  put("Symbol__Blue", color(110, 144, 204));
  put("Symbol__Green", color(110, 204, 135)); 
  put("ControlBar__Background", color(245, 238, 225)); 
  put("ControlBar__Text", color(20, 20, 20)); 
  put("btn__Text", color(20, 20, 20)); 
  put("btn__FontSize", 12); 
  put("btn__Background", color(235, 208, 176)); 
  put("btn__Hover", color(225, 219, 211)); 
  put("BorderRadius__Element", 10); 
  put("EndScreen__Background", color(245, 238, 225)); 
  put("EndScreen__Text", color(20, 20, 20)); 
  put("Score__Background", color(245, 245, 245)); 
}};

public void addAndDrawButton(int x, int y, int buttonWidth, int buttonHeight, String buttonId, String buttonText) {  
  int[] buttonData = new int[] { x, y, buttonWidth, buttonHeight}; // fromX, toX, width, height
  AddEventBind(buttonId, buttonData); // This will calculate the buttons dimensions for click event validation
  
  drawButton(buttonText, x, y, buttonWidth, buttonHeight, buttonId);
}

public void drawButton(String text, int x, int y, int buttonWidth, int buttonHeight, String buttonId) {
  int buttonTextX = x + (buttonWidth / 2);
  int buttonTextY =  y + (buttonHeight / 2);
    
  color buttonColor = this.STYLES.get("btn__Background");
  color buttonColorHover = this.STYLES.get("btn__Hover");
  color buttonTextColor = this.STYLES.get("btn__Text");
  color buttonFontSize = this.STYLES.get("btn__FontSize");
  
  fill(this.hoveredButton == buttonId ? buttonColorHover : buttonColor);
  drawSquare(x, y, buttonWidth, buttonHeight);
  
  fill(buttonTextColor);
  drawHeading(text, buttonTextX, buttonTextY, buttonTextColor, buttonFontSize);
}

public void drawInfoText(int controlbarStartx, int controlbarStartY) {
  int textStartX = controlbarStartx + COMPONENT_PADDING[0]; // Padding x
  int textStartY = controlbarStartY + COMPONENT_PADDING[1]; // Padding y
  int textSpacingCorrection = FONT_SIZE;
  int textSpacing = COMPONENT_PADDING[0];
  int cardsDealt = this.initialCardDeck.size() - this.activeCardDeck.size();
  color textColor = STYLES.get("TextColor");
  
  // First value is for the found sets, second value is for the amount of sets still on the table + the given cards count from the deck.
  String setsFound = "Sets gevonden: " + this.setsFound;
  String setsOnTableAndGivenCards = "Sets op het veld: " + this.setsOnTable + ". ( Aantal kaarten gedekt: " + cardsDealt + " )";
  String userScore = "Score: " + this.userScore;
  
  drawText(setsFound, textStartX, textStartY + textSpacingCorrection * 1, textColor); // Text spacing correct = 1x text
  drawText(setsOnTableAndGivenCards, textStartX, textStartY + (textSpacingCorrection * 2) + textSpacing, textColor); // Text spacing correct = 2x text
  drawText(userScore, textStartX, textStartY + (textSpacingCorrection * 3) + (textSpacing * 2), textColor); // Text spacing correct = 3x text
}

public void drawCardInGrid(int row, int column, String cardSymbol) {
  int x = column * CARD_HEIGHT;
  int y = row * CARD_WIDTH;
  int cardWith = CARD_WIDTH;
  int cardHeight = CARD_HEIGHT;
  
  // Background
  fill(getCardBackground(cardSymbol));
  
  // Hover styling
  if(cardSymbol == this.hoveredCard && !this.selectedCards.contains(this.hoveredCard)) {
    fill(STYLES.get("Card__Hover"));
  }
  
  drawSquare(x, y, cardWith, cardHeight);
  drawSymbol(row, column, cardSymbol);
}

public int getCardBackground(String cardSymbol) {
  return selectedCards.contains(cardSymbol) ? STYLES.get("Card__Active") : STYLES.get("Card__Background");
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
        int[] symbolPosition = calculateSymbolPosition(row, column, i, symbolAmount, this.SYMBOL_WIDTH, this.SYMBOL_HEIGHT);
        drawShape(symbolPosition[0], symbolPosition[1], this.SYMBOL_WIDTH, this.SYMBOL_HEIGHT, symbolShape);
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
    ellipse(x + width / 2, y + height / 2, width, height);
}

public void drawHeading(String text, int x, int y, color textColor, int... fontSize) {
  int defFontSize = (fontSize.length > 0) ? fontSize[0] : FONT_SIZE;
  color defTextColor = (textColor == 0) ? textColor : STYLES.get("TextColor");
  
  textFont(this.FONT_FAMILY);
  shapeMode(CENTER);
  textAlign(CENTER, CENTER);
  fill(defTextColor);
  textSize(defFontSize);
  text(text, x, y);
}

public void drawText(String text, int x, int y, color textColor, int... fontSize) {
  int defFontSize = (fontSize.length > 0) ? fontSize[0] : FONT_SIZE;
  color defTextColor = (textColor == 0) ? textColor : STYLES.get("TextColor");
  
  textFont(this.FONT_FAMILY);
  textAlign(LEFT);
  fill(defTextColor);
  textLeading(defFontSize);
  textSize(defFontSize);
  text(text, x, y);  
}
