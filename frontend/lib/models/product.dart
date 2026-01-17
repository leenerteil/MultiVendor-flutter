import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String price;
  final String category;
  final String shop;
  final double rating;
  final Color color;
  final IconData icon;
  bool isFavorite;
  int cartQuantity;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.shop,
    required this.rating,
    required this.color,
    required this.icon,
    this.isFavorite = false,
    this.cartQuantity = 0,
    this.imageUrl,
  });
}
