class Club {
  int id;
  String name;

  Club(this.id, this.name);

  static List<Club> getClubs() {
    return <Club>[
      Club(1, 'Dinamo'),
      Club(2, 'Hajduk'),
      Club(3, 'Osijek'),
      Club(4, 'Rijeka'),
    ];
  }
}
