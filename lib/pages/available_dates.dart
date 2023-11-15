import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/components/date_piceker.dart';
import 'package:salon_app/utils/styles.dart';
import 'package:salon_app/utils/text.dart';

class AvailableModal extends StatelessWidget {
  const AvailableModal({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> time = [
      {"time": "09:00 AM", "isAvailable": false},
      {"time": "10:00 AM", "isAvailable": false},
      {"time": "11:00 AM", "isAvailable": true},
      {"time": "12:00 PM", "isAvailable": false},
      {"time": "01:00 PM", "isAvailable": false},
      {"time": "04:00 PM", "isAvailable": false},
      {"time": "05:00 PM", "isAvailable": false},
      {"time": "06:00 PM", "isAvailable": true},
      {"time": "07:00 PM", "isAvailable": false},
      {"time": "08:00 PM", "isAvailable": false},
      {"time": "09:00 PM", "isAvailable": false}
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Dates',
            style:
                AppTextStyles.heading6Bold.copyWith(color: Styles.primaryColor),
          ),
          const CustomDatePicker(),
          Text(
            'Available Times',
            style:
                AppTextStyles.heading6Bold.copyWith(color: Styles.primaryColor),
          ),
          const SizedBox(
            height: 20,
          ),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            shrinkWrap: true,
            children: time
                .map(
                  (e) => Chip(
                    backgroundColor: !e["isAvailable"]
                        ? Colors.transparent
                        : Styles.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: !e["isAvailable"]
                            ? Colors.grey[400]!
                            : Styles.primaryColor,
                      ),
                    ),
                    color: MaterialStateProperty.all(Styles.primaryColor),
                    labelPadding: const EdgeInsets.all(0),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    visualDensity: VisualDensity.compact,
                    label: Center(
                      child: Text(
                        e['time'] as String,
                        style: !e["isAvailable"]
                            ? AppTextStyles.bodyExtraSmall
                                .copyWith(color: Colors.grey[600])
                            : AppTextStyles.bodyExtraSmallSemibold
                                .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
