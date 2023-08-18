import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/search/services/seacrh_services.dart';
import 'package:amazon_clone/features/search/widgets/searched_product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../../product_details/screens/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  String searchQuery;
  SearchScreen({super.key , required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  void navigateToSearchScreen(String query){
    products = null;
    fetchSearchProducts();
    widget.searchQuery = query;
    _searchController.text = '';
  }

  @override
  void initState() {
    super.initState();
    fetchSearchProducts();
  }

  fetchSearchProducts() async{
    products = await searchServices.fetchSearchProducts(context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariable.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      elevation: 1,
                      borderRadius: BorderRadius.circular(7),
                      child: TextFormField(
                        controller: _searchController,
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: (){},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(Icons.search , color: Colors.black, size: 23,),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(color: Colors.black38 ,width: 1),
                            ),
                            hintText: 'Search Amazon.in',
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17
                            )
                        ),
                      ),
                    )
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic , color: Colors.black, size: 25,),
              )
            ],
          ),
        ),
      ),
      body: products == null ? const Loader() :
            products!.isEmpty ? const Center(
             child: Text('No product to Display'),
            ) : Column(
              children: [
                const AddressBox(),
                const SizedBox(height: 10,),
                Expanded(
                    child: ListView.builder(
                      itemCount: products!.length,
                        itemBuilder:(context,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, ProductDetailScreen.routeName ,arguments: products![index] );
                            },
                              child: SearchedProduct(product: products![index]));
                        }
                    )
                )
              ],
            ),
    );
  }
}
