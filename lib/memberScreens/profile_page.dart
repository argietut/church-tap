import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://example.com/your-profile-image.jpg', // Replace with the actual profile image URL
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle Edit Profile button tap
              },
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 16),
            const ProfileDetail(title: 'Name', value: 'Argiezu'),
            const ProfileDetail(title: 'Address', value: 'New York City'),
            const ProfileDetail(title: 'Date of Birth', value: 'January 1, 19999'),
            const ProfileDetail(title: 'Gender', value: 'Male'),
          ],
        ),
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final String title;
  final String value;

  const ProfileDetail({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
