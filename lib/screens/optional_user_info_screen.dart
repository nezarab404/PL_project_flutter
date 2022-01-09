import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_languages_project/screens/drawer.dart';
import 'package:provider/provider.dart';

import 'package:programming_languages_project/providers/profile_provider.dart';
import 'package:programming_languages_project/shared/commponents/input_form.dart';
import 'package:programming_languages_project/shared/commponents/mbs_element.dart';
import 'package:programming_languages_project/shared/commponents/text_divider.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class OptionalUserInfoScreen extends StatelessWidget {
  OptionalUserInfoScreen({Key? key}) : super(key: key);
  var bioController = TextEditingController();
  var mobileController = TextEditingController();
  var fbController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var lan = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    var provider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
        ),
        child: Column(
          children: [
            TextDivider(
              text: lan.completeYourProfile,
            ),
            SizedBox(
              height: screenHeight / 40,
            ),
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 110,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: ClipOval(
                      child: provider.profileImage == null
                          ? SvgPicture.asset(
                              'assets/images/avatar.svg',
                            )
                          : Image.file(
                              provider.profileImage!,
                              fit: BoxFit.cover,
                              width: 250,
                              height: 250,
                            ),
                    ),
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
                                    lan.pickImageForm,
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
                                        text: lan.camera,
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
                                        text: lan.gallery,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Provider.of<ProfileProvider>(
                                            context,
                                            listen: false,
                                          ).pickImage(
                                            ImageSource.gallery,
                                          );
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
              hintText: lan.bio,
              pIcon: Icons.info,
              screenWidth: screenWidth,
              isDescription: true,
            ),
            SizedBox(
              height: screenHeight / 40,
            ),
            InputForm(
              controller: mobileController,
              hintText: lan.phoneNumber,
              pIcon: Icons.smartphone,
              screenWidth: screenWidth,
              inputType: TextInputType.phone,
            ),
            SizedBox(
              height: screenHeight / 40,
            ),
            InputForm(
              controller: fbController,
              hintText: lan.facebooko,
              pIcon: Icons.facebook,
              screenWidth: screenWidth,
              inputType: TextInputType.url,
            ),
            SizedBox(
              height: screenHeight / 30,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyDrawer(),
                  ),
                );
              },
              child: Text(
                lan.skip,
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
                    name: me!.name,
                    email: me!.email,
                    image: provider.profileImage,
                    bio: bioController.text,
                    phone: mobileController.text,
                    facebook: fbController.text,
                  )
                      .then((value) {
                    print(value);
                    if(value){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyDrawer(),
                        ),
                      );
                    }
                  });

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
