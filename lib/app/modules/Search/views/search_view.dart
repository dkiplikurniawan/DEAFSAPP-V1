import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);
  @override
    Widget build(BuildContext context) {
  return const Scaffold(
    body: Center(child: Text('Search - coming soon')),
  );
}
}
