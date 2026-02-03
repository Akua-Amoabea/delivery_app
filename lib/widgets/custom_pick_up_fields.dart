import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_places_api_flutter/google_places_api_flutter.dart';

class PickupField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final void Function(Prediction, PlaceDetailsModel?) onPlacedSelected;

  const PickupField({
    super.key,
    required this.textEditingController,
    required this.focusNode,
    required this.onPlacedSelected,
  });


  @override
  Widget build(BuildContext context) {
    return PlaceSearchField(
      apiKey: dotenv.env['GOOGLE_API_KEY'] ?? '',
      isLatLongRequired: true,
      focusNode: focusNode,
      controller: textEditingController,
      onPlaceSelected: onPlacedSelected,
      decorationBuilder: (context, child) {
        return Material(
          type: MaterialType.card,
          elevation: 4,
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: child,
        );
      },
      itemBuilder: (context, prediction) => ListTile(
        leading: const Icon(Icons.location_on),
        title: Text(
          prediction.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
