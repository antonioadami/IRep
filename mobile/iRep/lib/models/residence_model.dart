class ResidenceModel {
  String? name;
  String? address;
  String? description;
  List<String?>? contacts;
  String? image;
  bool? isFavorite = false;
  ResidenceModel({
    this.name,
    this.address,
    this.description,
    this.contacts,
    this.image,
    this.isFavorite = false,
  });

  ResidenceModel.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    address = json['address']?.toString();
    description = json['description']?.toString();
    if (json['contacts'] != null) {
      final v = json['contacts'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      contacts = arr0;
    }
    image = json['image']?.toString();
    isFavorite = json['isFavorite'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['description'] = description;
    if (contacts != null) {
      final v = contacts;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['contacts'] = arr0;
    }
    data['image'] = image;
    return data;
  }
}
