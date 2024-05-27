part of theme;

class ThemeModel extends base.ThemeModel {

  final Color primaryColor2;
  final Color gray1;
  final Color gray2;
  final Color gray3;
  final Color textColor1;
  final Color textColor2;
  final Color disabledSurface;
  final Color disabledText;
  final Color stopColor1;
  final Color stopColor2;

  const ThemeModel({
    required super.name,
    super.primaryColor,
    super.secondaryColor,
    super.backgroundColor,
    super.surfaceColor,
    super.buttonColor,
    super.textColor,
    super.errorColor,
    super.fontFamily,
    this.primaryColor2 = Colors.purpleAccent,
    this.gray1 = Colors.purpleAccent,
    this.gray2 = Colors.purpleAccent,
    this.gray3 = Colors.purpleAccent,
    this.textColor1 = Colors.purpleAccent,
    this.textColor2 = Colors.purpleAccent,
    this.disabledSurface = Colors.purpleAccent,
    this.disabledText = Colors.purpleAccent,
    this.stopColor1 = Colors.purpleAccent,
    this.stopColor2 = Colors.purpleAccent,
  });
}