// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guardian/controller/category_provider.dart';
import 'package:guardian/data/models/password_schema.dart';
import 'package:guardian/data/repositories/password_repository.dart';
import 'package:guardian/data/service/database_service.dart';
import 'package:guardian/helpers/custom_toast.dart';
import 'package:guardian/services/encryption_service.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/constants/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PasswordDetailsScreen extends StatefulWidget {
  final Password password;
  const PasswordDetailsScreen({super.key, required this.password});

  @override
  State<PasswordDetailsScreen> createState() => _PasswordDetailsScreenState();
}

class _PasswordDetailsScreenState extends State<PasswordDetailsScreen> {
  bool isPasswordHidden = true;
  bool isReadOnly = true;

  late String connectedAccount;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  late PasswordRepository _passwordRepository;

  Future pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    connectedAccount = widget.password.connectedAccount ?? "";
    usernameController.text = widget.password.username!;
    passwordController.text =
        EncryptionService().decryptPassword(widget.password.encryptedPassword);
    websiteController.text = widget.password.websiteAddress!;
    noteController.text = widget.password.note!;
    titleController.text = widget.password.title;
    _passwordRepository = Provider.of<PasswordRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Password Details",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isReadOnly = !isReadOnly;
              });
            },
            icon: isReadOnly
                ? Icon(Icons.edit_outlined)
                : Icon(Icons.close_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.tileColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.scaffoldBackgroundColor,
                      child: widget.password.imagePath != null || _image != null
                          ? ClipOval(
                              child: Stack(
                                children: [
                                  Image.file(
                                    File(_image?.path ??
                                        widget.password.imagePath!),
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  if (!isReadOnly)
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          pickImage();
                                        },
                                        icon: Icon(Icons.edit_outlined),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : isReadOnly
                              ? Text(
                                  widget.password.title.substring(0, 1),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                              : Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      pickImage();
                                    },
                                    icon: Icon(Icons.edit_outlined),
                                  ),
                                ),
                    )),
                    Gap(20),
                    Center(
                        child: isReadOnly
                            ? Text(
                                widget.password.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              )
                            : TextField(
                                textAlign: TextAlign.center,
                                cursorColor: AppColors.scaffoldBackgroundColor,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                                controller: titleController,
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              )),
                    Gap(20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username/email address',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          Gap(8),
                          PasswordDetailTextField(
                            textEditingController: usernameController,
                            icon: Icons.mail_outlined,
                            isReadOnly: isReadOnly,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          Gap(8),
                          PasswordDetailTextField(
                            textEditingController: passwordController,
                            isReadOnly: isReadOnly,
                            icon: Icons.lock_outline,
                            isPassword: true,
                            obscureText: isPasswordHidden,
                            suffixIcon: IconButton(
                              onPressed: () {
                                print("icon pressed");
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                              icon: isPasswordHidden
                                  ? Icon(
                                      Icons.visibility_off_rounded,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.visibility_rounded,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                          Gap(16),
                          Text(
                            'Connected account',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          Gap(15),
                          isReadOnly
                              ? widget.password.connectedAccount != null
                                  ? Row(
                                      children: [
                                        Gap(12),
                                        Image.asset(
                                          accountImagesMap[widget
                                              .password.connectedAccount!]!,
                                          width: 20,
                                          height: 20,
                                        ),
                                        Gap(12),
                                        Text(
                                          widget.password.connectedAccount!,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink()
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: connectedAccountsList
                                        .map((String account) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: ChoiceChip(
                                          padding: EdgeInsets.all(8),
                                          elevation: 0,
                                          label: Text(
                                            account,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          selected: connectedAccount == account,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              connectedAccount = account;
                                            });
                                          },
                                          backgroundColor:
                                              AppColors.scaffoldBackgroundColor,
                                          selectedColor:
                                              AppColors.blueAppColor,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Gap(15),
                    Row(
                      children: [
                        Text(
                          "Details",
                          style: TextStyle(
                            color: AppColors.blueAppColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    Gap(15),
                    Text(
                      'Website Address',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    PasswordDetailTextField(
                      textEditingController: websiteController,
                      isReadOnly: isReadOnly,
                    ),
                    Text(
                      'Note',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    PasswordDetailTextField(
                      textEditingController: noteController,
                      isReadOnly: isReadOnly,
                    )
                  ],
                ),
              ),
              Gap(30),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStatePropertyAll(0),
                    shape: WidgetStatePropertyAll(
                      StadiumBorder(),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      isReadOnly
                          ? Colors.red.withOpacity(0.8)
                          : AppColors.blueAppColor.withOpacity(0.8),
                    ),
                  ),
                  onPressed: isReadOnly
                      ? () async {
                          await _passwordRepository.deletePassword(widget.password);
                          Navigator.of(context).pop();
                          Toasts()
                              .showSuccessToast(context, "Password deleted!");
                        }
                      : () async {
                          await DatabaseService()
                              .updatePassword(
                            widget.password,
                            title: titleController.text,
                            username: usernameController.text,
                            encryptedPassword: EncryptionService()
                                .encryptPassword(passwordController.text),
                            connectedAccount: connectedAccount,
                            websiteAddress: websiteController.text,
                            note: noteController.text,
                            imagePath: _image != null
                                ? _image?.path
                                : widget.password.imagePath,
                          )
                              .whenComplete(() {
                            Navigator.of(context).pop();
                            Toasts()
                                .showSuccessToast(context, "Password updated!");
                          });
                        },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isReadOnly
                          ? Icon(CupertinoIcons.delete)
                          : Icon(Icons.check_outlined),
                      Gap(8),
                      Text(
                        isReadOnly ? "Delete Password" : "Save Password",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordDetailTextField extends StatelessWidget {
  final String? hintText;
  final bool isPassword;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool isReadOnly;
  final IconData? icon;
  final TextEditingController textEditingController;

  const PasswordDetailTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.isPassword = false,
    this.obscureText = false,
    required this.isReadOnly,
    this.icon,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isReadOnly
          ? EdgeInsets.all(0)
          : EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
      child: TextFormField(
        controller: textEditingController,
        readOnly: isReadOnly,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabled: isPassword ? true : !isReadOnly,
          border: _getBorder(),
          enabledBorder: _getBorder(),
          focusedBorder: _getBorder(color: AppColors.blueAppColor),
          disabledBorder: InputBorder.none,
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : null,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.subTextColor),
          filled: false,
        ),
      ),
    );
  }

  InputBorder? _getBorder({Color color = Colors.white}) {
    return isReadOnly
        ? InputBorder.none
        : OutlineInputBorder(
            borderSide: BorderSide(color: color, width: 1),
            borderRadius: BorderRadius.circular(15),
          );
  }
}

// class PasswordDetailTextField extends StatelessWidget {
//   final String? initialValue;
//   final String? hintText;
//   bool isPassword;
//   bool obscureText;
//   final Widget? suffixIcon;
//   final bool isReadOnly;
//   final IconData? icon;

//   PasswordDetailTextField({
//     super.key,
//     this.initialValue,
//     this.hintText,
//     this.suffixIcon,
//     this.isPassword = false,
//     this.obscureText = false,
//     required this.isReadOnly,
//     this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     print("isReadOnly $isReadOnly");
//     return TextFormField(
//       readOnly: isReadOnly,
//       initialValue: initialValue,
//       obscureText: obscureText,
//       style: TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         enabled: !isReadOnly,
//         disabledBorder: null,
//         enabledBorder: isReadOnly == false 
//             ? OutlineInputBorder(
//                 borderSide:
//                     BorderSide(color: Colors.white, width: 2),
//                 borderRadius: BorderRadius.circular(15))
//             : null,
//         // border: isReadOnly == false 
//         //     ? OutlineInputBorder(
//         //         borderSide:
//         //             BorderSide(color: Colors.white, width: 2),
//         //         borderRadius: BorderRadius.circular(15))
//         //     : null,
//         focusedBorder: isReadOnly == false
//             ? OutlineInputBorder(
//                 borderSide:
//                     BorderSide(color: AppColors.scaffoldBackgroundColor, width: 2),
//                 borderRadius: BorderRadius.circular(15),
//               )
//             : null,
//         prefixIcon: icon != null
//             ? Icon(
//                 icon,
//                 color: Colors.white,
//               )
//             : null,
//         suffixIcon: suffixIcon,
//         hintText: hintText,
//         hintStyle: TextStyle(color: AppColors.subTextColor),
//         filled: false,
//       ),
//     );
//   }
// }
