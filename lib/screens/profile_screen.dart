import 'package:flutter/material.dart';
import '../shared/commponents/profile_info_field.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class ProfileLayout extends StatefulWidget {
  bool myProfile = false;

  ProfileLayout({
    Key? key,
    this.myProfile = false,
  }) : super(key: key);

  ProfileLayout.myProfile({
    Key? key,
    this.myProfile = true,
  }) : super(key: key);

  @override
  _ProfileLayoutState createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  bool onEdit = false;

  final bioController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final facebookAccountController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //////very important to move before run////////
    widget.myProfile = true;
    //////very important to move before run////////

    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: mainRed,
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
                    child: widget.myProfile
                        ? IconButton(
                            onPressed: () {},
                            color: mainRed,
                            icon: const Icon(
                              Icons.camera_alt,
                            ),
                          )
                        : IconButton(
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
            ProfileInfoField(
              icon: Icons.info,
              text:
                  'User descriptionUser descriptionUser descriptionUser descriptionUser descriptionUser descriptionUser description',
              title: 'Bio',
              function: () {},
              onEdit: onEdit,
              controller: bioController,
            ),
            const SizedBox(
              height: 15,
            ),
            ProfileInfoField(
              icon: Icons.smartphone,
              text: '+963992663032',
              title: 'Mobile',
              function: () {},
              onEdit: onEdit,
              controller: mobileNumberController,
            ),
            const SizedBox(
              height: 15,
            ),
            ProfileInfoField(
              icon: Icons.email,
              text: 'huthaifazyadeh@gmail.com',
              title: 'Email',
              function: () {},
              onEdit: onEdit,
              controller: emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            ProfileInfoField(
              icon: Icons.facebook,
              text: 'Facebook URL',
              title: 'Facebook',
              function: () {},
              onEdit: onEdit,
              controller: facebookAccountController,
            ),
            if (widget.myProfile)
              const SizedBox(
                height: 15,
              ),
            if (widget.myProfile)
              ProfileInfoField(
                icon: Icons.password,
                text: '********',
                title: 'Password',
                function: () {},
                onEdit: onEdit,
                controller: passwordController,
              ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.myProfile
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  onEdit = !onEdit;
                });
              },
              backgroundColor: mainRed,
              label: onEdit
                  ? const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    )
                  : const Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
              icon: onEdit
                  ? const Icon(
                      Icons.check,
                      size: 30,
                    )
                  : const Icon(
                      Icons.edit,
                      size: 30,
                    ),
              extendedPadding: const EdgeInsets.all(30),
            )
          : FloatingActionButton.extended(
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
