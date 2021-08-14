import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/users/controllers/user_controller.dart';
import 'package:kst_inventory/utils/dialog.dart';

class UserView extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    final user = controller.userList;

    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                    //key: controller.userFormKey,
                   // autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        textInput(
                          secure: false,
                          text: 'Username',
                          controller: controller.username!,
                          onSaved: (value) =>
                              controller.username!.text = value!,
                          validator: (value) =>
                              controller.validateUsername(value!),
                        ),
                        textInput(
                            secure: true,
                            text: 'Password',
                            controller: controller.password!,
                            onSaved: (value) =>
                                controller.password!.text = value!,
                            validator: (value) =>
                                controller.validatePassword(value!)),
                        textInput(
                          secure: false,
                          text: 'Display Name',
                          controller: controller.displayName!,
                          onSaved: (value) =>
                              controller.displayName!.text = value!,
                          validator: (value) =>
                              controller.validateDisplayName(value!),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 15,
                ),
                _saveButton(context),
                SizedBox(
                  height: 20,
                ),
                Text('List user'),
                Divider(),
                Expanded(
                  child: Obx(() {
                    if (user.length == 0) {
                      return CircularProgressIndicator();
                    }
                    return SingleChildScrollView(
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('No')),
                          DataColumn(label: Text('Username')),
                          DataColumn(label: Text('Display Name')),
                          DataColumn(label: Text('Option')),
                        ],
                        rows: List.generate(user.length, (index) {
                          return DataRow(cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text('${user[index].username}')),
                            DataCell(Text('Admin')),
                            DataCell(Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                  child: Text('Reset Password',
                                      style: TextStyle(color: Colors.blue)),
                                  onPressed: () {
                                    _dialogUpdate(
                                        context, user[index].username);
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    Dialogs(
                                            context: context,
                                            message: 'Do you want to delete?')
                                        .optionDialog(
                                      onPress: () {
                                        controller
                                            .deleteUser(
                                                username: user[index].username,
                                                context: context)
                                            .then((value) {});
                                      },
                                    );
                                  },
                                ),
                              ],
                            )),
                          ]);
                        }),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  textInput({
    required String text,
    required TextEditingController controller,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    required bool secure,
  }) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    );
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 20),
      child: Row(
        children: [
          Container(
            width: 100,
            child: Text('$text:'),
          ),
          Container(
            width: 300,
            child: TextFormField(
              obscureText: secure,
              controller: controller,
              decoration: InputDecoration(
                isDense: true,
                border: border,
                focusedBorder: border,
              ),
              onSaved: onSaved,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }

  _saveButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 350),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
        ),
        child: Text('Save'),
        onPressed: () {
          controller.insertData(context);
        },
      ),
    );
  }

  void _dialogUpdate(BuildContext context, String username) {
    controller.username!.text = username;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reset Password'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // textInput(text: 'Username', controller: controller.username!),
                // textInput(
                //     text: 'Old Password', controller: controller.username!),
                // textInput(
                //     text: 'New Password', controller: controller.username!),
                // textInput(
                //     text: 'Retry Password', controller: controller.username!),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel')),
            TextButton(onPressed: () {}, child: Text('OK')),
          ],
        );
      },
    );
  }
}
