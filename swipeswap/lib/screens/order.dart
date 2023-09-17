import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipeswap/models/order.dart';
import 'package:swipeswap/provider/order_provider.dart';
import 'package:swipeswap/provider/user_provider.dart';
import 'package:swipeswap/utils/constants.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:validatorless/validatorless.dart';

class Order extends StatefulWidget {
  const Order({
    super.key,
  });

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController orderDetailsController = TextEditingController();
    TextEditingController deliveryInstructionsController =
        TextEditingController();
    TextEditingController maxPriceController = TextEditingController();
    String deliveryLocation = '';
    List<bool> delivery = [true, false];
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            // Items to order
            TextFormField(
              controller: orderDetailsController,
              decoration: const InputDecoration(
                hintText: "Your order",
              ),
              validator: Validatorless.required("Order cannot be blank!"),
            ),
            // Max base price
            TextFormField(
              controller: maxPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Max base price (not accounting for delivery)",
              ),
              validator: Validatorless.multiple([
                Validatorless.min(1, 'The price must be greater than 1'),
                Validatorless.max(20, 'The price must be less than 20'),
                Validatorless.required("Price cannot be blank!")
              ]),
            ),
            ToggleButtons(
              isSelected: const [true, false],
              children: const [Text("Pickup"), Text("Deliver")],
              onPressed: (value) {
                setState(() {
                  delivery[value] = !delivery[value];
                });
              },
            ),
            // Location
            (delivery[0])
                ? MapLocationPicker(
                    apiKey: dotenv.env['API_KEY']!,
                    onNext: (GeocodingResult? result) {
                      if (result != null) {
                        deliveryLocation = result.formattedAddress ?? "";
                      }
                    },
                  )
                : const Placeholder(),
            // Delivery instructions
            (delivery[0])
                ? TextFormField(
                    controller: deliveryInstructionsController,
                    decoration: const InputDecoration(
                      hintText: "Delivery instructions",
                    ),
                  )
                : const Placeholder(),
            ElevatedButton(
              onPressed: () {
                // Run validator for address
                if (deliveryLocation.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Address must be specified for an order to be delivered!"),
                    ),
                  );
                } else {
                  // Submit data
                  db.collection("orders").add(
                        SwapOrder.toJson(
                          SwapOrder(
                            deliveryInstructions:
                                deliveryInstructionsController.text,
                            deliveryLocation: deliveryLocation,
                            diningCourt: Provider.of<OrderProvider>(context,
                                    listen: false)
                                .diningCourt
                                .toString(),
                            isDelivery: delivery[0],
                            orderDetails: orderDetailsController.text,
                            orderStatus: OrderStatus.listed,
                            buyerId: Provider.of<UserProvider>(context,
                                    listen: false)
                                .user
                                ?.uuid,
                            sellerId: null,
                          ),
                        ),
                      );
                  Navigator.pushNamed(context, Routes.matching.toString());
                }
              },
              child: const Text("Submit?"),
            ),
          ],
        ),
      ),
    );
  }
}
