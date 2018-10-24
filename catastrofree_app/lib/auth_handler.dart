//import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

/* Future <void> getCurrentUser(StdUserAccountDrawerHeader header) async {
  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  if(currentUser != null)
  {
    
    return currentUser;
  }
  else {
    return null;
  }
} */

class StdUserAccountDrawerHeader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StdUserAccountDrawerHeaderState();
  }
}
class _StdUserAccountDrawerHeaderState extends State <StdUserAccountDrawerHeader> {
  Text accountName = Text(
    'Dummy Name',
    style: TextStyle(fontWeight: FontWeight.bold),
    );
  Text accountEmail = Text("DummyEmail@DumDum.com");
  Widget accountPic;
  Future <void> refresh () async{
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    if(currentUser != null){
      setState(() {
            accountEmail = Text(currentUser.email);
            accountName = Text(currentUser.displayName);
            accountPic = GestureDetector(
              child: CircleAvatar(
                  backgroundImage: NetworkImage(currentUser.photoUrl)));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    refresh();
    return UserAccountsDrawerHeader(
              accountName: accountName,
              accountEmail: accountEmail,
              currentAccountPicture: accountPic,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://t4.ftcdn.net/jpg/01/88/85/07/240_F_188850771_lWtSgpYaLn2PC2h8ZVhtqjVjlgp2U0M5.jpg'),
                )
              );
              //onDetailsPressed: () => signInDialog(context));
  }
}

Future <String> signInWithGoogle() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignInAccount googleUser = await GoogleSignIn(scopes: [
    "email",
    'https://www.googleapis.com/auth/userinfo.profile',
    'https://www.googleapis.com/auth/userinfo.email',
  ]).signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final FirebaseUser user = await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  assert(user.email != null);
  assert(user.displayName != null);
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);
  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  return null;
}

Future <Null> signInWithFacebook(){
  return null;
}

Future <Null> logout() async{
  await FirebaseAuth.instance.signOut();
}
Future <Null> signInDialog(BuildContext context) async {
  showDialog<FirebaseUser>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text("Select Authentication method"),
        children: <Widget>[
          SimpleDialogOption(
            child: const Text('Google Sign In'),
            onPressed: (){
              Navigator.of(context).pop();
              return signInWithGoogle();
            },
          ),
          SimpleDialogOption(
            child: const Text('Facebook Sign In'),
            onPressed: (){
              Navigator.of(context).pop();
              return signInWithFacebook();
            },
          ),
          SimpleDialogOption(
            child: const Text("Logout"),
            onPressed: logout,),
        ],
      );
    }
  );
}