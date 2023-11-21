import 'package:flutter/material.dart';
import 'package:salon_app/utils/ui/styles.dart';
import 'package:salon_app/utils/ui/text.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProfileController());
    const tFormHeight = 60.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => {},
            icon: Icon(Icons.arrow_back_ios,
                size: 20, color: Styles.primaryColor)),
        centerTitle: true,
        title: Text("Update Profile",
            style: AppTextStyles.heading6Bold
                .copyWith(color: Styles.primaryColor)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // -- IMAGE with ICON
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
                      child: const Icon(Icons.camera_alt,
                          color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text("Name"),
                          prefixIcon: Icon(
                            Icons.supervised_user_circle,
                            size: 20,
                            color: Styles.primaryColor,
                          )),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text("Email"),
                          prefixIcon: Icon(
                            Icons.mail,
                            size: 20,
                            color: Styles.primaryColor,
                          )),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text("PhoneNo"),
                          prefixIcon: Icon(
                            Icons.phone,
                            size: 20,
                            color: Styles.primaryColor,
                          )),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: const Text("Password"),
                        prefixIcon: Icon(
                          Icons.fingerprint,
                          size: 20,
                          color: Styles.primaryColor,
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              size: 20,
                              color: Styles.primaryColor,
                            ),
                            onPressed: () {}),
                      ),
                    ),
                    const SizedBox(height: tFormHeight),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Styles.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text("Update Profile",
                            style: AppTextStyles.bodyRegularBold
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                    // -- Created Date and Delete Button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
