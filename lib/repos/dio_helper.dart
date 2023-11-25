import 'package:api_training/models/category_model.dart';
import 'package:api_training/models/product_model.dart';
import 'package:api_training/repos/controllers.dart';
import 'package:api_training/repos/register_controllers.dart';
import 'package:api_training/repos/shared_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import 'end_points.dart';
import 'login_controllers.dart';
import 'navigator_helper.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio();
  }

  static login(BuildContext context) async {
    DioHelper.dio.post(loginApiUrl, data: {
      "email": LoginControllers.emailController.text,
      "password": LoginControllers.passwordController.text

      // "email": "john@mail.com",
      // "password": "changeme"
    }).then(
      (response) async {
        if (response.statusCode == 201) {
          await SharedHelper.prefs.setBool("isLogin", true);
          await SharedHelper.prefs
              .setString(
            "access_token",
            response.data["access_token"].toString(),
          )
              .then((value) {
            NavigatorHelper.showMessage(context, "Login successfully");
            LoginControllers.emailController.text = "";
            LoginControllers.passwordController.text = "";
            NavigatorHelper.goToAndOff(
              context,
              const HomeScreen(),
            );
          });
        } else {
          NavigatorHelper.showMessage(context, "Login failed");
        }
      },
    ).catchError((error) {
      NavigatorHelper.showMessage(context, "Login failed");
    });
  }

  static createAccount(BuildContext context) {
    DioHelper.dio.post(createAccountApiUrl, data: {
      "name": RegisterControllers.nameController.text,
      "email": RegisterControllers.emailController.text,
      "password": RegisterControllers.passwordController.text,
      "avatar": "https://picsum.photos/800",
    }).then((response) {
      if (response.statusCode == 201) {
        NavigatorHelper.showMessage(context, "Account Created Successfully");
        RegisterControllers.emailController.text = "";
        RegisterControllers.nameController.text = "";
        RegisterControllers.passwordController.text = "";
        NavigatorHelper.goBack(context);
      } else {
        NavigatorHelper.showMessage(context, "Falied try again");
      }
    }).catchError((error) {
      NavigatorHelper.showMessage(context, "Falied try again");
    });
  }

  static Future<Response> getProducts() {
    return DioHelper.dio.get(getProductsApiUrl);
  }

  static List<ProductModel> products = [];

  static Future<Response> getCategory() {
    return DioHelper.dio.get(getCategoriesApiUrl);
  }

  static List<CategoryModel> categories = [];

  static Future<Response> getSingleCategory(int id) {
    return DioHelper.dio.get("$getProductsByCategory${id.toString()}");
  }

  static Future<Response> search(String text) {
    return DioHelper.dio.get("$getProductsByTitleApiUrl$text");
  }

  static createProduct(int id, BuildContext context) {
    DioHelper.dio.post(createProductApiUrl, data: {
      "title": CreateProductControllers.titleController.text,
      "price": CreateProductControllers.priceController.text,
      "description": CreateProductControllers.discreptionController.text,
      "categoryId": id,
      "images": [
        "https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=600"
      ]
    }).then((responce) {
      if (responce.statusCode == 201) {
        NavigatorHelper.showMessage(context, "Product Create Successfully");
      } else {
        NavigatorHelper.showMessage(context, "Falied try again");
      }
    }).catchError((error) {
      NavigatorHelper.showMessage(context, "Falied try again");
    });
  }

  static Future<Response> getProductsByPrice(int min, int max) {
    return DioHelper.dio.get(
        "$getProductsByPriceApiUrl?price_min=${min.toString()}&price_max=${max.toString()}");
  }
}
