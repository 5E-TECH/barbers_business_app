import 'dart:async';

import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Result model for location picker
class LocationResult {
  final double latitude;
  final double longitude;
  final String address;

  const LocationResult({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class LocationPickerScreen extends StatefulWidget {
  /// Initial latitude (optional)
  final double? initialLatitude;

  /// Initial longitude (optional)
  final double? initialLongitude;

  const LocationPickerScreen({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
  });

  /// Show the location picker and return the selected location
  static Future<LocationResult?> show(
    BuildContext context, {
    double? initialLatitude,
    double? initialLongitude,
  }) {
    return Navigator.push<LocationResult>(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(
          initialLatitude: initialLatitude,
          initialLongitude: initialLongitude,
        ),
      ),
    );
  }

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng? _selectedLocation;
  String _address = '';
  bool _isLoading = true;
  bool _isLoadingAddress = false;
  String? _errorMessage;

  // Default location (Tashkent, Uzbekistan)
  static const LatLng _defaultLocation = LatLng(41.2995, 69.2401);

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // If initial coordinates provided, use them
      if (widget.initialLatitude != null && widget.initialLongitude != null) {
        _selectedLocation = LatLng(
          widget.initialLatitude!,
          widget.initialLongitude!,
        );
        if (mounted) {
          await _getAddressFromCoordinates(_selectedLocation!);
        }
        if (mounted) {
          setState(() => _isLoading = false);
        }
        return;
      }

      // Otherwise, get current location
      final position = await _getCurrentLocation();
      if (!mounted) return;

      if (position != null) {
        _selectedLocation = LatLng(position.latitude, position.longitude);
        await _getAddressFromCoordinates(_selectedLocation!);
      } else {
        // Use default location if current location fails
        _selectedLocation = _defaultLocation;
        await _getAddressFromCoordinates(_selectedLocation!);
      }
    } catch (e) {
      _selectedLocation = _defaultLocation;
      _errorMessage = 'Could not get current location. Using default.';
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<Position?> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showMessage('Location services are disabled. Please enable them.');
        return null;
      }

      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showMessage('Location permission denied.');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showMessage(
          'Location permissions are permanently denied. Please enable in settings.',
        );
        return null;
      }

      // Get current position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> _getAddressFromCoordinates(LatLng location) async {
    if (!mounted) return;
    setState(() => _isLoadingAddress = true);

    try {
      final placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (!mounted) return;

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final parts = <String>[];

        if (place.street?.isNotEmpty == true) parts.add(place.street!);
        if (place.subLocality?.isNotEmpty == true) parts.add(place.subLocality!);
        if (place.locality?.isNotEmpty == true) parts.add(place.locality!);
        if (place.administrativeArea?.isNotEmpty == true) {
          parts.add(place.administrativeArea!);
        }
        if (place.country?.isNotEmpty == true) parts.add(place.country!);

        _address = parts.isNotEmpty ? parts.join(', ') : 'Unknown location';
      } else {
        _address = 'Unknown location';
      }
    } catch (e) {
      _address = 'Could not get address';
    }

    if (mounted) {
      setState(() => _isLoadingAddress = false);
    }
  }

  void _onMapTap(LatLng location) async {
    if (!mounted) return;
    setState(() {
      _selectedLocation = location;
    });

    // Move camera to new location
    try {
      if (_controller.isCompleted && mounted) {
        final controller = await _controller.future;
        if (mounted) {
          controller.animateCamera(CameraUpdate.newLatLng(location));
        }
      }
    } catch (_) {
      // Controller was disposed, ignore
    }

    // Get address for new location
    if (mounted) {
      await _getAddressFromCoordinates(location);
    }
  }

  Future<void> _goToCurrentLocation() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final position = await _getCurrentLocation();
    if (!mounted) return;

    if (position != null) {
      final newLocation = LatLng(position.latitude, position.longitude);
      setState(() {
        _selectedLocation = newLocation;
      });

      try {
        if (_controller.isCompleted && mounted) {
          final controller = await _controller.future;
          if (mounted) {
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: newLocation, zoom: 16),
              ),
            );
          }
        }
      } catch (_) {
        // Controller was disposed, ignore
      }

      if (mounted) {
        await _getAddressFromCoordinates(newLocation);
      }
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _confirmLocation() {
    if (_selectedLocation == null) {
      _showMessage('Please select a location');
      return;
    }

    Navigator.pop(
      context,
      LocationResult(
        latitude: _selectedLocation!.latitude,
        longitude: _selectedLocation!.longitude,
        address: _address,
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BarbershopTheme.ink,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BarbershopTheme.background,
      body: Stack(
        children: [
          // Map
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: BarbershopTheme.forest),
            )
          else
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _selectedLocation ?? _defaultLocation,
                zoom: 16,
              ),
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              onTap: _onMapTap,
              markers: _selectedLocation != null
                  ? {
                      Marker(
                        markerId: const MarkerId('selected'),
                        position: _selectedLocation!,
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen,
                        ),
                      ),
                    }
                  : {},
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
            ),

          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.5),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: BarbershopTheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: BarbershopTheme.ink,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Select Location',
                        style: BarbershopTheme.title(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Current location button
          Positioned(
            right: 16,
            bottom: 260,
            child: GestureDetector(
              onTap: _goToCurrentLocation,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: BarbershopTheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.my_location,
                  color: BarbershopTheme.forest,
                  size: 24,
                ),
              ),
            ),
          ),

          // Bottom card
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: BarbershopTheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: BarbershopTheme.line,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Location info
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: BarbershopTheme.forest.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: BarbershopTheme.forest,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected Location',
                                  style: BarbershopTheme.label(),
                                ),
                                const SizedBox(height: 4),
                                if (_isLoadingAddress)
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: BarbershopTheme.muted,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Getting address...',
                                        style: BarbershopTheme.body(),
                                      ),
                                    ],
                                  )
                                else
                                  Text(
                                    _address.isNotEmpty
                                        ? _address
                                        : 'Tap on map to select location',
                                    style: BarbershopTheme.body(
                                      color: BarbershopTheme.ink,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Coordinates
                      if (_selectedLocation != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: BarbershopTheme.chip,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Latitude', style: BarbershopTheme.label()),
                                    const SizedBox(height: 2),
                                    Text(
                                      _selectedLocation!.latitude.toStringAsFixed(6),
                                      style: BarbershopTheme.body(
                                        color: BarbershopTheme.ink,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 30,
                                color: BarbershopTheme.line,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Longitude', style: BarbershopTheme.label()),
                                      const SizedBox(height: 2),
                                      Text(
                                        _selectedLocation!.longitude.toStringAsFixed(6),
                                        style: BarbershopTheme.body(
                                          color: BarbershopTheme.ink,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 16),

                      // Confirm button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _selectedLocation != null ? _confirmLocation : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BarbershopTheme.forest,
                            disabledBackgroundColor:
                                BarbershopTheme.forest.withValues(alpha: 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Confirm Location',
                                style: BarbershopTheme.body(color: Colors.white)
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.check, color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Error message
          if (_errorMessage != null)
            Positioned(
              top: 100,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: BarbershopTheme.accent.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: BarbershopTheme.body(color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _errorMessage = null),
                      child: const Icon(Icons.close, color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
