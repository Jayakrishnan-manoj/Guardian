import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guardian/controller/auth_provider.dart';
import 'package:guardian/data/models/user_schema.dart';
import 'package:guardian/data/repositories/password_repository.dart';
import 'package:guardian/helpers/custom_dialog.dart';
import 'package:guardian/helpers/custom_toast.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/login_screen.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? profilePic;
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profilePic = AuthProvider().getProfilePic();
    print(profilePic);
  }

  @override
  Widget build(BuildContext context) {
    final passwordRepository = Provider.of<PasswordRepository>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(profilePic!),
              ),
              Gap(20),
              FutureBuilder(
                future: passwordRepository.getSavedUser(),
                builder: (context, user) {
                  return Text(
                    user.data.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
              Gap(20),
              ActionTile(
                tileName: "Edit Profile",
                action: () {
                  showCustomDialog(
                    context,
                    "Edit your name",
                    TextFormField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.blueAppColor, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          disabledBorder: InputBorder.none),
                    ),
                    [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  elevation: WidgetStatePropertyAll(0),
                                  shape: WidgetStatePropertyAll(
                                    StadiumBorder(),
                                  ),
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          Gap(10),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  elevation: WidgetStatePropertyAll(0),
                                  shape: WidgetStatePropertyAll(
                                    StadiumBorder(),
                                  ),
                                  backgroundColor: WidgetStatePropertyAll(
                                    AppColors.blueAppColor,
                                  ),
                                ),
                                onPressed: () async {
                                  await passwordRepository
                                      .updateUserName(1, nameController.text)
                                      .whenComplete(() {
                                    Navigator.of(context).pop();
                                    Toasts().showSuccessToast(
                                        context, "Profile updated");
                                  });
                                },
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              Gap(20),
              ActionTile(
                tileName: "Logout",
                action: () async {
                  await AuthProvider().signOut().then((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  });
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionTile extends StatelessWidget {
  final VoidCallback action;
  final String tileName;
  final Widget icon;
  const ActionTile({
    super.key,
    required this.action,
    required this.tileName,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        height: 70,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.tileColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tileName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            icon
          ],
        ),
      ),
    );
  }
}
