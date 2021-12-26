import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:programming_languages_project/models/user_model.dart';
import 'package:programming_languages_project/providers/profile_provider.dart';
import 'package:programming_languages_project/shared/commponents/mbs_element.dart';
import 'package:provider/provider.dart';
import '../shared/commponents/profile_info_field.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  bool myProfile = false;
  UserModel? userModel;

  bool onEdit = false;

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var emailController = TextEditingController();
  var facebookAccountController = TextEditingController();
  var passwordController = TextEditingController();

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
  @override
  Widget build(BuildContext context) {
    //////very important to delete before run////////
    widget.myProfile = true;
    //////very important to delete before run////////
    var provider = Provider.of<ProfileProvider>(context);
    var lan = AppLocalizations.of(context)!;
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
                  child: widget.onEdit
                      ? TextFormField(
                          controller: widget.nameController,
                        )
                      :  Text(
                          lan.username,
                          style:const TextStyle(
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
                                                provider.pickImage(
                                                    ImageSource.camera);
                                              },
                                            ),
                                            MBSElement(
                                              icon: Icons.photo_library,
                                              text: lan.gallery,
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
              title: lan.bio,
              function: () {},
              onEdit: widget.onEdit,
              controller: widget.bioController,
            ),
            const SizedBox(
              height: 15,
            ),
            ProfileInfoField(
              icon: Icons.smartphone,
              title: lan.phoneNumber.split(' ').first,
              function: () {},
              onEdit: widget.onEdit,
              controller: widget.mobileNumberController,
            ),
            const SizedBox(
              height: 15,
            ),
            ProfileInfoField(
              icon: Icons.email,
              title: lan.email,
              function: () {},
              onEdit: widget.onEdit,
              controller: widget.emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            ProfileInfoField(
              icon: Icons.facebook,
              title: lan.facebook,
              function: () {},
              onEdit: widget.onEdit,
              controller: widget.facebookAccountController,
            ),
            if (widget.myProfile)
              const SizedBox(
                height: 15,
              ),
            if (widget.myProfile)
              ProfileInfoField(
                icon: Icons.password,
                title:lan.password,
                function: () {},
                onEdit: widget.onEdit,
                isPassword: true,
                controller: widget.passwordController,
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
                  widget.onEdit = !widget.onEdit;
                });
              },
              backgroundColor: mainRed,
              label: widget.onEdit
                  ?  Text(
                      lan.done,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    )
                  :  Text(
                      lan.edit,
                      style:const TextStyle(
                        fontSize: 22,
                      ),
                    ),
              icon: widget.onEdit
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
              label:  Text(
                lan.products,
                style:const TextStyle(
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
