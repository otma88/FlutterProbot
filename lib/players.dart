class Player {
  final int id;
  final int clubID;
  final String playerName;
  final String firstName;
  final String lastName;
  final String nationality;
  final int number;
  final String position;
  final int age;
  final String height;
  final String weight;

  Player(
      {this.id,
      this.clubID,
      this.playerName,
      this.firstName,
      this.lastName,
      this.nationality,
      this.number,
      this.position,
      this.age,
      this.height,
      this.weight});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        id: json['id'] as int,
        clubID: json['club_id'] as int,
        playerName: json['player_name'] as String,
        firstName: json['firstname'] as String,
        lastName: json['lastname'] as String,
        nationality: json['nationality'] as String,
        number: json['number'] as int,
        position: json['position'] as String,
        age: json['age'] as int,
        height: json['height'] as String,
        weight: json['weight'] as String);
  }
}
