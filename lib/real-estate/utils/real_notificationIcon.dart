import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class RealNotificationicon extends StatelessWidget {
  const RealNotificationicon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.grey.shade200, width: 2),
          ),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedNotification01,
            size: 24,
          ),
        ),

        Positioned(
          top: 10,
          right: 10,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
