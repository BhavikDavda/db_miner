
import 'package:animated_react_button/animated_react_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/home_controller.dart';
import '../../models/qoutemodel.dart';






class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final QuoteController quoteController = Get.put(QuoteController());
  @override
  Widget build(BuildContext context) {
    final QuoteModel args = Get.arguments as QuoteModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Details',style: GoogleFonts.raleway(), ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AnimatedReactButton(
                defaultColor: Colors.grey,
                reactColor: Colors.red,
                onPressed: (){
                  quoteController.addToWishlist(args);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Added to wishlist!",)),
                  );
                }),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  args.quote ?? "",style: GoogleFonts.raleway(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "- ${args.author}",style: GoogleFonts.raleway(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}