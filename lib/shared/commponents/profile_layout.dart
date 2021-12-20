import 'package:flutter/material.dart';
import 'profile_info_field.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class ProfileLayout extends StatefulWidget {
  const ProfileLayout({Key? key}) : super(key: key);

  @override
  _ProfileLayoutState createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: mainRed,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: screenHeight / 2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/images.jpeg'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 70,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Positioned(
                  right: 40,
                  bottom: -20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      color: Colors.green,
                      icon: const Icon(
                        Icons.call,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const ProfileInfoField(
              icon: Icons.info,
              text:
                  'User descriptionUser descriptionUser descriptionUser descriptionUser descriptionUser descriptionUser description',
              title: 'Bio',
            ),
            const SizedBox(
              height: 15,
            ),
            const ProfileInfoField(
              icon: Icons.smartphone,
              text: '+963992663032',
              title: 'Mobile',
            ),
            const SizedBox(
              height: 15,
            ),
            ProfileInfoField(
              icon: Icons.email,
              text: 'huthaifazyadeh@gmail.com',
              title: 'Email',
              function: () {},
            ),
            const SizedBox(
              height: 15,
            ),
            ProfileInfoField(
              icon: Icons.facebook,
              text: 'Facebook URL',
              title: 'Facebook',
              function: () {},
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: mainRed,
        label: const Text(
          'Products',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        icon: const Icon(
          Icons.subdirectory_arrow_right,
          size: 30,
        ),
        extendedPadding: const EdgeInsets.all(30),
      ),
    );
  }
}
