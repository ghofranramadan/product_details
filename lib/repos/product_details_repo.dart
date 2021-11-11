import 'package:task_10/data/product_details_respons.dart';
import 'package:task_10/network/networkCallback/NetworkCallback.dart';
import 'package:task_10/utils/Enums.dart';

class ProductDetailsRepository {
  static Future<ProductDetailsResponse> getProductDetails() async {
    return ProductDetailsResponse.fromJson(await NetworkCall.makeCall(
      endPoint: "v3/1243be15-efd5-4132-9bd0-eeb33f325f51",
      method: HttpMethod.GET,
      // queryParams: {"api_key": Constants.token}
    ));
  }
}
