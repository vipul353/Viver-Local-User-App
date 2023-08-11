import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';

class CardsDetails extends StatefulWidget {
  const CardsDetails();

  @override
  _CardsDetailsState createState() => _CardsDetailsState();
}

class _CardsDetailsState extends State<CardsDetails> {
  List<Map<String, dynamic>> CardData = [];
  List<dynamic> loadedData=[];
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedData =
        CardData.map((data) => json.encode(data)).toList();
    await prefs.setStringList('CreditCardsData', encodedData);
      print(encodedData);
    CardData.clear();
  
  }
  
  Future<List<dynamic>> loadData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> encodedData = prefs.getStringList('CreditCardsData');
  List<dynamic> decodedData = encodedData.map((data) => json.decode(data)).toList();
  print(decodedData);
  return decodedData;
}
  // CardFieldInputDetails _initialDetials =
  CardFormEditController _Controlller = CardFormEditController(
      initialDetails: CardFieldInputDetails(
          // brand: 'VISA',
          // complete: true,
          // expiryMonth: 12,
          // expiryYear: 2034,
          // cvc: '567',
          // last4: '4242',
          // number: '4242424242424242',
          // postalCode: '12345',
          // validNumber: CardValidationState.Valid,
          // validCVC: CardValidationState.Valid,
          // validExpiryDate: CardValidationState.Valid
          ));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData().then((value) =>   setState(() {
       loadedData = value;
      }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Cards"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 300,
                child:CardFormField(
                  countryCode: 'BR',
                  controller: _Controlller,
                  dangerouslyUpdateFullCardDetails: true,
                  dangerouslyGetFullCardDetails: true,
                  onCardChanged: (details) {
                   if (details.complete==true) {
                         CardData.add({
                      'brand': 'VISA',
                      'complete': true,
                      'expiryMonth': details.expiryMonth,
                      'expiryYear': details.expiryYear,
                      'cvc': details.cvc,
                      'last4': details.last4,
                      'number':details.number,
                      'postalCode': details.postalCode,
                    });
                   }
                  },
                  style: CardFormStyle(
                      backgroundColor: Color.fromARGB(255, 62, 55, 203),
                      borderRadius: 20,
                      
                      textColor: Colors.white),
                ),
              ),
            ),
            SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      saveData();
                    },
                    child: RichText(text: TextSpan(text: 'save and pay')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.all(16.0), // Add padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Add border radius
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            (loadedData.isNotEmpty)?SizedBox(
              height: 225,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: loadedData.length,
                itemBuilder: (context, index) {
                return InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  height: 225,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Credit Card Number",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white))),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: RichText(
                              text: TextSpan(
                                  text: "${loadedData[index]['number']}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white))),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            // margin: EdgeInsets.only(left: 5),
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: RichText(
                                  text: TextSpan(
                                      text: "${loadedData[index]['expiryMonth']}/${loadedData[index]['expiryYear']}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white))),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            // margin: EdgeInsets.only(right: 10),
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: RichText(
                                  text: TextSpan(
                                      text: "${loadedData[index]['cvc']}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            // margin: EdgeInsets.only(left: 5),
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: RichText(
                                  text: TextSpan(
                                      text: "${loadedData[index]['brand']}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white))),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            // margin: EdgeInsets.only(right: 10),
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: RichText(
                                  text: TextSpan(
                                      text: "${loadedData[index]['postalCode']}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
              },),
            ):SizedBox()
          ],
        ),
      ),
    );
  }
}
