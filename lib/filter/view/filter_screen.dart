import 'package:flutter/material.dart';
import 'package:samples/filter/view/widget/select_widget.dart';
import 'package:samples/helper/extension.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> keys = [
    "price",
    "category",
    "brands",
  ];

  int selectedIndex = 0;

  List<String> categories = [
    "Smartphones",
    "Feature Phones",
    "Tablets",
    "Phablets",
    "Wearables",
    "E-Readers",
    "Gaming Devices",
    "Rugged Phones",
    "Foldable Phones",
    "Camera Phones",
    "Business Phones",
    "Senior Phones",
  ];
  List<String> brands = [
    'Apple',
    'Samsung',
    'Huawei',
    'Xiaomi',
    'OnePlus',
    'Google',
    'Sony',
    'LG',
    'Motorola',
    'Nokia',
    'Lenovo',
    'ASUS',
    'Vivo',
    'Oppo',
    'Realme',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Filter"),
        backgroundColor: Colors.teal,
        elevation: 1,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * .4,
                    child: ListView.builder(
                        itemCount: keys.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              if (selectedIndex == index) {
                                return;
                              }
                              selectedIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              color: selectedIndex == index
                                  ? Colors.grey[200]
                                  : Colors.white,
                              padding: const EdgeInsets.only(left: 16),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                keys[index].capitalize(),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          );
                        }),
                  ),
                  Expanded(child: Container(
                    //height: size.height * .4,

                    child: () {
                      switch (selectedIndex) {
                        case 0:
                          return const Text("Price");
                        case 1:
                          return getListWidget(categories, selectedIndex);
                        case 2:
                          return getListWidget(brands, selectedIndex);
                      }
                    }(),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getListWidget(List<String> lists, int selectedIndex) {
    return ListView.builder(
        itemCount: lists.length,
        itemBuilder: (_, index) {
          return AnimatedCheckBoxTile(
            itemName: lists[index],
          );
        });
  }
}
