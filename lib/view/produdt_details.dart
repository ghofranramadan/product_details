import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:task_10/data/product_details_respons.dart';
import 'package:task_10/generated/l10n.dart';
import 'package:task_10/providers/product_details_provider.dart';
import 'package:task_10/utils/var.dart';
import 'package:task_10/view/widgets/clip_triangle.dart';
import 'package:task_10/view/widgets/review_details.dart';

class ProductDetails extends StatefulWidget {
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  CarouselController buttonCarouselController = CarouselController();

  int indicatorIndex = 0;

  int amount = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    var productDetailsViewModel = Provider.of<ProductDetailsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<ProductDetailsResponse>(
        future: productDetailsViewModel.getProductDetails(),
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: Center(
                  child: Text('No internet connection'),
                ),
              );

            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error:${snapshot.error.toString()}"),
                );
              }

              if (snapshot.data != null) {
                return Directionality(
                  textDirection: GetLAng.lang == 'en_US'
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.52,
                            color: Colors.transparent,
                            child: Stack(
                              children: [
                                Stack(
                                  children: [
                                    CarouselSlider.builder(
                                      carouselController:
                                          buttonCarouselController,
                                      options: CarouselOptions(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35,
                                          enableInfiniteScroll: false,
                                          disableCenter: true,
                                          viewportFraction: 1,
                                          aspectRatio: 1,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              indicatorIndex = index;
                                            });
                                          }),
                                      itemCount: 3,
                                      // snapshot.data!.productImages.length,
                                      itemBuilder: (BuildContext context,
                                          int index, int i) {
                                        return CachedNetworkImage(
                                          imageUrl:
                                              'https://image.freepik.com/free-psd/3d-space-rocket-with-smoke_23-2148938939.jpg',
                                          // imageUrl: snapshot
                                          //     .data!.productImages[index].image,
                                          fit: BoxFit.fill,
                                          placeholder: (_, __) => const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (_, __, ___) => Center(
                                            child: Icon(
                                              Icons.error,
                                              color:
                                                  Theme.of(context).errorColor,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(right: 7),
                                            alignment: Alignment.centerRight,
                                            width: 55,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: GetLAng.lang ==
                                                      'en_US'
                                                  ? BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(20),
                                                      bottomRight:
                                                          Radius.circular(20))
                                                  : BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(20)),
                                            ),
                                            child: Icon(
                                              Icons.arrow_back_rounded,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.share,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: GetLAng.lang == 'en_US'
                                                    ? () {
                                                        GetLAng.lang = 'ar_EG';
                                                        setState(() {
                                                          S.load(Locale(
                                                              'ar', 'Ar'));
                                                        });
                                                      }
                                                    : () {
                                                        GetLAng.lang = 'en_US';
                                                        setState(() {
                                                          S.load(Locale(
                                                              'en', 'US'));
                                                        });
                                                      },
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.favorite_border,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: MediaQuery.of(context).size.height *
                                          0.3,
                                      child: DotsIndicator(
                                        dotsCount: 3,
                                        // snapshot.data!.productImages.length,
                                        mainAxisSize: MainAxisSize.min,
                                        position: indicatorIndex.toDouble(),
                                        decorator: DotsDecorator(
                                          activeColor: Colors.orangeAccent,
                                          color: Colors.grey,
                                          spacing:
                                              const EdgeInsets.only(left: 6),
                                          size: const Size(8, 8),
                                          activeSize: const Size(8, 8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top:
                                      MediaQuery.of(context).size.height * 0.30,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22, vertical: 12),
                                    margin: const EdgeInsets.only(
                                      top: 15,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    // height: 210,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(35),
                                          topLeft: Radius.circular(35),
                                          bottomRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(25)),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(height: 2),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            snapshot.data!.onSale == true
                                                ? Row(
                                                    children: [
                                                      Text(snapshot
                                                              .data!.salePrice
                                                              .toString() +
                                                          'SAR'),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        snapshot.data!
                                                                .regularPrice
                                                                .toString() +
                                                            'SAR',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            decorationThickness:
                                                                1.5,
                                                            decorationColor:
                                                                Colors.grey,
                                                            decorationStyle:
                                                                TextDecorationStyle
                                                                    .solid,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        ((snapshot.data!.regularPrice -
                                                                        snapshot
                                                                            .data!
                                                                            .salePrice) /
                                                                    snapshot
                                                                        .data!
                                                                        .regularPrice *
                                                                    100)
                                                                .toInt()
                                                                .toString() +
                                                            '%',
                                                        style: TextStyle(
                                                          color: Colors
                                                              .orangeAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Text(
                                                    snapshot.data!.regularPrice
                                                            .toString() +
                                                        'SAR',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        decorationThickness:
                                                            1.5,
                                                        decorationColor:
                                                            Colors.grey,
                                                        decorationStyle:
                                                            TextDecorationStyle
                                                                .solid,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                            const Spacer(),
                                            RatingBar.builder(
                                              unratedColor: Colors.grey,
                                              initialRating: snapshot.data!.rate
                                                  .toDouble(),
                                              minRating: 0.1,
                                              itemSize: 15,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              ignoreGestures: true,
                                              itemCount: 4,
                                              itemPadding: EdgeInsets.zero,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              onRatingUpdate: (count) {},
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              '(${snapshot.data!.numUsersRate})',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 30,
                                          thickness: 2,
                                          color: Colors.grey,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.center,
                                              width: 55,
                                              height: 55,
                                              child: ClipOval(
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      snapshot.data!.store.logo,
                                                  fit: BoxFit.fill,
                                                  placeholder: (_, __) =>
                                                      const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                  errorWidget: (_, __, ___) =>
                                                      Center(
                                                    child: Icon(
                                                      Icons.error,
                                                      color: Theme.of(context)
                                                          .errorColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data!.store.name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .add_location_outlined,
                                                        color:
                                                            Colors.orangeAccent,
                                                      ),
                                                      Text(
                                                        snapshot.data!.store
                                                            .fullAddress,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 25),
                              margin: EdgeInsets.only(
                                bottom: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                snapshot.data!.desc,
                                maxLines: 4,
                                style: TextStyle(
                                  height: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            height: 400,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 55,
                                    child: TabBar(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 22),
                                      controller: _tabController,
                                      isScrollable: false,
                                      indicatorColor: Colors.orangeAccent,
                                      unselectedLabelColor: Colors.black,
                                      labelColor: Colors.orangeAccent,
                                      tabs: [
                                        Tab(text: delegate.productDetails),
                                        Tab(text: delegate.productReview),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 30),
                                    height: 325,
                                    child: TabBarView(
                                        controller: _tabController,
                                        children: <Widget>[
                                          ListView.builder(
                                              padding: const EdgeInsets.only(
                                                top: 30,
                                              ),
                                              shrinkWrap: true,
                                              itemCount: snapshot
                                                  .data!.productDetails.length,
                                              itemBuilder: (context, index) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: index.isOdd
                                                          ? Colors.grey[200]
                                                          : Colors.white,
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 22),
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(GetLAng.lang ==
                                                                'en_US'
                                                            ? snapshot
                                                                .data!
                                                                .productDetails[
                                                                    index]
                                                                .nameEn
                                                            : snapshot
                                                                .data!
                                                                .productDetails[
                                                                    index]
                                                                .nameAr),
                                                        Text(snapshot
                                                            .data!
                                                            .productDetails[
                                                                index]
                                                            .value),
                                                      ],
                                                    ),
                                                  )),
                                          ListView.separated(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 30, horizontal: 22),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) =>
                                                  ReviewDetails(
                                                    reviews: snapshot
                                                        .data!.reviews[index],
                                                  ),
                                              separatorBuilder:
                                                  (context, index) => Divider(
                                                        height: 30,
                                                        thickness: 2,
                                                        color: Theme.of(context)
                                                            .shadowColor
                                                            .withOpacity(0.5),
                                                      ),
                                              itemCount: snapshot
                                                  .data!.reviews.length),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Stack(
                            alignment: GetLAng.lang == 'en_US'
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                height: 45,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: amount == 0
                                          ? null
                                          : () {
                                              amount--;
                                              setState(() {});
                                            },
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      '$amount',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        amount++;
                                        setState(() {});
                                      },
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: amount > 0
                                    ? () async {
                                        await showOkAlertDialog(
                                          context: context,
                                          message:
                                              delegate.productSuccessfullyAdded,
                                          okLabel: delegate.ok,
                                        );
                                        setState(() {
                                          amount = 0;
                                        });
                                      }
                                    : null,
                                behavior: HitTestBehavior.opaque,
                                child: Stack(
                                  alignment: GetLAng.lang == 'en_US'
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: GetLAng.lang == 'en_US'
                                            ? BorderRadius.only(
                                                topRight: Radius.circular(25),
                                                bottomRight:
                                                    Radius.circular(25))
                                            : BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                bottomLeft:
                                                    Radius.circular(25)),
                                      ),
                                      height: 50,
                                      width: 170,
                                      child: Text(
                                        delegate.addToCart,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ClipPath(
                                        clipper: TriangleClipper(),
                                        child: Container(
                                          height: 50,
                                          width: 60,
                                          color: Colors.orange,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
