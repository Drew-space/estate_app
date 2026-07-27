import 'package:estate_app/core/widgets/get_user_name.dart';
import 'package:estate_app/core/widgets/real_notificationIcon.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RealUserprofileRow extends StatelessWidget {
  const RealUserprofileRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 5,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: const AssetImage('assets/images/avatar.png'),
            ),

            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Welcome back",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  child: const GetUserName(),
                ),
              ],
            ),
          ],
        ),

        // Nofification
        RealNotificationicon(),
      ],
    );
  }
}
