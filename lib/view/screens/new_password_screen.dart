// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final FocusNode titleFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode websiteFocus = FocusNode();
  final FocusNode noteFocus = FocusNode();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  DatabaseService _databaseService = DatabaseService();

  Categories? selectedCategory;
  String connectedAccount = "";

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  EncryptionService _encryptionService = EncryptionService();

  late PasswordRepository _passwordRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordRepository = Provider.of<PasswordRepository>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add New Password",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.tileColor,
                    radius: 30,
                    child: _image == null
                        ? IconButton(
                            onPressed: () {
                              pickImage();
                            },
                            icon: Icon(Icons.add_photo_alternate_rounded),
                          )
                        : GestureDetector(
                            onTap: () {
                              pickImage();
                            },
                            child: ClipOval(
                              child: Image.file(
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                File(_image!.path),
                              ),
                            ),
                          ),
                  ),
                  Gap(15),
                  Expanded(
                    child: CustomInputTextField(
                      hintText: "Add a title",
                      focusNode: titleFocus,
                      textEditingController: titleController,
                    ),
                  ),
                ],
              ),
              Gap(20),
              const Text(
                "Username/email address",
                style: TextStyle(color: AppColors.subTextColor),
              ),
              Gap(10),
              CustomInputTextField(
                focusNode: usernameFocus,
                textEditingController: usernameController,
              ),
              Gap(20),
              const Text(
                "Password",
                style: TextStyle(color: AppColors.subTextColor),
              ),
              Gap(10),
              CustomInputTextField(
                focusNode: passwordFocus,
                isPassword: true,
                textEditingController: passwordController,
              ),
              Gap(20),
              Text(
                "Category",
                style: TextStyle(color: AppColors.subTextColor),
              ),
              Gap(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Categories.values.map((Categories category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(8),
                        label: Text(
                          category.toString().substring(11),
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: selectedCategory == category,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        backgroundColor: AppColors.tileColor,
                        selectedColor: AppColors.greenAppColor,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Gap(20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.tileColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Details",
                        style: TextStyle(
                          color: AppColors.greenAppColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Gap(15),
                      const Text(
                        "Website Address",
                        style: TextStyle(color: AppColors.subTextColor),
                      ),
                      const Gap(10),
                      CustomInputTextField(
                        focusNode: websiteFocus,
                        isDetails: true,
                        textEditingController: websiteController,
                      ),
                      Gap(20),
                      const Text(
                        "Note",
                        style: TextStyle(color: AppColors.subTextColor),
                      ),
                      const Gap(10),
                      CustomInputTextField(
                        focusNode: noteFocus,
                        isDetails: true,
                        textEditingController: noteController,
                      ),
                      Gap(20),
                      const Text(
                        "Connected Account",
                        style: TextStyle(color: AppColors.subTextColor),
                      ),
                      const Gap(10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: connectedAccountsList.map((String account) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ChoiceChip(
                                padding: EdgeInsets.all(8),
                                elevation: 0,
                                label: Text(
                                  account,
                                  style: TextStyle(color: Colors.white),
                                ),
                                selected: connectedAccount == account,
                                onSelected: (bool selected) {
                                  setState(() {
                                    connectedAccount = account;
                                  });
                                },
                                backgroundColor:
                                    AppColors.scaffoldBackgroundColor,
                                selectedColor: AppColors.greenAppColor,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(25),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    elevation: WidgetStatePropertyAll(0),
                    shape: WidgetStatePropertyAll(
                      StadiumBorder(),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.greenAppColor,
                    ),
                  ),
                  onPressed: () async {
                    if (titleController.text.isEmpty) {
                      Toasts().showErrorToast(context, "Please enter a title");
                    } else if (passwordController.text.isEmpty) {
                      Toasts()
                          .showErrorToast(context, "Please enter a password");
                    } else {
                      String encrypt = _encryptionService
                          .encryptPassword(passwordController.text);
                      Password newEntry = Password()
                        ..title = titleController.text
                        ..username = usernameController.text
                        ..category =
                            selectedCategory ?? Categories.miscellaneous
                        ..note = noteController.text
                        ..connectedAccount = connectedAccount
                        ..createdAt = DateTime.now()
                        ..lastModified = DateTime.now()
                        ..imagePath = _image?.path
                        ..websiteAddress = websiteController.text
                        ..encryptedPassword = encrypt;

                      try {
                        await _passwordRepository.savePassword(newEntry);
                        Toasts().showSuccessToast(
                            context, "Password saved successfully");

                        Navigator.pop(context);
                      } catch (e) {
                        Toasts()
                            .showErrorToast(context, "Error saving password");
                        print(e.toString());
                      }
                      // print(encrypt);
                      // print(_encryptionService.decryptPassword(encrypt));
                      // print(titleController.text);
                      // print(usernameController.text);
                      // //print(passwordController.text);
                      // print(selectedCategory.toString());
                      // print(websiteController.text);
                      // print(noteController.text);
                      // print(connectedAccount);
                    }

                    //Navigator.pop(context);
                  },
                  child: const Text(
                    "Save Password",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
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

class CustomInputTextField extends StatelessWidget {
  const CustomInputTextField({
    super.key,
    required this.focusNode,
    this.isPassword = false,
    this.isDetails = false,
    required this.textEditingController,
    this.hintText = "",
  });

  final FocusNode focusNode;
  final bool isPassword;
  final bool isDetails;
  final TextEditingController textEditingController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: isPassword,
      focusNode: focusNode,
      onTapOutside: (_) {
        focusNode.unfocus();
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greenAppColor, width: 2),
            borderRadius: BorderRadius.circular(15)),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.subTextColor),
        filled: true,
        fillColor:
            isDetails ? AppColors.scaffoldBackgroundColor : AppColors.tileColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
