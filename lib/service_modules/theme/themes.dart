part of theme;

class Themes {
  static List<base.ThemeModel> get all => [DARK];

  static const ThemeModel DARK = const ThemeModel(
    name: 'dark',
    fontFamily: 'Gilroy',
    primaryColor: Color(0xFF638DFB),
    primaryColor2: Color(0xFF86A6FB),
    backgroundColor: Colors.black,
    gray1: Color(0xFF212121),
    gray2: Color(0xFF313131),
    gray3: Color(0xFF555555),
    textColor1: Color(0xFF949494),
    textColor2: Color(0xFFCECECE),
    disabledSurface: Color(0xFF373737),
    disabledText: Color(0xFF7C7C7C),
    stopColor1: Color(0xFFFD6A4E),
    stopColor2: Color(0xFFFA9A87),
  );
}
