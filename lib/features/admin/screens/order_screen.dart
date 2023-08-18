import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/order_details/screens/order_details_screens.dart';
import 'package:flutter/material.dart';

import '../../../models/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllOrderProducts();
  }

  fetchAllOrderProducts() async {
    orders = await adminServices.fetchAllOrderProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null ? const Loader() : GridView.builder(
        itemCount: orders!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context , index){
          final orderData = orders![index];
          return SizedBox(
            height: 140,
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, OrderDetailScreen.routeName , arguments: orderData);
              },
              child: SingleProduct(
                image: orderData.products[0].images[0],
              ),
            ),
          );
        }
    );
  }
}
