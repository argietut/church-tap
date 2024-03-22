import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/profile_screen_pages/changepassword.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Setting",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 50),
                ],
              ),
              const SizedBox(height: 15),
              const Divider(
                color: appGreen,
              ),
              const SizedBox(height: 50),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> const ChangePassword()
                    ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(appGreen)
                  ),
                  child: const Text('Change Password',
                  style: TextStyle(
                    color: appBlack
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
