class Club {
  final int id;
  final int league_id;
  final String name;
  final String logo;
  final String venueName;
  final String venueCity;
  final String venueCapacity;
  final String shirtColor;
  final String numberColor;
  final String collarColor;
  final String nameColor;
  final String numBorderColor;

  Club(
      {this.id,
      this.league_id,
      this.name,
      this.logo,
      this.venueName,
      this.venueCity,
      this.venueCapacity,
      this.shirtColor,
      this.numberColor,
      this.collarColor,
      this.nameColor,
      this.numBorderColor});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'] as int,
      league_id: json['league_id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
      venueName: json['venue_name'] as String,
      venueCity: json['venue_city'] as String,
      venueCapacity: json['venue_capacity'] as String,
      shirtColor: json['shirt_color'] as String,
      numberColor: json['number_color'] as String,
      collarColor: json['collar_color'] as String,
      nameColor: json['name_color'] as String,
      numBorderColor: json['num_border_color'] as String,
    );
  }
}
