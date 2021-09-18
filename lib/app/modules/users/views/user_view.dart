import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/users/controllers/user_controller.dart';
import 'package:kst_inventory/models/user_model.dart';
import 'package:kst_inventory/utils/constants.dart';
import 'package:kst_inventory/utils/dialog.dart';

class UserView extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          backgroundColor: Appearance.backGroundColor,
          body: Container(
            padding: EdgeInsets.all(20),
            color: Appearance.backGroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                              child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'New User',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    textInput(
                                      secure: false,
                                      text: 'Username',
                                      hint: 'Required data',
                                      controller: controller.username!,
                                      onSaved: (value) =>
                                          controller.username!.text = value!,
                                      validator: (value) =>
                                          controller.validateUsername(value!),
                                    ),
                                    textInput(
                                        secure: true,
                                        text: 'Password',
                                        hint: 'Required data',
                                        controller: controller.password!,
                                        onSaved: (value) =>
                                            controller.password!.text = value!,
                                        validator: (value) => controller
                                            .validatePassword(value!)),
                                    textInput(
                                      secure: false,
                                      text: 'Display Name',
                                      hint: 'Required data',
                                      controller: controller.displayName!,
                                      onSaved: (value) =>
                                          controller.displayName!.text = value!,
                                      validator: (value) => controller
                                          .validateDisplayName(value!),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        _saveButton(context),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'List User',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Divider(),
                          Expanded(
                            child: Obx(() {
                              if (controller.listUser.length == 0) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Loading...'),
                                  ],
                                );
                              }
                              return Container(
                                child: SingleChildScrollView(
                                  child: DataTable(
                                    headingTextStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    showBottomBorder: true,
                                    columns: getColumns(
                                        column: controller.userColumn),
                                    rows: getRows(
                                        context: context,
                                        listUser: controller.listUser),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
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
    String? hint,
  }) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    );
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 150,
            child: Text(
              '$text:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 500,
            child: TextFormField(
              obscureText: secure,
              controller: controller,
              decoration: InputDecoration(
                isDense: true,
                border: border,
                focusedBorder: border,
                hintText: hint,
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
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.all(20),
          ),
          backgroundColor: MaterialStateProperty.all(Appearance.appBarColor),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Text('New User'),
        onPressed: () {
          controller.insertData(context);
        },
      ),
    );
  }

  void _dialogUpdate({required BuildContext context, required User user}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 800,
            height: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Update User',
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.redAccent,
                        ),
                        tooltip: 'Close',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textInput(
                            text: 'Display Name',
                            controller: controller.displayNameController,
                            secure: false,
                            hint: 'Display Name'),
                        textInput(
                            text: 'Password',
                            controller: controller.passwordController,
                            secure: true,
                            hint: 'Password'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  controller.updateUserData();
                },
                child: Text('OK')),
          ],
        );
      },
    );
  }

  List<DataColumn> getColumns({required List<String> column}) =>
      column.map((data) => DataColumn(label: Text(data))).toList();

  List<DataRow> getRows(
          {required RxList<User> listUser, required BuildContext context}) =>
      listUser.map((user) {
        int index = listUser.indexOf(user);
        return DataRow(cells: [
          DataCell(Text('${index + 1}')),
          DataCell(VerticalDivider()),
          DataCell(Text('${user.username}')),
          DataCell(VerticalDivider()),
          DataCell(Text('${user.surname}')),
          DataCell(VerticalDivider()),
          DataCell(Text('${user.createDate}')),
          DataCell(VerticalDivider()),
          DataCell(Text('${user.lastUpdate}')),
          DataCell(VerticalDivider()),
          DataCell(Row(
            children: [
              TextButton(
                  onPressed: () {
                    controller.usernameController = user.username;
                    controller.displayNameController.text = user.surname!;
                    _dialogUpdate(context: context, user: user);
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.amber),
                  )),
              TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Warning'),
                        content: Text('Do you want to delete this user?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel')),
                          TextButton(
                              onPressed: () {
                                controller.deleteUser(
                                    username: user.username.toString());
                              },
                              child: Text('OK')),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.redAccent),
                  )),
            ],
          )),
        ]);
      }).toList();
}
