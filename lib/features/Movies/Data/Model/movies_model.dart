import 'dart:convert';

class Movie {
  final String title;
  final String image;

  Movie({
    required this.title,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
