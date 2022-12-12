import 'package:sixam_mart/controller/order_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentButton extends StatefulWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final Function onTap;
  final Widget paymentMethod;
  PaymentButton(
      {@required this.isSelected,
        @required this.icon,
        @required this.title,
        this.paymentMethod,
        @required this.subtitle,
        @required this.onTap});

  @override
  State<PaymentButton> createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Padding(
        padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[Get.isDarkMode ? 800 : 200],
                    blurRadius: 5,
                    spreadRadius: 1)
              ],
            ),
            child: ListTile(
              leading: Image.asset(
                widget.icon,
                width: 40,
                height: 40,
                color: widget.isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).disabledColor,
              ),
              title: Text(
                widget.title,
                style:
                robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.subtitle,
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Theme.of(context).disabledColor),
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(child: widget.paymentMethod)
                ],
              ),
              trailing: widget.isSelected
                  ? Icon(Icons.check_circle,
                  color: Theme.of(context).primaryColor)
                  : null,
            ),
          ),
        ),
      );
    });
  }
}
