import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:programming_languages_project/providers/profile_provider.dart';
import 'package:programming_languages_project/shared/commponents/mbs_element.dart';
import 'package:provider/provider.dart';
import '../shared/commponents/profile_info_field.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class ProfileScreen extends StatefulWidget {
  bool myProfile = false;

  ProfileScreen({
    Key? key,
    this.myProfile = false,
  }) : super(key: key);

  ProfileScreen.myProfile({
    Key? key,
    this.myProfile = true,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool onEdit = false;

  final bioController = TextEditingController(
      text: 'User description User description User description');
  final mobileNumberController = TextEditingController(text: '+963992663032');
  final emailController =
      TextEditingController(text: 'huthaifazyadeh@gmail.com');
  final facebookAccountController = TextEditingController(text: 'Facebook URL');
  final passwordController = TextEditingController(text: 'user password');

  @override
  Widget build(BuildContext context) {
    //////very important to delete before run////////
    widget.myProfile = true;
    //////very important to delete before run////////

    var provider = Provider.of<ProfileProvider>(context);
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: provider.profileImage == null
                          ? const AssetImage(
                              'assets/images/images.jpeg',
                            )
                          : FileImage(
                              provider.profileImage!,
                            ) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
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
                            onPressed: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: darkBlue,
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: screenHeight / 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Pick Image Form',
                                          style: TextStyle(
                                            color: mainGrey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            MBSElement(
                                              icon: Icons.camera_alt,
                                              text: 'Camera',
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                provider.pickImage(
                                                    ImageSource.camera);
                                              },
                                            ),
                                            MBSElement(
                                              icon: Icons.photo_library,
                                              text: 'Gallery',
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                provider.pickImage(
                                                    ImageSource.gallery);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
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
                title: 'Password',
                function: () {},
                onEdit: onEdit,
                isPassword: true,
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
