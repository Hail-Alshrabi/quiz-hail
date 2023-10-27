
import 'ResponseModel.dart';

class HallModel extends ResponseModel {
  HallModel({bool? success, String? message,this.result}) : super(success: success,message: message);

  late final Result? result;
// bankAccountList = (jsonDecode(_jsonDecrypt ?? '') as List).map((e) => BankAccountsModel.fromJson(e)).toList();
  HallModel.fromJson(Map<String, dynamic>? json): super.fromJson(json){
    result = Result == null ?  null : Result.fromJson(json?['result']);
  }

}

class Result {
  Result({
    this.hallId,
    this.hallName,
    this.price,
    this.addressDetails,
    this.address,
    this.longitude,
    this.latitude,
    this.image_displaying,
    this.image1,
    this.image2,
    this.image3,
    this.phoneNumbers,
    this.info_hall,
    this.city,
    this.hallRatingStar,
    this.timeStamp,
    this.distance,
    this.id,
    this.date_booking,
  });

  late final int? hallId;
  late final int? id;
  late final String? hallName;
  late final String? price;
  late final String? address;
  late final String? addressDetails;
  late final String? latitude;
  late final String? longitude;
  late final String? image_displaying;
  late final String? image1;
  late final String? image2;
  late final String? image3;
  late final String? phoneNumbers;
  late final String? info_hall;
  late final String? city;
  late final String? date_booking;
  late final double? hallRatingStar;
  double? distance;
  late final String? timeStamp;

  Result.fromJson(Map<String, dynamic>? json) {
    hallId = int.parse(json?['hallId'] ?? '0');
    id = int.parse(json?['id'] ?? '0');
    hallName = json?['hallName'] ?? '';
    date_booking = json?['date_booking'] ?? '';
    price = json?['price'] ?? '';
    address = json?['address'] ?? '';
    addressDetails = json?['addressDetails'] ?? '';
    latitude = json?['latitude'] ?? '';
    longitude = json?['longitude'] ?? '';
    image_displaying = json?['image_displaying'] ?? '';
    image1 = json?['image1'] ?? '';
    image2 = json?['image2'] ?? '';
    image3 = json?['image3'] ?? '';
    phoneNumbers = json?['phoneNumbers'] ?? '';
    info_hall = json?['info_hall'] ?? '';
    city = json?['city'] ?? '';
    hallRatingStar = double.parse(double.parse(json?['hallRatingStar'] ?? '1.0').toStringAsFixed(1));
    timeStamp = json?['timeStamp'] ?? '';
  }

}
