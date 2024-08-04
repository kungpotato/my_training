class PokemonModel {
  final String name;
  final String url;

  PokemonModel({required this.name, required this.url});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  String get imgUrl {
    final segments = url.split('/');
    segments.removeWhere((s) => s.isEmpty);
    final String id = segments[segments.length - 1];
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }
}
