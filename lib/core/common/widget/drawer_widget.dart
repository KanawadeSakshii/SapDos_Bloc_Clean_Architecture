import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/features/auth/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppPallete.gradient1,
      child: ListView(
        children: [
          const DrawerHeader(
              child: Center(
            child: Text(
              'SAPDOS',
              style: TextStyle(
                  color: AppPallete.whiteColor,
                  fontSize: 30,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold),
            ),
          )),
          ListTile(
            leading: const Icon(
              Icons.category_sharp,
              color: AppPallete.whiteColor,
            ),
            title: const Text(
              'Categories',
              style: TextStyle(color: AppPallete.whiteColor),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.calendar_month_rounded,
              color: AppPallete.whiteColor,
            ),
            title: const Text(
              'Appointment',
              style: TextStyle(color: AppPallete.whiteColor),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.chat_bubble,
              color: AppPallete.whiteColor,
            ),
            title: const Text(
              'Chat',
              style: TextStyle(color: AppPallete.whiteColor),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: AppPallete.whiteColor,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(color: AppPallete.whiteColor),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: AppPallete.whiteColor,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: AppPallete.whiteColor),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: AppPallete.gradient1,
                    contentPadding: EdgeInsets.all(0),
                    content: Container(
                      height: 300,
                      padding: EdgeInsets.all(16),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            size: 50,
                            color: AppPallete.whiteColor,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Do you want to logout?",
                            style: TextStyle(
                              color: AppPallete.whiteColor,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppPallete.gradient1,
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyWelcomePage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Yes.",
                          style: TextStyle(color: AppPallete.gradient1),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
