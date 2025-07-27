// lib/services/cart_service.dart

import 'dart:convert';
import 'package:resturant/models/cart_item_model.dart';
import 'package:resturant/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const _cartKey = 'cartItems';

  Future<List<CartItem>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString(_cartKey);
    if (cartString == null) {
      return [];
    }
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

  Future<void> addToCart(Product product) async {
    final cartItems = await getCartItems();
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex != -1) {
      cartItems[existingIndex].quantity++;
    } else {
      cartItems.add(CartItem(product: product));
    }
    await _saveCart(cartItems);
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (newQuantity <= 0) {
      // If quantity is zero or less, remove it
      final cartItems = await getCartItems();
      cartItems.removeWhere((item) => item.product.id == productId);
      await _saveCart(cartItems);
      return;
    }
    final cartItems = await getCartItems();
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == productId,
    );
    if (existingIndex != -1) {
      cartItems[existingIndex].quantity = newQuantity;
      await _saveCart(cartItems);
    }
  }

  // Clear the entire cart from storage
  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    // Simply remove the entry associated with our cart key
    await prefs.remove(_cartKey);
  }
}
