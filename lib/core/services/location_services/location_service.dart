import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class LocationService {
  /// Static method to check for location permissions and fetch the current position
  static Future<Position?> getCurrentPosition(BuildContext context) async {
    // Check the current permission status
    LocationPermission permission = await Geolocator.checkPermission();

    // Handle permission scenarios
    if (permission == LocationPermission.denied) {
      // Request permission if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // If permission is still denied, show an error or handle accordingly
        if (context.mounted) {
          _showSnackBar(context, 'Location permissions are denied.');
        }
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle when permissions are permanently denied
      if (context.mounted) {
        _showDialogToOpenSettings(context);
      }
      return null;
    }

    // If permissions are granted, fetch the current position
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      try {
        return await Geolocator.getCurrentPosition();
      } catch (e) {
        if (context.mounted) {
          _showSnackBar(context, 'Failed to get current position: $e');
        }
        return null;
      }
    }

    // Handle unexpected cases
    if (context.mounted) {
      _showSnackBar(context, 'Unexpected permission status.');
    }
    return null;
  }

  /// Static method to show a dialog prompting the user to open app settings
  static void _showDialogToOpenSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
              'Location permissions are permanently denied. Please enable permissions in the app settings.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Geolocator.openAppSettings(); // Open app settings
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  /// Static method to show a snackbar with a custom message
  static void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
