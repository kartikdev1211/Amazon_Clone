import 'package:clone_amazon/resources/cloudfirestore_methods.dart';
import 'package:clone_amazon/utils/constants.dart';
import 'package:clone_amazon/widget/banner_ad_widget.dart';
import 'package:clone_amazon/widget/categories_horizontal_list_view_bar.dart';
import 'package:clone_amazon/widget/loading_widget.dart';
import 'package:clone_amazon/widget/product_showcase_list_view.dart';
import 'package:clone_amazon/widget/search_bar_widget.dart';
import 'package:clone_amazon/widget/user_details_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {
    List<Widget> temp70 =
        await CloudFirestoreClass().getProductsFromDiscount(70);
    List<Widget> temp60 =
        await CloudFirestoreClass().getProductsFromDiscount(60);
    List<Widget> temp50 =
        await CloudFirestoreClass().getProductsFromDiscount(50);
    List<Widget> temp0 = await CloudFirestoreClass().getProductsFromDiscount(0);
    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: discount70 != null &&
              discount60 != null &&
              discount50 != null &&
              discount0 != null
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: kAppBarHeight / 2,
                      ),
                      const CategoriesHorizontalListViewBar(),
                      const AdBannerWidget(),
                      ProductShowCaseListView(
                          title: "Upto 70% Off", children: discount70!),
                      ProductShowCaseListView(
                          title: "Upto 60% Off", children: discount60!),
                      ProductShowCaseListView(
                          title: "Upto 50% Off", children: discount50!),
                      ProductShowCaseListView(
                          title: "Explore", children: discount0!),
                    ],
                  ),
                ),
                UserDetailBar(
                  offset: offset,
                ),
              ],
            )
          : const Loadingwidget(),
    );
  }
}
