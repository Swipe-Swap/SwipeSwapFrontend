import 'package:flutter/material.dart';
import 'package:swipeswap/widgets/custom_nav_bar.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:validatorless/validatorless.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _itemsController = TextEditingController();
    TextEditingController _maxPriceController = TextEditingController();
    String _deliveryLocation = '';
    List<bool> _delivery = [true, false];
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Items to order
            TextFormField(
              controller: _itemsController,
              decoration: const InputDecoration(
                hintText: "Your order",
              ),
              validator: Validatorless.required("Order cannot be blank!"),
            ),
            // Max base price
            TextFormField(
              controller: _maxPriceController,
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
                  _delivery[value] = !_delivery[value];
                });
              },
            ),
            // Location
            (_delivery[0])
                ? MapLocationPicker(
                    apiKey: dotenv.env['API_KEY']!,
                    onNext: (GeocodingResult? result) {
                      if (result != null) {
                        _deliveryLocation = result.formattedAddress ?? "";
                      }
                    },
                  )
                : const Placeholder(),
            // Delivery instructions
            (_delivery[0])
                ? TextFormField(
                    controller: _itemsController,
                    decoration: const InputDecoration(
                      hintText: "Delivery instructions",
                    ),
                  )
                : const Placeholder(),
            ElevatedButton(
              onPressed: () {
                // Run validator for address
                if (_deliveryLocation.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Address must be specified for an order to be delivered!"),
                    ),
                  );
                } else {
                  // Submit data
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
