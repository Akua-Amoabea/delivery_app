import 'dart:async';

import 'package:date_field/date_field.dart';
import 'package:delivery_app/constants/colors.dart';
import 'package:delivery_app/home/components/courier_details.dart';
import 'package:delivery_app/home/home_screen.dart';
import 'package:delivery_app/provider/data_provider.dart';
import 'package:delivery_app/widgets/controller_manager.dart';
import 'package:delivery_app/widgets/custom_pick_up_fields.dart';
import 'package:delivery_app/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../services/map_services.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  LatLng _initialPosition = const LatLng(5.6037, -0.1870);
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();
  final ControllerManager _controllerManager = ControllerManager();
  final MapServices _mapServices = MapServices();
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestLocationPermission();
    });

    _controllerManager.pickFieldFocusNode.addListener(() {
      if (_controllerManager.pickFieldFocusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _draggableScrollableController.animateTo(
            1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) await Permission.location.request();

    if (await Permission.location.isGranted) {
      final dataProvider = context.read<DataProvider>();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
        dataProvider.markers.add(
          Marker(
            markerId: const MarkerId('pickup'),
            position: _initialPosition,
            infoWindow: const InfoWindow(title: 'Pickup location'),
          ),
        );
      });
      final controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLng(_initialPosition));
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<DataProvider>();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: (controller) {
                _mapController.complete(controller);
                _mapServices.onMapCreated(controller);
              },
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 12,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: dataProvider.markers,
              polylines: dataProvider.polyLines,
            ),
          ),

          // Top Icon or Courier Info
          Positioned(
            top: 50,
            left: 20,
            right: dataProvider.isOrdered ? 20 : null,
            child: dataProvider.isOrdered
                ? Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: primaryColor),
                    child: const Text(
                      'Your Courier is on the way!',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      dataProvider.setIsOrdered(false);
                      dataProvider.setIsSubmitted(false);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
          ),

          // Draggable Sheet with constrained height
          DraggableScrollableSheet(
            controller: _draggableScrollableController,
            initialChildSize: 0.25,
            minChildSize: 0.25,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: _buildSheetContent(dataProvider),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSheetContent(DataProvider dataProvider) {
    if (dataProvider.isOrdered) return CourierDetails();

    if (dataProvider.isSubmitted) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              dataProvider.resetSelection();
              requestLocationPermission();
              dataProvider.setIsSubmitted(false);
            },
            icon: Icon(Icons.arrow_back, color: primaryColor),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  'Vehicle Type',
                  style: TextStyle(
                    color: lightBlack,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomVehicleIcons(icon: Icons.motorcycle),
                    CustomVehicleIcons(
                      icon: Icons.directions_bus_filled_rounded,
                    ),
                    CustomVehicleIcons(icon: Icons.directions_car_filled),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          CustomTextButton(text: 'Confirm', onPressed: () {}),
        ],
      );
    }

    // Default "Pickup/Delivery" Form
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            height: 5,
            width: 40,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Text(
          dataProvider.getIsScheduledDelivery
              ? 'Schedule Delivery'
              : 'Instant Delivery',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Text(
          'Set your pickup and destination',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        const Text(
          'Pickup Location',
          style: TextStyle(color: lightBlack, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 8),
        PickupField(
          textEditingController: _controllerManager.pickFieldController,
          focusNode: _controllerManager.pickFieldFocusNode,
          onPlacedSelected: (prediction, details) {
            if (details?.result != null) {
              final latLng = LatLng(
                details!.result.geometry!.location.lat,
                details.result.geometry!.location.lng,
              );
              context.read<DataProvider>().setPickup(latLng);
            }
            _controllerManager.pickFieldFocusNode.unfocus();
          },
        ),
        const SizedBox(height: 14),
        const Text(
          'Delivery Location',
          style: TextStyle(color: lightBlack, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 8),
        PickupField(
          textEditingController: _controllerManager.destinationController,
          focusNode: _controllerManager.destinationFocusNode,
          onPlacedSelected: (prediction, details) {
            if (details?.result != null) {
              final latLng = LatLng(
                details!.result.geometry!.location.lat,
                details.result.geometry!.location.lng,
              );
              context.read<DataProvider>().setDestination(latLng);
            }
            _controllerManager.destinationFocusNode.unfocus();
          },
        ),
        const SizedBox(height: 20),
        dataProvider.getIsScheduledDelivery
            ? DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Choose Date and Time',
                ),
                firstDate: DateTime.now().add(const Duration(days: 10)),
                lastDate: DateTime.now().add(const Duration(days: 40)),
                onChanged: (DateTime? value) {
                  //selectedDate = value;
                },
              )
            : SizedBox.shrink(),

        const SizedBox(height: 20),
        CustomTextButton(
          text: 'Next',
          onPressed: () {
            _draggableScrollableController.animateTo(
              0.5,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }
}

class CustomVehicleIcons extends StatelessWidget {
  final IconData icon;

  const CustomVehicleIcons({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(20),
          icon: Icon(icon, size: 40, color: primaryColor),
          style: TextButton.styleFrom(
            backgroundColor: background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Price:₵30.00',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
        ),
        const Text(
          '20 mins away',
          style: TextStyle(fontSize: 10, color: primaryColor),
        ),
      ],
    );
  }
}
