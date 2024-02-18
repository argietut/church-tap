import 'package:bethel_app_final/colors/color.dart';
import 'package:bethel_app_final/memberScreens/map_components/map_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MemberHomePage extends StatefulWidget {
  const MemberHomePage({Key? key}) : super(key: key);

  @override
  State<MemberHomePage> createState() => _MemberHomePageState();
}

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class _MemberHomePageState extends State<MemberHomePage> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: appBlack.withOpacity(0.1),
                blurRadius: 1.0,
                spreadRadius: 1.0,
                offset: const Offset(0.0, 1.0),
              )
            ],
          ),
           child: Stack(
            children: [
              Positioned(
                right: 16.0,
                top: 20.0,
                child: IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    shape: const CircleBorder(
                      side: BorderSide(color: appGrey, width: 1.0),
                    ),
                  ),
                  icon: const Icon(Icons.tune),
                ),
              ),
              Positioned(
                left: 16.0,
                right: 72.0,
                top: 20.0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  child: Hero(
                    tag: 'planning',
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: appWhite,
                        border: Border.all(color: appGrey, width: 1.0),
                        borderRadius: BorderRadius.circular(32.0),
                        boxShadow: [
                          BoxShadow(
                            color: appGrey.withOpacity(0.5),
                            blurRadius: 8.0,
                            spreadRadius: 8.0,
                            offset: const Offset(0, 4.0),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.maps_home_work_outlined),
                          const SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'locate outreach churches',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _isSearching ? MediaQuery.of(context).size.height - 90 : 0,
              child: _isSearching ? MapPage() : null,
            ),
          ],
        ),
      ),
    );
  }
}


