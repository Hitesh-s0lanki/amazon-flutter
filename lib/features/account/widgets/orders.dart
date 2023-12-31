import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/order_details/screens/order_details_screens.dart';
import 'package:flutter/material.dart';

import '../../../models/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final AccountServices accountServices = AccountServices();
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    fetchMyOrders();
  }
  fetchMyOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return orders == null ? const Loader() : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Yours Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15,top: 10),
              child: Text(
                'See all',
                style: TextStyle(
                  color: GlobalVariable.selectedNavBarColor
                ),
              ),
            ),
          ],
        ),

        //display Orders
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10,right: 0,top: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orders!.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, OrderDetailScreen.routeName , arguments: orders![index]);
                  }, child: SingleProduct(
                        image: orders![index].products[0].images[0])
                    );
          }),
        )
      ],
    );
  }
}
