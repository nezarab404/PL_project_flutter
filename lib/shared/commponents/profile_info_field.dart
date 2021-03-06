import 'package:flutter/material.dart';
import 'package:programming_languages_project/providers/profile_provider.dart';
import 'package:programming_languages_project/shared/commponents/input_form.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
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
    this.isPhone = false,
  }) : super(key: key);

  final String? title;
  String? text;
  final IconData? icon;
  final bool onEdit;
  final bool? isPassword;
  final bool? isPhone;
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
                color:
                    theme == darkTheme ? Colors.white : mainGrey.withAlpha(95),
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
                  style: TextStyle(
                    color: theme.textTheme.bodyText1!.color,
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
                          style: TextStyle(
                            color: theme.textTheme.bodyText1!.color,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                          obscureText: widget.isPassword!,
                          keyboardType: widget.isPassword!
                              ? TextInputType.none
                              : widget.isPhone!
                                  ? TextInputType.phone
                                  : null,
                          onTap: widget.isPassword!
                              ? () => showChangePasswordDialog()
                              : null //TODO,
                          )
                      : Text(
                          widget.isPassword!
                              ? onPasswordObscureText
                              : widget.controller.text,
                          style: TextStyle(
                            color: theme.textTheme.bodyText1!.color,
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
        var lan = AppLocalizations.of(context)!;
        return AlertDialog(
          content: SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InputForm(
                    isPassword: true,
                    controller: oldPassController,
                    hintText2: lan.currentPassword,
                    pIcon: Icons.lock_clock,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputForm(
                    isPassword: true,
                    controller: newPassController,
                    hintText2: lan.newPassword,
                    pIcon: Icons.password,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputForm(
                    isPassword: true,
                    controller: confirmController,
                    hintText2: lan.confirmPassowrd,
                    pIcon: Icons.check,
                    saveFunction: (_) => setState(() {}),
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
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  lan.passwordsDnotMatch,
                                  style: const TextStyle(
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
              child: Text(lan.cancle),
            ),
            TextButton(
              onPressed: () {
                widget.controller.text = newPassController.text;
                Provider.of<ProfileProvider>(context, listen: false)
                    .updatePassword(
                  oldPassword: oldPassController.text,
                  newPassword: newPassController.text,
                  confirmPassword: confirmController.text,
                );
              },
              child: Text(lan.confirm),
            ),
          ],
        );
      },
    );
  }
}
