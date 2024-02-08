public void drawHomeScreen() {
  String homeScreenHeading = "Welkom bij Subset";
  String homeScreenSubheading = "Een leuk interactief spel";
  int headingFontsize = 30;
  int subHeadingFontsize = 16;

  int endScreenWidth = this.cardPlayfieldGrid[0].length * this.CARDWIDTH;
  int endScreenHeight = this.cardPlayfieldGrid.length * this.CARDHEIGHT + this.CONTROLBARHEIGHT;
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
