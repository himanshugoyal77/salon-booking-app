import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/features/auth/view/pages/auth.dart';
import 'package:salon_app/features/profile/widgets/profilemenu.dart';
import 'package:salon_app/features/profile/widgets/updateprofile.dart';
import 'package:salon_app/utils/ui/styles.dart';
import 'package:salon_app/utils/ui/text.dart';

import '../../db/userinfo.dart';
import '../auth/controller/siginin.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Styles.primaryColor,
            )),
        centerTitle: true,
        title: Text("Profile",
            style: AppTextStyles.heading6Bold
                .copyWith(color: Styles.primaryColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- IMAGE
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                          image: AssetImage('assets/user-image.png'))),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1)),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text("Sarah Smith",
                style: AppTextStyles.heading5Bold
                    .copyWith(color: Styles.primaryColor)),
            Text("joined 2w ago",
                style: AppTextStyles.bodySmall
                    .copyWith(color: Styles.primaryColor)),
            const SizedBox(height: 18),

            /// -- BUTTON
            SizedBox(
              width: 200,
              height: 45.0,
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UpdateProfileScreen();
                  })),
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.primaryColor,
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: const Text("Edit Profile",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),

            /// -- MENU
            Container(
              height: MediaQuery.of(context).size.height * 0.48,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              decoration: BoxDecoration(
                  color: Styles.secondaryColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 2)
                  ]),
              child: Column(
                children: [
                  ProfileMenuWidget(
                      title: "Settings", icon: Icons.settings, onPress: () {}),
                  ProfileMenuWidget(
                      title: "Billing Details",
                      icon: Icons.wallet,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "User Management",
                      icon: Icons.verified_user,
                      onPress: () {}),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProfileMenuWidget(
                      title: "Information", icon: Icons.info, onPress: () {}),
                  ProfileMenuWidget(
                      title: "Logout",
                      icon: Icons.logout,
                      textColor: Colors.red,
                      endIcon: false,
                      onPress: () {
                        UserDb.removeUserInfo();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const AuthPage();
                        }));
                        Authentication.signOut(context: context);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
