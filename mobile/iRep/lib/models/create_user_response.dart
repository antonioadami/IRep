class CreatePersonResponseCodeDeliveryDetails {
  final String? destination;
  final String? deliveryMedium;
  final String? attributeName;

  CreatePersonResponseCodeDeliveryDetails({
    this.destination,
    this.deliveryMedium,
    this.attributeName,
  });

  factory CreatePersonResponseCodeDeliveryDetails.fromJson(
      Map<String, dynamic> json) {
    return CreatePersonResponseCodeDeliveryDetails(
      destination: json['Destination'],
      deliveryMedium: json['DeliveryMedium'],
      attributeName: json['AttributeName'],
    );
  }
}

class CreatePersonResponse {
  final CreatePersonResponseCodeDeliveryDetails? codeDeliveryDetails;
  final String? username;

  CreatePersonResponse({
    this.codeDeliveryDetails,
    this.username,
  });
  factory CreatePersonResponse.fromJson(Map<String, dynamic> json) {
    return CreatePersonResponse(
      codeDeliveryDetails: CreatePersonResponseCodeDeliveryDetails.fromJson(
          json['codeDeliveryDetails'] ?? json['CodeDeliveryDetails']),
      username: json['username'],
    );
  }
}
