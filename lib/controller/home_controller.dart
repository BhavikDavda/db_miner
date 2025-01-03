
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';




import '../models/qoutemodel.dart';
import '../utils/db_helper.dart';

class QuoteController extends GetxController {
  var quotes = <QuoteModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var wishlist = <QuoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuotes();
    loadWishlist();
  }

  void addToWishlist(QuoteModel quote) async {
    wishlist.add(quote);
    await DbHelper.dbHelper.addToWishlistDb(quote);
    saveWishlist();
  }

  Future<void> loadWishlist() async {
    final dbWishlist = await DbHelper.dbHelper.getWishlistFromDb();
    wishlist(dbWishlist);
  }

  void removeFromWishlist(int index) async {
    final quote = wishlist[index];
    wishlist.removeAt(index);
    await DbHelper.dbHelper.removeFromWishlistDb(quote.id!);
    saveWishlist();
  }

  Future<void> saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistJson = wishlist.map((quote) => quote.toJson()).toList();
    await prefs.setString('wishlist', jsonEncode(wishlistJson));
  }

  Future<void> fetchQuotes() async {
    final url = Uri.parse('https://dummyjson.com/quotes');
    try {
      isLoading(true);
      final response = await get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['quotes'] as List;
        quotes(data.map((json) => QuoteModel.fromJson(json)).toList());
      } else {
        errorMessage('Failed to load quotes: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage('Error fetching quotes: $e');
    } finally {
      isLoading(false);
    }
  }
}
