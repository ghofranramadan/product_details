import 'package:flutter/material.dart';
import 'package:task_10/data/product_details_respons.dart';
import 'package:task_10/repos/product_details_repo.dart';

class ProductDetailsProvider extends ChangeNotifier {
  Future<ProductDetailsResponse> getProductDetails() async {
    return await ProductDetailsRepository.getProductDetails();
  }
}
