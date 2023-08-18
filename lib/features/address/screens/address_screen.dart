import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';

import 'package:pay/pay.dart';

import '../../../providers/user_provider.dart';
import 'payment_configurations.dart' as payment_configurations;

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount ;
  const AddressScreen({super.key , required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}



class _AddressScreenState extends State<AddressScreen> {

  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";

  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  final List<PaymentItem> _paymentItems = [];

  final AddressService addressService = AddressService();

  void payPressed(String addressFromProvider){
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
                  areaController.text.isNotEmpty ||
                  pincodeController.text.isNotEmpty ||
                  cityController.text.isNotEmpty;

    if(isForm){
      if(_addressFormKey.currentState!.validate()){
        addressToBeUsed = '${flatBuildingController.text}, ${areaController.text}, ${pincodeController.text} - ${cityController.text}';
        addressService.saveUserAddress(context: context, address: addressToBeUsed);
        addressService.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount));
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty){
      addressToBeUsed = addressFromProvider;
      addressService.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount));
    } else{
      showSnackBar(context, 'Error');
    }

  }
  
  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('gpay.json');
    _paymentItems.add(PaymentItem(
      label: 'Total',
      amount: widget.totalAmount,
      status: PaymentItemStatus.final_price,
    ));
  }

  void onGooglePayResult(paymentResult) {
    print(paymentResult);
    debugPrint(paymentResult.toString());
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
              flexibleSpace: Container(
              decoration: const BoxDecoration(
              gradient: GlobalVariable.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if(address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(address, style: const TextStyle(fontSize: 18),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),const SizedBox(height: 20,),

                  ],
                ),
              Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      CustomTextField(controller: flatBuildingController,hintText: 'Flat, House no, Building',),
                      const SizedBox(height: 10,),
                      CustomTextField(controller: areaController,hintText: 'Area, Street',),
                      const SizedBox(height: 10,),
                      CustomTextField(controller: pincodeController,hintText: 'Pincode',),
                      const SizedBox(height: 10,),
                      CustomTextField(controller: cityController,hintText: 'Town/City',),
                      const SizedBox(height: 10,),
                      GooglePayButton(
                        onPressed: () => payPressed(address),
                        paymentConfigurationAsset: 'gpay.json',
                        onPaymentResult: onGooglePayResult,
                        paymentItems: _paymentItems,
                        height: 50,
                        type: GooglePayButtonType.buy,
                        margin: const EdgeInsets.only(top: 15),
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

