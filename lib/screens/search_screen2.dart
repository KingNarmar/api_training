import 'package:api_training/componants/custom_grid_view_item.dart';
import 'package:api_training/models/product_model.dart';
import 'package:api_training/repos/dio_helper.dart';
import 'package:api_training/repos/end_points.dart';
import 'package:flutter/material.dart';

class SearchScreen2 extends StatefulWidget {
  const SearchScreen2({super.key});

  @override
  State<SearchScreen2> createState() => _SearchScreen2State();
}

class _SearchScreen2State extends State<SearchScreen2> {
  final search2Controller = TextEditingController();

  List<ProductModel> products2 = [];
  bool isLoading = false;
  double start = 1;
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

  void _searchByPriceRange() {
    products2 = [];
    setState(() {
      isLoading = true;
    });
    DioHelper.dio.get("$getProductsByPriceApiUrl${search2Controller.text}",
        queryParameters: {
          "price_min": start,
          "price_max": end
        }).then((response) {
      for (var element in response.data) {
        products2.add(ProductModel.fromJson(element));
      }
      setState(() {
        isLoading = false;
      });
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
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return BottomSheet(
                          onClosing: () {},
                          builder: (context) {
                            return SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              child: Column(
                                children: [
                                  RangeSlider(
                                    divisions: 1000,
                                    values: RangeValues(start, end),
                                    min: 0,
                                    max: 1000,
                                    labels: const RangeLabels(
                                        "Min Price", "Max Price"),
                                    onChanged: (value) {
                                      setState(() {
                                        start = value.start;
                                        end = value.end;
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${start.toInt()} \$"),
                                        Text("${end.toInt()} \$"),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _searchByPriceRange();
                                    },
                                    child: const Text("Filter by Price"),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
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
