import "package:bookbazaar/apis/category_api.dart";
import "package:bookbazaar/components/shimmer_effect.dart";
import "package:flutter/material.dart";

import "../../components/custom_appbar.dart";
import "../../components/user_input_feild.dart";

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController _searchController = TextEditingController();
  UserInputFeild feild = UserInputFeild();
  List categoryList = [];
  bool isCategoryLoaded = false;

 Future<void> fetchCategory() async {
  List<dynamic> newListCategory = await CategoryAPI.getAllCategory();
  if (mounted) { // Check if the widget is still mounted
    if (newListCategory.isNotEmpty) {
      setState(() {
        categoryList.addAll(newListCategory);
        isCategoryLoaded = true;
      });
    }
  }
}


  List<Widget> screen() {
    if (isCategoryLoaded) {
      return UserInputFeild.categoryContainer(
         context, "assets/background.jpg", categoryList);
    } else {
      return ShimmerEffect.categoryShimmer(context);
    }
  }

  @override
  void initState() {
    fetchCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              feild.searchContainerText(context, _searchController,
                  "Seach books", Icon(Icons.search)),
                 Column(
                  children: screen()
                 ) 
            ],
          ),
        ),
      ),
    );
  }
}
