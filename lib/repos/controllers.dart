import 'package:flutter/material.dart';

abstract class SearchControllers {
  static final searchController = TextEditingController();
}

abstract class CreateProductControllers {
  static final titleController = TextEditingController();
  static final priceController = TextEditingController();
  static final discreptionController = TextEditingController();
}
