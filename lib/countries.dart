class Country {
  int id;
  String name;

  Country(this.id, this.name);

  static List<Country> getCountries() {
    return <Country>[Country(1, '1. HNL'), Country(2, '2. HNL')];
  }
}
