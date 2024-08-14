import 'package:favorite_place/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final String kHeroId = "map";

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    this.isSelecting = true,
  });
  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    LatLng? _pickedLocation;
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? "Pick your location" : "Your location"),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save),
            )
        ],
      ),
      body: Hero(
        tag: kHeroId,
        child: GoogleMap(
          onTap: widget.isSelecting == false
              ? null
              : (position) {
                  setState(() {
                    _pickedLocation = position;
                  });
                },
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.location.latitude,
              widget.location.latitude,
            ),
            zoom: 16,
          ),
          markers: (_pickedLocation == null && widget.isSelecting == true)
              ? {}
              : {
                  Marker(
                    markerId: const MarkerId('m1'),
                    position: _pickedLocation ??
                        LatLng(
                          widget.location.latitude,
                          widget.location.latitude,
                        ),
                  ),
                },
        ),
      ),
    );
  }
}
