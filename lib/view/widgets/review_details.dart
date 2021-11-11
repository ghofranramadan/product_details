import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:task_10/data/product_details_respons.dart';

class ReviewDetails extends StatelessWidget {
  Reviews reviews;

  ReviewDetails({required this.reviews});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(reviews.userName),
            RatingBar.builder(
              unratedColor: Colors.grey,
              initialRating: reviews.rate.toDouble(),
              minRating: 0.1,
              itemSize: 15,
              direction: Axis.horizontal,
              allowHalfRating: true,
              ignoreGestures: true,
              itemCount: 5,
              itemPadding: EdgeInsets.zero,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.yellowAccent,
              ),
              onRatingUpdate: (count) {},
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          reviews.review,
          style: TextStyle(height: 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(reviews.createdAt),
          ],
        )
      ],
    );
  }
}
