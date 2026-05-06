class PopulationModel {
  final String country;
  final String population;
  final List<dynamic>? provinces;

  PopulationModel({
    required this.country,
    required this.population,
    this.provinces,
  });

  factory PopulationModel.fromJson(Map<String, dynamic> json) {
    return PopulationModel(
      country: json['country'],
      population: json['population'],
      provinces: json['provinces'],
    );
  }
}
