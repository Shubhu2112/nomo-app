import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_appbar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/location_services/location_service.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/address/presentation/cubit/add_address.cubit.dart';
import 'package:nomo_app/features/address/presentation/cubit/address_list.cubit.dart';
import 'package:nomo_app/features/address/presentation/widgets/add_address_bottomsheet.widget.dart';

class AddAddressView extends StatefulWidget {
  static String routeName = "/add_address_view";
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  GoogleMapController? mapController;
  LatLng? _center;
  LatLng? _currentMapPosition;
  String? _currentAddress;
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _currentMapPosition = _center;
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    if (mounted) {
      Position? currentPosition =
          await LocationService.getCurrentPosition(context);
      setState(() {
        _center = LatLng(currentPosition?.latitude ?? 0.0,
            currentPosition?.longitude ?? 0.0);
        _currentMapPosition = _center;
        _getAddressFromLatLng(_center!);
      });
    }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks.first;

      if (mounted) {
        final cubit = context.read<AddAddressCubit>();
        cubit.address = cubit.address?.copyWith(
            lat: position.latitude.toString(),
            long: position.longitude.toString(),
            pincode: int.parse(place.postalCode ?? "0"));
      }
      setState(() {
        _currentAddress =
            "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print("Error fetching address: $e");
    }
  }

  void _onCameraMove(CameraPosition position) {
    _currentMapPosition = position.target;
  }

  void _onCameraIdle() {
    setState(() {
      _center = _currentMapPosition;
      if (!isSearch) {
        _getAddressFromLatLng(_center!);
      }
      isSearch = false;
    });
  }

  Future<void> _onPlaceSelected(Prediction prediction) async {
    try {
      LatLng selectedLatLng;
      if (prediction.lat != null && prediction.lng != null) {
        selectedLatLng = LatLng(
            double.parse(prediction.lat!), double.parse(prediction.lng!));
      } else {
        List<Location> locations =
            await locationFromAddress(prediction.description ?? "");
        Location location = locations.first;
        selectedLatLng = LatLng(location.latitude, location.longitude);
      }

      mapController?.animateCamera(CameraUpdate.newLatLng(selectedLatLng));
      setState(() {
        _center = selectedLatLng;

        _currentAddress = prediction.description;
      });
    } catch (e) {
      setState(() {
        _currentAddress = "Location not found";
      });
      print("Error finding location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomText(_currentAddress ?? 'Loading address...').db(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomPrimaryButton(
              width: double.infinity,
              textValue: CustomText("Add more address details >")
                  .lm()
                  .textColor(Theme.of(context).colorScheme.surface),
              onPress: () {
                AddAddressBottomSheet.show(
                  context,
                  () {
                    Navigator.pop(context);
                    NavigationService.goBack(context);
                    context.read<AddressListCubit>().init();
                  },
                );
              },
            ),
          ),
        ],
      ),
      appBar: CustomAppBar(
        titleWidget: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 8),
            SizedBox(
              height: 42,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: searchController,
                  boxDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  googleAPIKey: "AIzaSyDZQMbnQyNj3ToHC3VPaFDK_DiG5VUSt4I",
                  inputDecoration: InputDecoration(
                    hintText: "Search Location",
                    border: InputBorder.none,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                            color: Theme.of(context).colorScheme.surfaceBright),
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).colorScheme.primary),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                    isCollapsed: true,
                  ),
                  debounceTime: 800,
                  countries: const ["in"],
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (Prediction prediction) {
                    _onPlaceSelected(prediction);
                  },
                  itemClick: (Prediction prediction) {
                    isSearch = true;
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    searchController.text = prediction.description ?? "";
                    _onPlaceSelected(prediction);
                    searchController.selection = TextSelection.fromPosition(
                      TextPosition(offset: searchController.text.length),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: _center == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center!,
                    zoom: 15.0,
                  ),
                  onCameraMove: _onCameraMove,
                  onCameraIdle: _onCameraIdle,
                ),
                const Center(
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ],
            ),
    );
  }
}
