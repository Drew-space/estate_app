import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class RealProfile extends StatelessWidget {
  const RealProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 12),

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Profile",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedNotification01,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// Avatar
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      radius: 55,

                      backgroundImage: NetworkImage(
                        "https://static.vecteezy.com/system/resources/thumbnails/044/245/716/small_2x/handsome-man-smiling-with-a-trendy-beard-and-hairstyle-png.png",
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "Ethan Walker",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 24),

              const Divider(),

              _profileTile(
                icon: HugeIcons.strokeRoundedCalendar03,
                title: "My Booking",
              ),

              _profileTile(
                icon: HugeIcons.strokeRoundedCreditCard,
                title: "Payments",
              ),

              const Divider(),

              _profileTile(icon: HugeIcons.strokeRoundedUser, title: "Profile"),

              _profileTile(
                icon: HugeIcons.strokeRoundedNotification01,
                title: "Notification",
              ),

              _profileTile(
                icon: HugeIcons.strokeRoundedShield01,
                title: "Security",
              ),

              _profileTile(
                icon: HugeIcons.strokeRoundedLanguageCircle,
                title: "Language",
              ),

              _profileTile(
                icon: HugeIcons.strokeRoundedInformationCircle,
                title: "Help Center",
              ),

              _profileTile(
                icon: HugeIcons.strokeRoundedUserGroup,
                title: "Invite Friends",
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: HugeIcon(
                  icon: HugeIcons.strokeRoundedLogout03,
                  color: Colors.red,
                ),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {},
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _profileTile({
    required List<List<dynamic>> icon,
    required String title,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: HugeIcon(icon: icon, color: const Color(0xff1F2937)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}
