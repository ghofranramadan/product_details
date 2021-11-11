class ProductDetailsResponse {
  late int id;
  late String name;
  late String desc;
  late int regularPrice;
  late int salePrice;
  late bool onSale;
  late int stock;
  late bool isFavourite;
  late int rate;
  late int numUsersRate;
  late List<ProductImages> productImages = <ProductImages>[];
  late List<Reviews> reviews = <Reviews>[];
  late List<ProductDetails> productDetails = <ProductDetails>[];
  late Store store;

  ProductDetailsResponse({
    required this.id,
    required this.name,
    required this.desc,
    required this.regularPrice,
    required this.salePrice,
    required this.onSale,
    required this.isFavourite,
    required this.rate,
    required this.numUsersRate,
    required this.stock,
    required this.store,
    required this.productDetails,
    required this.productImages,
    required this.reviews,
  });

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    onSale = json['on_sale'];
    stock = json['stock'];
    isFavourite = json['is_favourite'];
    rate = json['rate'];
    numUsersRate = json['num_users_rate'];
    if (json['images'] != null) {
      json['images'].forEach((e) {
        productImages.add(ProductImages.fromJson(e));
      });
    }
    if (json['reviews'] != null) {
      json['reviews'].forEach((e) {
        reviews.add(Reviews.fromJson(e));
      });
    }
    if (json['product_details'] != null) {
      json['product_details'].forEach((e) {
        productDetails.add(ProductDetails.fromJson(e));
      });
    }
    store = Store.fromJson(json['store']);
  }
}

class ProductImages {
  late int id;
  late String image;
  ProductImages({required this.id, required this.image});
  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['img'];
  }
}

class Reviews {
  late String userName;
  late String review;
  late int rate;
  late String createdAt;
  Reviews(
      {required this.userName,
      required this.review,
      required this.rate,
      required this.createdAt});
  Reviews.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    review = json['review'];
    rate = json['rate'];
    createdAt = json['created_at'];
  }
}

class ProductDetails {
  late int id;
  late String value;
  late String nameAr;
  late String nameEn;

  ProductDetails(
      {required this.id,
      required this.value,
      required this.nameAr,
      required this.nameEn});
  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}

class Store {
  late int id;
  late String name;
  late String logo;
  late String fullAddress;
  Store({
    required this.id,
    required this.name,
    required this.logo,
    required this.fullAddress,
  });
  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    fullAddress = json['full_address'];
  }
}
