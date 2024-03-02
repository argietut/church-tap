import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/profile_screen_pages/changepassword.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle triple-dot button tap
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=> const ChangePassword()
            ),
            );
          },
          child: const Text('Change Password'),
        ),
      ),
    );
  }
}
