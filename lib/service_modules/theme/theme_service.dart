part of theme;

class ThemeService extends base.ThemeService<ThemeModel> {
  static ThemeService i = ThemeService._();

  ThemeService._();

  // @override
  // Future<void> init(base.ThemeModel initialThemeModel) async {
  //   ThemeTable themeTable = LocalDatabaseService.i.getTable<ThemeTable>();
  //   if (themeTable.entries.isEmpty)
  //     await ThemeEntry.fromDataObject(
  //       ThemeDataObject(
  //         content: ThemeDataObjectContent(theme: initialThemeModel.name),
  //       ),
  //     ).insert();
  //
  //   ThemeEntry themeEntry = themeTable.entries.first;
  //   String themeName = themeEntry.dataObject.content.theme;
  //   base.ThemeModel _themeModel = base.Themes.all.firstWhere((themeModel) => themeModel.name == themeName, orElse: () => null);
  //   super.init(initialThemeModel);
  // }
  //
  // @override
  // Future<void> setTheme(base.ThemeModel themeModel) async {
  //   await LocalDatabaseService.i.getTable<ThemeTable>().entries.first.setTheme(themeModel.name);
  //   super.setTheme(themeModel);
  // }
}
