class Language{
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
        Language(1, "FR", "Français", "fr"),
        Language(2, "US", "English", "fr")
    ];
  }
}