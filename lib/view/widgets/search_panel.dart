import 'package:flutter/material.dart';
import '../../core/constants/app_styles.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// Widget panel tìm kiếm, nhận controller và callback onSearch
class SearchPanel extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onUseCurrentLocation;

  const SearchPanel({
    Key? key,
    required this.controller,
    required this.onSearch,
    required this.onUseCurrentLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Enter a City Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'E.g., New York, London, Tokyo',
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
            ),
            onSubmitted: (_) => onSearch(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onSearch,
            child: const Text('Search',
                style: TextStyle(color: AppColors.textWhite)),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('or'),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onUseCurrentLocation,
            child: const Text(
              'Use Current Location',
              style: TextStyle(color: AppColors.textWhite),
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: AppColors.grayapp,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
          ),
        ],
      ),
    );
  }
}
