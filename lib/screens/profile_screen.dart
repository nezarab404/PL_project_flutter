import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:programming_languages_project/models/user_model.dart';
import 'package:programming_languages_project/providers/profile_provider.dart';
import 'package:programming_languages_project/shared/commponents/mbs_element.dart';
import 'package:provider/provider.dart';
import '../shared/commponents/profile_info_field.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  bool myProfile = false;
  UserModel? user;

  bool onEdit = false;

//controllers
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var emailController = TextEditingController();
  var facebookAccountController = TextEditingController();

  var passwordController = TextEditingController(text: 'password');

  ProfileScreen({
    Key? key,
    this.myProfile = false,
    required this.user,
  }) : super(key: key) {
    //initializing controllers
    nameController.text = user!.name!;
    bioController.text = user!.bio!;
    emailController.text = user!.email!;
  }

  ProfileScreen.myProfile({
    Key? key,
    this.myProfile = true,
    required this.user,
  }) : super(key: key) {
    //initializing controllers
    nameController.text = user!.name!;
    bioController.text = user!.bio!;
    emailController.text = user!.email!;
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var noListenProvider = Provider.of<ProfileProvider>(context, listen: false);
    noListenProvider.getProfile();
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
      //body
      body: SingleChildScrollView(
        child: Column(
          children: [
            //profile photo + username + call/change photo icon button
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: screenHeight / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: widget.user!.image == null
                          ? SvgPicture.asset(
                              'assets/images/avatar.svg',
                            ) as ImageProvider
                          : NetworkImage(
                              widget.user!.image!,
                            ),
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
                  //username field
                  child: widget.onEdit
                      ? TextFormField(
                          controller: widget.nameController,
                        )
                      : Text(
                          widget.nameController.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                ),
                //icon button position and function
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
                              //to change photo
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
                                                noListenProvider.pickImage(
                                                  ImageSource.camera,
                                                );
                                              },
                                            ),
                                            MBSElement(
                                              icon: Icons.photo_library,
                                              text: 'Gallery',
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                noListenProvider
                                                    .pickImage(
                                                  ImageSource.gallery,
                                                )
                                                    .then((value) {
                                                  noListenProvider
                                                      .updateProfile(
                                                    bio: widget
                                                        .bioController.text,
                                                    email: widget
                                                        .emailController.text,
                                                    name: widget
                                                        .nameController.text,
                                                    image:
                                                        provider.profileImage,
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
                              Icons.camera_alt,
                            ),
                          )
                        : //to call
                        IconButton(
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
            //bio field
            ProfileInfoField(
              icon: Icons.info,
              title: 'Bio',
              function: () {},
              onEdit: widget.onEdit,
              controller: widget.bioController,
            ),
            const SizedBox(
              height: 15,
            ),
            //mobile phone number field
            ProfileInfoField(
              icon: Icons.smartphone,
              title: 'Mobile',
              function: () {},
              onEdit: widget.onEdit,
              controller: widget.mobileNumberController,
            ),
            const SizedBox(
              height: 15,
            ),
            //email address field
            ProfileInfoField(
              icon: Icons.email,
              title: 'Email',
              function: () {},
              onEdit: widget.onEdit,
              controller: widget.emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            //facebokk account field
            ProfileInfoField(
              icon: Icons.facebook,
              title: 'Facebook',
              function: () {},
              onEdit: widget.onEdit,
              controller: widget.facebookAccountController,
            ),
            if (widget.myProfile)
              const SizedBox(
                height: 15,
              ),
            //password field if user is in his own profile
            if (widget.myProfile)
              ProfileInfoField(
                icon: Icons.password,
                title: 'Password',
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
      //edit /done editing FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.myProfile
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  if (widget.onEdit) {
                    noListenProvider.updateProfile(
                      bio: widget.bioController.text,
                      email: widget.emailController.text,
                      name: widget.nameController.text,
                      image: provider.profileImage,
                    );
                  }
                  widget.onEdit = !widget.onEdit;
                });
              },
              backgroundColor: mainRed,
              label: widget.onEdit
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
          : //see products FAB
          FloatingActionButton.extended(
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
