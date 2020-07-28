import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/models/provider/firebase_provider.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class YourScreen extends StatefulWidget {
  @override
  _YourScreenState createState() => _YourScreenState();
}

class _YourScreenState extends State<YourScreen> {
  var userNameController = TextEditingController(text: 'user name');
  var emailController = TextEditingController(text: 'email');
  var passwordController = TextEditingController(text: 'password');
  var genderController = TextEditingController(text: 'gender');

  bool editMode = false;
  @override
  void initState() {
    super.initState();
    var bloc = Provider.of<FirebaseProvider>(context, listen: false);
    //bloc.getInstance();
    readUserData(bloc);
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<FirebaseProvider>(context, listen: false);
    return Scaffold(
      appBar: MyAppBar.getAppBar(context, AppBarStatus.Your, ''),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Yours',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text('Browse what you want from the menu below'),
            // trailing: IconButton(
            //   icon: Icon(Icons.mode_edit),
            //   onPressed: () {
            //     setState(() {
            //       editMode = !editMode;
            //     });
            //     print(editMode);
            //   },
            // ),
          ),
          Expanded(
            child: AnimationLimiter(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        userNameController.text,
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        final txt = userNameController;
                        print('*******************************');
                        var alert = Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: AlertDialog(
                              title: EditableText(
                                backgroundCursorColor: Colors.redAccent,
                                autofocus: true,
                                maxLines: 1,
                                controller: txt,
                                cursorColor: Colors.redAccent,
                                focusNode: FocusNode(canRequestFocus: true),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                // readOnly: true,
                                onChanged: (String str) {
                                  print(str);
                                },
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('Cancel'),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    userNameController.text = txt.text;
                                    var u = bloc.user;
                                    u.name = txt.text;
                                    bloc.updateUser(u);
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('Ok'),
                                )
                              ],
                            ));
                        showDialog(
                          context: context,
                          child: alert,
                        );
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.email),
                      title: Text(
                        emailController.text,
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        final txt = emailController;
                        print('*******************************');
                        var alert = Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: AlertDialog(
                              title: EditableText(
                                backgroundCursorColor: Colors.redAccent,
                                autofocus: true,
                                maxLines: 1,
                                controller: txt,
                                cursorColor: Colors.redAccent,
                                focusNode: FocusNode(canRequestFocus: true),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                // readOnly: true,
                                onChanged: (String str) {
                                  print(str);
                                },
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('Cancel'),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    if (validateEmail(txt.text)) {
                                      emailController.text = txt.text;
                                      // var u = bloc.user;
                                      // u.email = txt.text;
                                      bloc.updateEmail(txt.text);
                                      Navigator.of(context).pop(true);
                                    }
                                  },
                                  child: Text('Ok'),
                                )
                              ],
                            ));
                        showDialog(
                          context: context,
                          child: alert,
                        );
                      },
                    ),
                  ),

                  // Card(
                  //   child: ListTile(
                  //     title: EditableText(
                  //       backgroundCursorColor: Colors.redAccent,
                  //       controller: passwordController,
                  //       cursorColor: Colors.redAccent,
                  //       focusNode: FocusNode(canRequestFocus: true),
                  //       style: TextStyle(
                  //         fontSize: 20,
                  //         color: Colors.black,
                  //       ),
                  //       readOnly: true,
                  //       obscureText: true,
                  //     ),
                  //     onTap: () {
                  //       final txt = passwordController;
                  //       print('*******************************${txt.text}');
                  //       var alert = Container(
                  //           height: MediaQuery.of(context).size.height * 0.2,
                  //           child: AlertDialog(
                  //             title: EditableText(
                  //               backgroundCursorColor: Colors.redAccent,
                  //               autofocus: true,
                  //               maxLines: 1,
                  //               controller: txt,
                  //               cursorColor: Colors.redAccent,
                  //               focusNode: FocusNode(canRequestFocus: true),
                  //               style: TextStyle(
                  //                 fontSize: 20,
                  //                 color: Colors.black,
                  //               ),
                  //               // readOnly: true,
                  //               onChanged: (String str) {
                  //                 print(str);
                  //               },
                  //             ),
                  //             actions: <Widget>[
                  //               FlatButton(
                  //                 onPressed: () {
                  //                   Navigator.of(context).pop(false);
                  //                 },
                  //                 child: Text('Cancel'),
                  //               ),
                  //               FlatButton(
                  //                 onPressed: () {
                  //                   if (validatePassword(txt.text)) {
                  //                     passwordController.text = txt.text;
                  //                     // var u = bloc.user;
                  //                     // u.name = txt.text;
                  //                     bloc.updatePwd(txt.text);
                  //                     Navigator.of(context).pop(true);
                  //                   }
                  //                 },
                  //                 child: Text('Ok'),
                  //               )
                  //             ],
                  //           ));
                  //       showDialog(
                  //         context: context,
                  //         child: alert,
                  //       );
                  //     },
                  //   ),
                  // ),

                  InkWell(
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.merge_type),
                        title: Text(
                          genderController.text,
                          textAlign: TextAlign.center,
                        ),
                        // onTap: () {

                        // },
                      ),
                    ),
                    onTap: () {
                      CupertinoActionSheet cupertinoActionSheet =
                          CupertinoActionSheet(
                        title: Text("Select Your Gender"),
                        //message: Text("Select any action "),
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            child: Text("Male"),
                            isDefaultAction: true,
                            onPressed: () {
                              setState(() {
                                genderController.text = 'male';
                              });
                              var usr = bloc.user;
                              bloc.updateUser(User(
                                name: userNameController.text,
                                avatar: usr.avatar,
                                gender: 'male',
                                email: emailController.text,
                              ));
                              print("Male is been clicked");
                              Navigator.of(context).pop(true);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: Text("Female"),
                            isDestructiveAction: true,
                            onPressed: () {
                              setState(() {
                                genderController.text = 'female';
                              });
                              var usr = bloc.user;
                              bloc.updateUser(User(
                                name: userNameController.text,
                                avatar: usr.avatar,
                                gender: 'female',
                                email: emailController.text,
                              ));
                              print("Female is been clicked");
                              Navigator.of(context).pop(true);
                            },
                          )
                        ],
                      );

                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              cupertinoActionSheet //action is final variable name
                          );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getGrid() {
    return AnimationLimiter(
      child: ListView(
        children: [
          getUserName(),
          ListTile(
            trailing: IconButton(
              icon: Icon(Icons.edit_attributes),
              onPressed: () {},
            ),
            title: EditableText(
              backgroundCursorColor: Colors.redAccent,
              controller: emailController,
              cursorColor: Colors.redAccent,
              focusNode: FocusNode(canRequestFocus: true),
              style: TextStyle(fontSize: 20, color: Colors.black),
              keyboardType: TextInputType.emailAddress,
              readOnly: true,
            ),
            // onTap: () {},
          ),
          ListTile(
            trailing: IconButton(
              icon: Icon(Icons.edit_attributes),
              onPressed: () {},
            ),
            title: EditableText(
              backgroundCursorColor: Colors.redAccent,
              controller: passwordController,
              cursorColor: Colors.redAccent,
              focusNode: FocusNode(canRequestFocus: true),
              style: TextStyle(fontSize: 20, color: Colors.black),
              readOnly: true,
              obscureText: true,
            ),
            // onTap: () {},
          ),
          ListTile(
            trailing: IconButton(
              icon: Icon(Icons.edit_attributes),
              onPressed: () {},
            ),
            title: EditableText(
              backgroundCursorColor: Colors.redAccent,
              controller: genderController,
              cursorColor: Colors.redAccent,
              focusNode: FocusNode(canRequestFocus: true),
              style: TextStyle(fontSize: 20, color: Colors.black),
              readOnly: true,
            ),
            // onTap: () {},
          ),
        ],
      ),
    );
  }

  Future<void> readUserData(FirebaseProvider bloc) async {
    //var usr = await FirebaseAuth.instance.currentUser();
    emailController.text = bloc.user.email;
    //passwordController.text = ;
    genderController.text = bloc.user.gender;
    userNameController.text = bloc.user.name;
  }

  Widget getUserName() {
    return ListTile(
      // trailing: IconButton(
      //   icon: !userNameEditMode
      //       ? Icon(Icons.edit_attributes)
      //       : Icon(
      //           Icons.edit_attributes,
      //           color: Colors.lightBlue,
      //         ),
      //   onPressed: () {
      //     setState(() {
      //       print(userNameEditMode);
      //       userNameEditMode = !userNameEditMode;
      //     });
      //   },
      // ),
      title: EditableText(
        backgroundCursorColor: Colors.redAccent,
        controller: userNameController,
        cursorColor: Colors.redAccent,
        focusNode: FocusNode(canRequestFocus: false),
        style: TextStyle(fontSize: 20, color: Colors.black),
        readOnly: !editMode,
        onChanged: (String str) {
          userNameController.text = str;
        },
      ),
      // onTap: () {},
    );
  }

  bool validateEmail(String text) {
    return true;
  }

  bool validatePassword(String text) {
    return true;
  }
}
