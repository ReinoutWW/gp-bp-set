public void drawHomeScreen() {
  String homeScreenHeading = "Welkom bij Subset";
  String homeScreenSubheading = "Een leuk interactief spel";
  String startButtonText = "Start";
  int headingFontsize = 30;
  int subHeadingFontsize = 16;

  int endScreenWidth = this.cardPlayfieldGrid[0].length * this.CARDWIDTH;
  int endScreenHeight = this.cardPlayfieldGrid.length * this.CARDHEIGHT + this.CONTROLBARHEIGHT;
  int textSpacingY = 25;

  int textX = endScreenWidth / 2; // Centre
  int textY = 100;
  
  fill(this.STYLES.get("EndScreen__Background"));
  drawSquare(0, 0, endScreenWidth, endScreenHeight);
  
  drawHeading(homeScreenHeading, textX, textY, headingFontsize);
  drawHeading(homeScreenSubheading, textX, textY + textSpacingY, subHeadingFontsize);
  
  int buttonWidth = 200;
  int buttonHeight = 50;
  int startButtonX = (endScreenWidth / 2) - (buttonWidth / 2 ); // Centre button
  int startButtonY = textY + 100; // 100 below heading
  
  drawStartButton(startButtonText, startButtonX, startButtonY, buttonWidth, buttonHeight);
  drawScore();
}

public void drawScore() {
  int scoreContainerWidth = width / 2;
  int scoreContainerHeight = 250;
  int scoreContainerX = (width / 2) - (scoreContainerWidth / 2);
  int scoreContainerY = height / 2;
  
  fill(#ffffff);
  drawSquare(scoreContainerX, scoreContainerY, scoreContainerWidth, scoreContainerHeight);
}

public void drawStartButton(String startButtonText, int startButtonX, int startButtonY, int buttonWidth, int buttonHeight) {
  int startButtonTextX = startButtonX + buttonWidth / 2;
  int startButtonTextY = startButtonY + buttonHeight / 2;
  int buttonTextColor = this.STYLES.get("TextColor");

  String buttonId = "Button__StartSet";
  int[] buttonClickData = new int[] { startButtonX, (startButtonX + buttonWidth), startButtonY, (startButtonY + buttonHeight)}; // fromX, toX, fromY, toY
  AddEventBind(buttonId, buttonClickData);
  
  fill(this.hoveredButton == buttonId ? this.STYLES.get("EndScreenButton__Hover") : this.STYLES.get("EndScreenButton__Background"));
  drawSquare(startButtonX, startButtonY, buttonWidth, buttonHeight);
  
  drawText(startButtonText, startButtonTextX, startButtonTextY, buttonTextColor);
}
