import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/utils/ui/styles.dart';
import 'package:salon_app/utils/ui/text.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class UserSchedule extends StatelessWidget {
  const UserSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              style: AppTextStyles.heading6Bold
                  .copyWith(color: Styles.primaryColor),
            ),
            actions: [
              IconButton(
                onPressed: () => {},
                icon: Icon(Icons.search, size: 20, color: Styles.primaryColor),
              )
            ],
            bottom: TabBar(
                indicatorColor: Styles.primaryColor,
                indicator: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Styles.primaryColor,
                  width: 4,
                ))),
                tabs: [
                  Tab(
                    child: Text(
                      'Active',
                      style: AppTextStyles.bodySmallMedium
                          .copyWith(color: Styles.primaryColor),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Completed',
                      style: AppTextStyles.bodySmallMedium
                          .copyWith(color: Styles.primaryColor),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    AppointmentCard(size: size),
                    AppointmentCard(size: size),

                    const SizedBox(height: 20),

                    /// -- EMPTY STATE
                  ],
                ),
              ),
            ),
            const EmptyScreen()
          ])),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Styles.primaryColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('assets/artists/a1.jpg',
                      fit: BoxFit.cover, width: 130, height: 120),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Flexible(
                        child: Text(
                          'Haircut, Hair Color, Hair Spa',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppTextStyles.bodyRegularBold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.location_solid,
                              size: 14,
                              color: Colors.blueGrey.withOpacity(0.5),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '1.5 km',
                              style: AppTextStyles.bodyExtraSmall,
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.clock,
                              size: 14,
                              color: Colors.blueGrey.withOpacity(0.5),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '10:00 AM',
                              style: AppTextStyles.bodyExtraSmall,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.money_dollar,
                          size: 20,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 0),
                        Text(
                          '1500',
                          style: AppTextStyles.bodyRegularBold,
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
                      'Booking ID',
                      style: AppTextStyles.bodyExtraSmall,
                    ),
                    Text(
                      '#12345678',
                      style: AppTextStyles.bodyRegularBold,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Date',
                      style: AppTextStyles.bodyExtraSmall,
                    ),
                    Text(
                      '8th July',
                      style: AppTextStyles.bodyRegularBold,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment status',
                      style: AppTextStyles.bodyExtraSmall,
                    ),
                    Text(
                      'Paid',
                      style: AppTextStyles.bodyRegularBold,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: size.width * 0.4,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'Leave Review',
                    style: AppTextStyles.bodySmallBold
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.4,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    primary: Styles.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'E-Receipt',
                    style: AppTextStyles.bodySmallBold
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12)
        ],
      ),
    );
  }
}

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/empty-cart.png', width: 200, height: 200),
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
    );
  }
}
