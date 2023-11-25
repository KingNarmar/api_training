import 'package:flutter/material.dart';

abstract class CustomBottomSheet {
  static Future<dynamic> customShowModalBottomSheet(
      BuildContext context, double start, double end) {
    return showModalBottomSheet(
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
                        labels: const RangeLabels("Min Price", "Max Price"),
                        onChanged: (value) {
                          setState(() {
                            start = value.start;
                            end = value.end;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${start.toInt()} \$"),
                            Text("${end.toInt()} \$"),
                          ],
                        ),
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
  }
}
