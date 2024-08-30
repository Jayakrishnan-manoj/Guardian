import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/constants/constants.dart';

import '../widgets/custom_formfield.dart';

class AddPasswordScreen extends StatefulWidget {
  const AddPasswordScreen({super.key});

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  Categories? selectedCategory;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool formFilled = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _updateFormState() {
    setState(() {
      formFilled = titleController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          selectedCategory != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Password",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.go("/");
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Form(
          key: _formKey,
          onChanged: _updateFormState,
          child: Column(
            children: [
              CustomFormField(
                hintText: "Title",
                controller: titleController,
              ),
              const Gap(15),
              CustomFormField(
                hintText: "Username(Optional)",
                controller: usernameController,
              ),
              const Gap(15),
              CustomFormField(
                hintText: "Password",
                controller: passwordController,
              ),
              const Gap(15),
              DropdownButton2<Categories>(
                underline: const SizedBox(
                  height: 5,
                ),
                hint: const Text(
                  "Select a Category",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                buttonStyleData: ButtonStyleData(
                  padding: const EdgeInsets.all(9),
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    color: tileColor,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    color: tileColor,
                  ),
                ),
                value: selectedCategory,
                onChanged: (Categories? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                items: Categories.values.map((Categories category) {
                  return DropdownMenuItem<Categories>(
                    value: category,
                    child: Text(
                      category.toString().split('.').last,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const Gap(30),
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: formFilled == false ? null : () {},
                  statesController: MaterialStatesController(),
                  icon: const Icon(Icons.check),
                  style: ElevatedButton.styleFrom(
                    //backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBackgroundColor: tileColor,
                    disabledForegroundColor: Colors.white70,
                  ),
                  label: Text(
                    "Add Password",
                    style: TextStyle(
                      color:
                          formFilled == false ? Colors.white70 : Colors.white,
                      fontSize: 18,
                    ),
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
