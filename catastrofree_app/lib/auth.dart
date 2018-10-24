import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class SignInWidget extends StatefulWidget{
  SignInWidget({Key key, this.title}): super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _SignInWidgetState();
  }
}

class _SignInWidgetState extends State <SignInWidget> {
  Future<String> _message = Future<String>.value("");
  Future<String> _testSignInAnon() async {
    final FirebaseUser user = await _auth.signInAnonymously();
    assert(user !=null);
    assert(user.isAnonymous);
    assert(!user.isEmailVerified);
    assert(await user.getIdToken() != null);
    if (Platform.isIOS){
      assert(user.providerData.isEmpty);
    }else if (Platform.isAndroid){
      assert(user.providerData.length == 1);
      assert(user.providerData[0].providerId == 'firebase');
      assert(user.providerData[0].uid != null);
      assert(user.providerData[0].displayName == null);
      assert(user.providerData[0].photoUrl == null);
      assert(user.providerData[0].email == null);
    }

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    return 'signInAnon succeeded: $user';
  }

  Future <String> _testSignInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    print("First");
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    print('Second');
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("Stage");
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    print("Sign in done");
    return 'signInWithGoogle succeeded: $user';
    
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        FlatButton(
          child: Text("Test Anon auth"),
          onPressed: () => _testSignInAnon().then((String str){
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(str),)
            );
          }),
        ),
        FlatButton(
          child: Text("Sign in with google"),
          onPressed: () => _testSignInWithGoogle().then((String str){
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(str),)
            );
          }),
        ),
      ],
      padding: EdgeInsets.all(10.0),
    );
  }
}