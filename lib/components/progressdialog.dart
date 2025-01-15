// Flutter imports:
import 'package:finitepay/views/authenication/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
// import 'package:pre_eclampsia_app/views/authentication/login.dart';
// import 'package:night_nurse/components/logo_state_change.dart';
// import 'package:night_nurse/views/authentication/loginpage.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

// Project imports:

class ProgressDialog extends StatelessWidget {
  final String status;
  const ProgressDialog({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                status,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showUpDismissible(context, String mess, String message) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        title: Text(mess),
        content: Text(message),
      );
    },
  );
}

Future<void> showUpUnDismissible(context, String message, String message1) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(message),
        content: Text(message1),
      );
    },
  );
}

Future<void> signIn(context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Center(
          child: Text(
            'Sign In',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        content: const SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LogoStateChange(),
              Text('To make any action, you need to sign in below'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('not now'.toUpperCase()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('sign in'.toUpperCase()),
            onPressed: () async {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false);
            },
          ),
        ],
      );
    },
  );
}

Future<void> signInPremeum(context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Center(
          child: Text(
            'Sign In',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        content: const SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LogoStateChange(),
              Text('To watch this content, you need to sign in below'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('not now'.toUpperCase()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('sign in'.toUpperCase()),
            onPressed: () async {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false);
            },
          ),
        ],
      );
    },
  );
}

Future<void> notMonitised(context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        title: const Center(
          child: Text(
            'You are not yet monitized',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        content: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LogoStateChange(),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        text:
                            "Your account has not been monitized, learn more on the eligibility criteria and how to monitize your content. "),
                    TextSpan(
                      text: " Learn more",
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          customLaunch(
                              "https://monetizationpolicy.yafreeka.com/"); //link to docs
                        },
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> checkEmail(context, String message, String message1) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(message),
        content: Text(message1),
        actions: [
          TextButton(
            child: Text('ok'.toUpperCase()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void customLaunch(command) async {
  var url = Uri.parse(command);
  // if (await canLaunchUrl(url)) {
  await launchUrl(url);
  // } else {
  //   throw 'Could not launch $url';
  // }
}
