import 'package:delivery_app/constants/colors.dart';
import 'package:delivery_app/widgets/controller_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataProvider extends ChangeNotifier {
  LatLng? _pickup;
  LatLng? _destination;

  bool getIsScheduledDelivery = false;

  void setIsScheduledDelivery(bool value) {
    getIsScheduledDelivery = value;
    notifyListeners();
  }

  bool isOrdered = false;

  void setIsOrdered(bool value) {
    isOrdered = value;
    notifyListeners();
  }

  String selectedOption = "Me";

  void setOption(String value) {
    selectedOption = value;
    notifyListeners();
  }

  final ControllerManager _controllerManager = ControllerManager();

  bool isSubmitted = false;

  void setIsSubmitted(bool value) {
    isSubmitted = value;
    notifyListeners();
  }

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};

  LatLng? get pickup => _pickup;

  LatLng? get destination => _destination;

  Set<Marker> get markers => _markers;

  Set<Polyline> get polyLines => _polyLines;

  void setPickup(LatLng latLng) {
    _pickup = latLng;
    _markers.add(
      Marker(
        markerId: const MarkerId('pickup'),
        position: latLng,
        infoWindow: const InfoWindow(title: 'Pickup'),
      ),
    );
    notifyListeners();
  }

  void setDestination(LatLng latLng) {
    _destination = latLng;
    _markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: latLng,
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    );
    notifyListeners();
  }

  void resetSelection() {
    _pickup = null;
    _destination = null;

    _controllerManager.destinationController.clear();

    _controllerManager.pickFieldController.clear();

    _polyLines.clear();
    _markers.clear();

    notifyListeners();
  }

  void setPolyline(List<LatLng> points) {
    _polyLines.clear();
    _polyLines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        color: primaryColor,
        width: 5,
        points: points,
      ),
    );
    notifyListeners();
  }
}
