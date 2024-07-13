class Property {
  final String name;
  final String description;
  final String url;

  Property(
      this.name,
      this.description,
      this.url,
      );

  @override
  bool operator ==(Object other) =>  identical(this, other) ||  other is Property && runtimeType == other.runtimeType && url == other.url;

  @override
  int get hashCode => url.hashCode;
}