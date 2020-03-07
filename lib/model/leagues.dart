class League {
  final int id;
  final int country_id;
  final String name;
  final String country_code;
  final int season;
  final String logo;
  final String flag;
  final String created_at;
  final String updated_at;

  League(
      {this.id,
      this.country_id,
      this.name,
      this.country_code,
      this.season,
      this.logo,
      this.flag,
      this.created_at,
      this.updated_at});

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
        id: json['id'] as int,
        country_id: json['country_id'] as int,
        name: json['name'] as String,
        country_code: json['country_code'] as String,
        season: json['season'] as int,
        logo: json['logo'] as String,
        flag: json['flag'] as String,
        created_at: json['created_at'] as String,
        updated_at: json['updated_at'] as String);
  }
}
