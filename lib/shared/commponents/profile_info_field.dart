import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/commponents/input_form.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class ProfileInfoField extends StatefulWidget {
  ProfileInfoField({
    Key? key,
    required this.title,
    required this.icon,
    // this.suffix,
    required this.onEdit,
    required this.controller,
    //text attribute used only with profiles not belonging to user
    this.text,
    this.function,
    this.isPassword = false,
  }) : super(key: key);

  final String? title;
  String? text;
  final IconData? icon;
  final bool onEdit;
  final bool? isPassword;
  final TextEditingController controller;
  // final IconData? suffix;
  final Function()? function;

  @override
  State<ProfileInfoField> createState() => _ProfileInfoFieldState();
}

class _ProfileInfoFieldState extends State<ProfileInfoField> {
  @override
  Widget build(BuildContext context) {
    String onPasswordObscureText = '';
    for (int i = 0; i < widget.controller.text.length; i++) {
      onPasswordObscureText += '*';
    }
    return ElevatedButton(
      onPressed: widget.function,
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                widget.icon,
                color: mainRed,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: widget.onEdit
                      ? TextFormField(
                          maxLines: widget.isPassword! ? 1 : null,
                          controller: widget.controller,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                          obscureText: widget.isPassword!,
                          keyboardType:
                              widget.isPassword! ? TextInputType.none : null,
                          onTap: widget.isPassword!
                              ? () => showChangePasswordDialog()
                              : null //TODO,
                          )
                      : Text(
                          widget.isPassword!
                              ? onPasswordObscureText
                              : widget.controller.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                        ),
                ),
              ],
            ),
            //suffix icon
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     suffix,
            //     color: mainRed,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        var oldPassController = TextEditingController();
        var newPassController = TextEditingController();
        var confirmController = TextEditingController();
        return AlertDialog(
          content: SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InputForm(
                    isPassword: true,
                    controller: oldPassController,
                    hintText2: 'Current password',
                    pIcon: Icons.lock_clock,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputForm(
                    isPassword: true,
                    controller: newPassController,
                    hintText2: 'New password',
                    pIcon: Icons.password,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputForm(
                    isPassword: true,
                    controller: confirmController,
                    hintText2: 'Confirm password',
                    pIcon: Icons.check,
                    saveFunction:(_)=> setState(() {}),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  oldPassController.text.isEmpty
                      ? const Text('')
                      : (confirmController.text == newPassController.text) &&
                              (newPassController.text.isNotEmpty)
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 50,
                            )
                          : Row(
                              children: const [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Passwords do not match',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                widget.controller.text = newPassController.text;
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
