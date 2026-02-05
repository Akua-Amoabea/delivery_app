import 'dart:async';
import 'dart:convert';

import 'package:delivery_app/provider/data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MapServices {
  static final MapServices _instance = MapServices._internal();

  factory MapServices() => _instance;

  MapServices._internal();

  final Completer<GoogleMapController> _controller = Completer();

  Future<void> moveCamera(LatLng position) async {
    if (!_controller.isCompleted) return;

    final controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 14));
  }

  void onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  Future<void> drawRouteIfReady(BuildContext context) async {
    final provider = context.read<DataProvider>();
    if (provider.pickup == null || provider.destination == null) return;

    final points = await _getDirections(
      provider.pickup!,
      provider.destination!,
    );
    provider.setPolyline(points);
  }

  Future<List<LatLng>> _getDirections(LatLng origin, LatLng destination) async {
    final apiKey = dotenv.env['GOOGLE_API_KEY'] ?? '';
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return [];

    final data = json.decode(response.body);
    final steps = data['routes'][0]['legs'][0]['steps'] as List;

    List<LatLng> points = [];
    for (var step in steps) {
      points.add(
        LatLng(step['start_location']['lat'], step['start_location']['lng']),
      );
      points.add(
        LatLng(step['end_location']['lat'], step['end_location']['lng']),
      );
    }
    return points;
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double x0 = list.first.latitude;
    double x1 = list.first.latitude;
    double y0 = list.first.longitude;
    double y1 = list.first.longitude;

    for (LatLng latLng in list) {
      if (latLng.latitude > x1) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1) y1 = latLng.longitude;
      if (latLng.longitude < y0) y0 = latLng.longitude;
    }

    return LatLngBounds(southwest: LatLng(x0, y0), northeast: LatLng(x1, y1));
  }

  Future<void> zoomToPickupAndDestination(
    LatLng? pickup,
    LatLng? destination,
  ) async {
    final bounds = boundsFromLatLngList([pickup!, destination!]);
    final controller = await _controller.future;

    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 120), // padding
    );
  }
}
