class ScreenRatio {
  static double heightRatio;
  static double widthRatio;
  static double screenHeight;
  static double screenWidth;
  static double deviceRatio;

  static setScreenRatio(
      double currentScreenHeight, double currentScreenWidth, double currentDeviceRatio) {
    deviceRatio = currentDeviceRatio;
    screenHeight = currentScreenHeight;
    screenWidth = currentScreenWidth;
    heightRatio = currentScreenHeight / 667.0;
    widthRatio = currentScreenWidth / 375.0;
  }
}
