import 'package:api_training/componants/custom_grid_view_item.dart';
import 'package:api_training/componants/custome_bottom_sheet.dart';
import 'package:api_training/models/product_model.dart';
import 'package:api_training/repos/dio_helper.dart';
import 'package:flutter/material.dart';

class SearchScreen2 extends StatefulWidget {
  const SearchScreen2({super.key});

  @override
  State<SearchScreen2> createState() => _SearchScreen2State();
}

class _SearchScreen2State extends State<SearchScreen2> {
  final search2Controller = TextEditingController();

  final List<ProductModel> products2 = [];
  double start = 0;
  double end = 1000;
  _search() {
    String searchText = search2Controller.text.toLowerCase();

    setState(() {
      products2.clear();
      products2.addAll(
        DioHelper.products.where(
            (element) => element.title!.toLowerCase().contains(searchText)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search 2"),
        actions: [
          IconButton(
              onPressed: () {
                CustomBottomSheet.customShowModalBottomSheet(
                    context, start, end);
              },
              icon: const Icon(Icons.filter_list))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBar(
              onChanged: (value) {
                setState(() {
                  _search();
                });
              },
              trailing: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _search();
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
              controller: search2Controller,
            ),
            products2.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products2.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return CustomGridViewItem(
                        itme: products2[index],
                        image: products2[index].images![0],
                        name: products2[index].title!,
                        price: products2[index].price.toString(),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
