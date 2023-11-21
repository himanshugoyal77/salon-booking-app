import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/utils/ui/styles.dart';
import 'package:salon_app/utils/ui/text.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.2),
        ),
        child: Icon(icon, color: Styles.primaryColor, size: 20),
      ),
      title: title != 'Logout'
          ? Text(title, style: AppTextStyles.bodySmallBold)
          : Text(title,
              style: AppTextStyles.bodySmallBold.copyWith(color: Colors.red)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Center(
                child: Icon(Icons.arrow_forward_ios,
                    size: 14.0, color: Styles.primaryColor),
              ))
          : null,
    );
  }
}
