import 'package:flutter/material.dart';
import 'package:swipeswap/widgets/custom_app_bar.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController itemsController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Form(
        child: Column(
          children: [
            // Items to order
            TextFormField(
              controller: itemsController,
            ),
            // Price
            TextFormField(
              controller: itemsController,
              keyboardType: TextInputType.number,
            ),
            // Location
            // TODO: Peter's gonna figure out API-key with flutter, Pranav has an API key
            // TODO: Google form field using https://pub.dev/packages/map_location_picker/
          ],
        ),
      ),
    );
  }
}
