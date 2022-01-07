import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:programming_languages_project/providers/profile_provider.dart';
import 'package:programming_languages_project/screens/home_screen.dart';
import 'package:programming_languages_project/shared/commponents/input_form.dart';
import 'package:programming_languages_project/shared/commponents/mbs_element.dart';
import 'package:programming_languages_project/shared/commponents/text_divider.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';

class OptionalUserInfoScreen extends StatelessWidget {
  OptionalUserInfoScreen({Key? key}) : super(key: key);
  var bioController = TextEditingController();
  var mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
        ),
        child: Column(
          children: [
            const TextDivider(
              text: 'Complete Your Profile',
            ),
            SizedBox(
              height: screenHeight / 40,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: SvgPicture.asset('assets/images/avatar.svg'),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: IconButton(
                      onPressed: () {
                        //to add photo
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
                                          Provider.of<ProfileProvider>(
                                            context,
                                            listen: false,
                                          ).pickImage(
                                            ImageSource.camera,
                                          );
                                        },
                                      ),
                                      MBSElement(
                                        icon: Icons.photo_library,
                                        text: 'Gallery',
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Provider.of<ProfileProvider>(
                                            context,
                                            listen: false,
                                          )
                                              .pickImage(
                                            ImageSource.gallery,
                                          )
                                              .then((value) {
                                            Provider.of<ProfileProvider>(
                                              context,
                                              listen: false,
                                            ).updateProfile(
                                              bio: bioController.text,
                                              email: me!.email,
                                              name: me!.name,
                                              image:
                                                  Provider.of<ProfileProvider>(
                                                          context)
                                                      .profileImage,
                                            );
                                          });
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
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 20,
            ),
            InputForm(
              controller: bioController,
              hintText: 'Bio',
              pIcon: Icons.info,
              screenWidth: screenWidth,
              isDescription: true,
            ),
            // SizedBox(
            //   height: screenHeight / 40,
            // ),
            // InputForm(
            //   controller: mobileController,
            //   hintText: 'Mobile',
            //   pIcon: Icons.smartphone,
            //   screenWidth: screenWidth,
            //   inputType: TextInputType.phone,
            // ),
            SizedBox(
              height: screenHeight / 30,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Drawer(),
                  ),
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: mainRed,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight / 30,
            ),
            SizedBox(
              height: screenHeight / 10,
              width: screenHeight / 10,
              child: FloatingActionButton(
                onPressed: () {
                  Provider.of<ProfileProvider>(
                    context,
                    listen: false,
                  )
                      .updateProfile(
                        bio: bioController.text,
                        name: me!.name,
                        email: me!.email,
                        image:
                            Provider.of<ProfileProvider>(context).profileImage,
                      )
                      .then((value) => print);
                },
                backgroundColor: mainRed,
                child: Icon(
                  Icons.arrow_forward,
                  color: mainDarkBlue,
                ),
                elevation: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
