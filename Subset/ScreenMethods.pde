public void drawHomeScreen() {
  String homeScreenHeading = "Welkom bij Subset";
  String homeScreenSubheading = "Een leuk interactief spel";
  int headingFontsize = 30;
  int subHeadingFontsize = 16;

  int endScreenWidth = this.cardPlayfieldGrid[0].length * this.CARD_WIDTH;
  int endScreenHeight = this.cardPlayfieldGrid.length * this.CARD_HEIGHT + this.CONTROL_BAR_HEIGHT;
  int textSpacingY = 25;

  int textX = endScreenWidth / 2; // Centre
  int textY = 100;
  color textColor = STYLES.get("TextColor");
  
  fill(this.STYLES.get("EndScreen__Background"));
  drawSquare(0, 0, endScreenWidth, endScreenHeight);
  
  drawHeading(homeScreenHeading, textX, textY, textColor, headingFontsize);
  drawHeading(homeScreenSubheading, textX, textY + textSpacingY, textColor, subHeadingFontsize);
  
  int buttonWidth = 200;
  int buttonHeight = 50;
  int startButtonX = (endScreenWidth / 2) - (buttonWidth / 2 ); // Centre button
  int startButtonY = textY + 100; // 100 below heading
  
  addAndDrawButton(startButtonX, startButtonY, buttonWidth, buttonHeight, "Button__StartSet", "Start!");
}

// This method is called often on runtime to update the UI
public void drawControlBar() {
  int controlbarStartX =  0; 
  int controlbarStartY = this.cardPlayfieldGrid.length * CARD_HEIGHT;
  
  fill(STYLES.get("ControlBar__Background"));
  rect(controlbarStartX, controlbarStartY, width, this.CONTROL_BAR_HEIGHT);
  
  drawInfoText(controlbarStartX, controlbarStartY);
  
  if(!this.fieldExandUsed && this.activeCardDeck.size() >= 3) {
    int buttonWidth = 125;
    int buttonHeight = 30;
    int buttonX = width - buttonWidth - COMPONENT_PADDING[0];
    int buttonY = height - buttonHeight - COMPONENT_PADDING[1];
  
    addAndDrawButton(buttonX, buttonY, buttonWidth, buttonHeight, "Button__ExpandGrid", "Ik zie geen set");
  }
}

public void drawEndScore() {
  int scoreContainerWidth = width / 2;
  int scoreContainerHeight = 250;
  int scoreContainerX = (width / 2) - (scoreContainerWidth / 2);
  int scoreContainerY = height / 2;
  
  fill(this.STYLES.get("Score__Background"));
  drawSquare(scoreContainerX, scoreContainerY, scoreContainerWidth, scoreContainerHeight);

  int textPaddingY = COMPONENT_PADDING[1];
  int textSpaceCorrection = FONT_SIZE + textPaddingY;
  int textX = scoreContainerX + COMPONENT_PADDING[0]; 
  int textY = scoreContainerY + textPaddingY + textSpaceCorrection;
  
  String heading = "Game over!";
  String setsFound = "Sets gevonden: " + this.setsFound;
  String userScore = "Eindscore: " + this.userScore;
  
  textAlign(LEFT);
  color textColor = this.STYLES.get("EndScreen__Text");
  
  drawText(heading, textX, textY, textColor);
  drawText(setsFound, textX, textY + (textSpaceCorrection * 1), textColor);
  drawText(userScore, textX, textY + (textSpaceCorrection * 2), textColor);
}
