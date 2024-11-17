import 'dart:math';

import 'package:flutter/material.dart';

class MakeTable extends StatelessWidget {
  const MakeTable(
      {super.key,
      required this.bookNm,
      required this.shopNm,
      required this.bookStockNm});

  final int bookNm;
  final int shopNm;
  final int bookStockNm;

  @override
  Widget build(BuildContext context) {


    Random random = Random();

    List<String> shopNames;
    List<Map<String, dynamic>> randomInput = [];

    shopNames =
        List.generate(shopNm, (index) => String.fromCharCode(65 + index));

    for (int i = 0; i < bookNm; i++) {
      randomInput.add({
        'name': i + 1,
        'price': Random().nextInt(10),
        'shops': getRandomCombination(shopNames, bookStockNm, random),
      });
    }

    print(randomInput);

    List<TableRow> table = [];

    table.add(TableRow(children: [
      const TableCell(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
      )),
      const TableCell(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
      )),
      ...shopNames.map((shopName) => TableCell(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(shopName,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ))),
    ]));

    for (int i = 0; i < randomInput.length; i++) {
      table.add(TableRow(children: [
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(randomInput[i]['name'].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )),
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(randomInput[i]['price'].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )),
        ...shopNames.map((shop) => TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(randomInput[i]['shops'].contains(shop) ? 'O' : '',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ))),
      ]));
    }

    return Table(border: TableBorder.all(), children: table);
  }
}

List<String> getRandomCombination(List<String> items, int k, Random random) {
  List<String> copy = List.from(items);
  copy.shuffle(random);
  List<String> result = copy.take(k).toList();
  result.sort();
  return result;
}
