import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_textfield.dart';

class CustomSearchBar extends StatefulWidget {
  final String? searchHint;
  final Function(String search)? onSearch;
  final void Function()? onPress;
  final bool autofocus;
  final bool? isEnable;
  final bool enableDebounce; // Configurable debounce option
  final int debounceDuration; // Debounce duration in milliseconds
  const CustomSearchBar({
    super.key,
    this.searchHint,
    this.onSearch,
    this.onPress,
    this.isEnable = true,
    this.autofocus = false,
    this.enableDebounce = false, // Default to false
    this.debounceDuration = 300, // Default debounce duration
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController searchController = TextEditingController();

  Timer? _debounce;

  void _onSearchChanged(String value) {
    if (widget.enableDebounce) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();

      _debounce = Timer(Duration(milliseconds: widget.debounceDuration), () {
        widget.onSearch?.call(value);
      });
    } else {
      widget.onSearch?.call(value);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel(); // Cancel debounce timer to avoid memory leaks
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: searchController,
      hintText: widget.searchHint ?? "Search Namkeen",
      autofocus: widget.autofocus,
      isRequired: false,
      isEnable: widget.isEnable,
      textInputType: TextInputType.text,
      prefixIcon:
          Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
      borderRadius: 24,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      focusedColor: Theme.of(context).colorScheme.primary,
      enabledBorder: Theme.of(context).colorScheme.onPrimary,
      isDense: true,
      onChanged: (value) {
        // Handle search query changes here
        print('Search Query: $value');

        _onSearchChanged(value);
      },
      onPress: widget.onPress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a search term';
        }
        return null;
      },
    );
  }
}
