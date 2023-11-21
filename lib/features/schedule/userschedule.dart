import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/utils/ui/styles.dart';
import 'package:salon_app/utils/ui/text.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class UserSchedule extends StatelessWidget {
  const UserSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () => {},
              icon: Icon(Icons.arrow_back_ios,
                  size: 20, color: Styles.primaryColor)),
          title: Text(
            'Your Appointments',
            style:
                AppTextStyles.heading6Bold.copyWith(color: Styles.primaryColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text("Upcoming Appointments",
                    style: AppTextStyles.bodySmallMedium
                        .copyWith(color: Styles.primaryColor)),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Styles.primaryColor.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                        child: Row(
                          children: [
                            Image.asset('assets/artists/a1.png',
                                width: 100, height: 100),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.time,
                                      size: 14,
                                      color:
                                          Styles.primaryColor.withOpacity(0.5),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Thu, Nov 12',
                                          style: AppTextStyles.bodyExtraSmall,
                                        ),
                                        Text(
                                          '10:00 AM - 11:00 AM',
                                          style: AppTextStyles.bodySmallBold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.location,
                                      size: 14,
                                      color:
                                          Styles.primaryColor.withOpacity(0.5),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Velvet Salon',
                                          style: AppTextStyles.bodyExtraSmall,
                                        ),
                                        Text(
                                          '123, Main Street, New York',
                                          style: AppTextStyles.bodyExtraSmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Service',
                                  style: AppTextStyles.bodyExtraSmall,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Flexible(
                                    child: Text(
                                      'Haircut, Hair Color, Hair Spa',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: AppTextStyles.bodySmallBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Booking ID: 1234567890',
                                  style: AppTextStyles.bodyExtraSmall,
                                ),
                                SizedBox(
                                  width: 150,
                                  height: 40.0,
                                  child: SfBarcodeGenerator(
                                    value: '1234567890',
                                    symbology: Code39(
                                      module: 1,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Divider(),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 200,
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            primary: Styles.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Request Cancellation',
                            style: AppTextStyles.bodySmallBold
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12)
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                /// -- EMPTY STATE
                Text("Past Appointments",
                    style: AppTextStyles.bodySmallMedium
                        .copyWith(color: Styles.primaryColor)),
                const SizedBox(height: 8),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/empty-cart.png',
                          width: 200, height: 200),
                      const SizedBox(height: 4),
                      Text(
                        "No appointments yet",
                        style: AppTextStyles.bodySmallBold.copyWith(
                          color: Styles.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
