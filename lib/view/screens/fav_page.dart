import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';


class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final QuoteController quoteController = Get.find<QuoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Wishlist',

          )),
      body: Obx(() {
        if (quoteController.wishlist.isEmpty) {
          return Center(
              child: Text(
                "Your wishlist is empty.",

              ));
        }
        return ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: quoteController.wishlist.length,
          itemBuilder: (context, index) {
            var quote = quoteController.wishlist[index];
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quote.quote ?? "No content available",

                        ),
                        SizedBox(height: 8),
                        Text(
                          "- ${quote.author ?? 'Unknown'}",

                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        quoteController.removeFromWishlist(index);
                        //quoteController.wishlist.removeAt(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                "Quote removed from wishlist",

                              )),
                        );
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
            );
          },
        );
      }),
    );
  }
}