final String tableDetails = 'api_details';

class DetailsFields {
  static final List<String> values = [
    id,
    name,
    description,
    auth,
    isHttps,
    cors,
    link,
    category
  ];

  static final String id = '_id';
  static final String name = 'API';
  static final String description = 'Description';
  static final String auth = 'Auth';
  static final String isHttps = 'HTTPS';
  static final String cors = 'Cors';
  static final String link = 'Link';
  static final String category = 'Category';
}

class APIDetails {
  int? id;
  String name;
  String description;
  String auth;
  bool isHttps;
  String cors;
  String link;
  String category;

  APIDetails({
    this.id,
    required this.name,
    required this.description,
    required this.auth,
    required this.isHttps,
    required this.cors,
    required this.link,
    required this.category,
  });

  APIDetails copy({
    int? id,
    String? name,
    String? description,
    String? auth,
    bool? isHttps,
    String? cors,
    String? link,
    String? category,
  }) =>
      APIDetails(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        auth: auth ?? this.auth,
        isHttps: isHttps ?? this.isHttps,
        cors: cors ?? this.cors,
        link: link ?? this.link,
        category: category ?? this.category,
      );

  Map<String, dynamic> toJson() => {
        DetailsFields.id: id,
        DetailsFields.name: name,
        DetailsFields.description: description,
        DetailsFields.auth: auth,
        DetailsFields.isHttps: isHttps ? 1 : 0,
        DetailsFields.cors: cors,
        DetailsFields.link: link,
        DetailsFields.category: category,
      };

  factory APIDetails.fromJson(Map<String, dynamic> json) {
    return APIDetails(
      id: json['_id'] as int?,
      name: json['API'].toString(),
      description: json['Description'].toString(),
      auth: json['Auth'].toString(),
      isHttps: json['HTTPS'] as bool,
      cors: json['Cors'].toString(),
      link: json['Link'].toString(),
      category: json['Category'].toString(),
    );
  }

  factory APIDetails.fromDB(Map<String, dynamic> json) {
    return APIDetails(
      id: json['_id'] as int?,
      name: json['API'].toString(),
      description: json['Description'].toString(),
      auth: json['Auth'].toString(),
      isHttps: (json['HTTPS'] as int) == 1,
      cors: json['Cors'].toString(),
      link: json['Link'].toString(),
      category: json['Category'].toString(),
    );
  }
}
