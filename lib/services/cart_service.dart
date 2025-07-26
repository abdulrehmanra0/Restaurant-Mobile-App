// lib/services/cart_service.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resturant/models/cart_item_model.dart';
import 'package:resturant/models/product_model.dart';

class CartService {
  static const _cartKey = 'cartItems';

  Future<List<CartItem>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString(_cartKey);
    if (cartString == null) return [];

    final List<dynamic> cartJson = jsonDecode(cartString);
    return cartJson.map((json) => CartItem.fromJson(json)).toList();
  }

  Future<void> _saveCart(List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final String cartString = jsonEncode(
      cartItems.map((item) => item.toJson()).toList(),
    );
    await prefs.setString(_cartKey, cartString);
  }

  Future<void> addToCart(Product product, {int quantity = 1}) async {
    final cartItems = await getCartItems();
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex != -1) {
      cartItems[existingIndex].quantity += quantity;
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));
    }
    await _saveCart(cartItems);
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    final cartItems = await getCartItems();
    final itemIndex = cartItems.indexWhere(
      (item) => item.product.id == productId,
    );

    if (newQuantity <= 0) {
      cartItems.removeAt(itemIndex);
    } else {
      if (itemIndex != -1) {
        cartItems[itemIndex].quantity = newQuantity;
      }
    }
    await _saveCart(cartItems);
  }
}
