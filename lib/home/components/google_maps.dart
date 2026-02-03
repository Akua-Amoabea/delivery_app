import 'dart:async';

import 'package:delivery_app/constants/colors.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestLocationPermission();
    });

    _controllerManager.pickFieldFocusNode.addListener(() {
      if (_controllerManager.pickFieldFocusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Animate to fully expanded
          _draggableScrollableController.animateTo(
            1.0, // fully expanded
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });

        /*   WidgetsBinding.instance.addPostFrameCallback((_) {
          _mapServices.selectPickup(context);
        });*/
      }
    });
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }

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
        _mapServices.moveCamera(_initialPosition);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<DataProvider>();

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _mapServices.onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 11,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: dataProvider.markers,
            polylines: dataProvider.polyLines,
          ),

          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              icon: Icon(Icons.arrow_back_ios_new),
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: whiteColor,
              ),
            ),
          ),

          DraggableScrollableSheet(
            controller: _draggableScrollableController,
            initialChildSize: 0.25,
            minChildSize: 0.25,
            maxChildSize: 1.0,
            expand: true,
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
                child: dataProvider.isSubmitted
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                dataProvider.resetSelection();
                                requestLocationPermission();
                                dataProvider.setIsSubmitted(false);
                              },
                              child: Text(
                                'Back',
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: CustomTextButton(text: 'Confirm'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // drag handle
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

                            const Text(
                              'Instant Delivery',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),
                            const Text(
                              'Set your pickup and destination',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              'Pickup Location',
                              style: TextStyle(
                                color: lightBlack,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 8),

                            PickupField(
                              textEditingController:
                                  _controllerManager.pickFieldController,
                              focusNode: _controllerManager.pickFieldFocusNode,
                              onPlacedSelected: (prediction, details) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  _controllerManager.pickFieldFocusNode
                                      .unfocus();
                                });
                                if (details?.result != null) {
                                  final latLng = LatLng(
                                    details!.result.geometry!.location.lat,
                                    details.result.geometry!.location.lng,
                                  );

                                  // Save pickup location in provider
                                  context.read<DataProvider>().setPickup(
                                    latLng,
                                  );
                                }
                              },
                            ),

                            //  CustomTextField(focusNode: _pickupFocusNode),
                            const SizedBox(height: 14),
                            const Text(
                              'Delivery Location',
                              style: TextStyle(
                                color: lightBlack,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 8),
                            PickupField(
                              textEditingController:
                                  _controllerManager.destinationController,
                              focusNode:
                                  _controllerManager.destinationFocusNode,
                              onPlacedSelected: (prediction, details) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  _controllerManager.destinationFocusNode
                                      .unfocus();
                                });
                                if (details?.result != null) {
                                  final latLng = LatLng(
                                    details!.result.geometry!.location.lat,
                                    details.result.geometry!.location.lng,
                                  );

                                  // Save pickup location in provider
                                  context.read<DataProvider>().setDestination(
                                    latLng,
                                  );
                                }
                              },
                            ),

                            const SizedBox(height: 14),
                            const Text(
                              'Vehicle Type',
                              style: TextStyle(
                                color: lightBlack,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                CustomVehicleIcons(icon: Icons.motorcycle),
                                CustomVehicleIcons(
                                  icon: Icons.directions_bus_filled_rounded,
                                ),
                                CustomVehicleIcons(
                                  icon: Icons.directions_car_filled,
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),
                            CustomTextButton(
                              text: 'Next',
                              onPressed: () async {
                                // Collapse the sheet

                                _draggableScrollableController.animateTo(
                                  0.25,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );

                                // Draw route polyline if both pickup & destination exist
                                await _mapServices.drawRouteIfReady(context);
                                await _mapServices.zoomToPickupAndDestination(
                                  dataProvider.pickup,
                                  dataProvider.destination,
                                );
                                dataProvider.setIsSubmitted(true);
                              },
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomVehicleIcons extends StatelessWidget {
  final IconData icon;

  const CustomVehicleIcons({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      padding: EdgeInsets.all(20),
      icon: Icon(icon, size: 50, color: primaryColor),
      style: TextButton.styleFrom(
        backgroundColor: background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
