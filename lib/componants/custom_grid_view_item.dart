import 'package:api_training/models/product_model.dart';
import 'package:api_training/repos/navigator_helper.dart';
import 'package:api_training/screens/product_details.dart';
import 'package:flutter/material.dart';

class CustomGridViewItem extends StatelessWidget {
  const CustomGridViewItem({
    super.key,
    this.image = "https://i.imgur.com/ZANVnHE.jpeg",
    this.name = "Name",
    this.price = "Price",
    required this.itme,
  });
  final String image;
  final String name;
  final String price;
  final ProductModel itme;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorHelper.goTo(context, ProductDetails(itme: itme));
      },
      child: Card(
        child: Stack(
          children: [
            FadeInImage(
              placeholder: const AssetImage("assets/plaseholder.png"),
              image: NetworkImage(
                image,
              ),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/plaseholder.png");
              },
            ),
            Container(
              color: Colors.black54,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(name),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                 " $price \$",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
