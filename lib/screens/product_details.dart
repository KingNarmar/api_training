import 'package:api_training/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.itme,
  });
  final ProductModel itme;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itme.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              itme.images![0],
            ),
            ListTile(
              title: Text(itme.title!),
            ),
            ListTile(
              title: Text(itme.category!.name!),
            ),
            ListTile(
              title: Text(itme.price!.toString()),
            ),
            ListTile(
              title: Text(itme.description!),
            ),
          ],
        ),
      ),
    );
  }
}
