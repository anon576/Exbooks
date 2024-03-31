import 'package:bookbazaar/apis/product_api.dart';
import 'package:bookbazaar/components/custom_appbar.dart';
import 'package:bookbazaar/components/screen_builder.dart';
import 'package:bookbazaar/components/shimmer_effect.dart';
import 'package:bookbazaar/components/user_input_feild.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = TextEditingController();
  UserInputFeild feild = UserInputFeild();
  bool carsoulLoaded = false;
  bool productLoaded = false;
  List<dynamic> carsoulProduct = [];
  List<dynamic> listProduct = [];
  int lastbookid = 0;
  ScrollController _scrollController = ScrollController();

  Future<void> fetchCarsoul() async {
    carsoulProduct = await ProductAPI.fetchCarsoul();
    if (mounted) {
      setState(() {
        carsoulLoaded = true;
      });
    }
  }

  Future<void> fetchProducts() async {
    Map<String,dynamic>  newProduct =
        await ProductAPI.fetchProducts(range: lastbookid);
        List<dynamic> newListProduct = newProduct['books'];
        lastbookid = newProduct['lastbookid'];
    if (mounted) {
      if (newListProduct.isNotEmpty) {
        setState(() {
          listProduct.addAll(newListProduct);
          lastbookid++;
          productLoaded = true;
        });
      }
    }
  }

  Widget screen() {
    if (carsoulLoaded & productLoaded) {
      return Products.buildHomeScreen(context, carsoulProduct, listProduct);
    } else {
      return ShimmerEffect.ShimmerHomeScreen(context);
    }
  }

  @override
  void initState() {
    fetchCarsoul();
    fetchProducts();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reached the end of the list, load more products
      fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            feild.searchContainerText(
                context, _searchController, "Seach books", Icon(Icons.search)),
            screen(),
          ],
        ),
      ),
    );
  }
}
