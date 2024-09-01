import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:seedscan2/pages/homePage.dart';

class AuthenticateBiometric extends StatefulWidget {
  const AuthenticateBiometric({super.key});

  @override
  State<AuthenticateBiometric> createState() => _AuthenticateBiometricState();
}

class _AuthenticateBiometricState extends State<AuthenticateBiometric> {
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() {
            _supportState = isSupported;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: const Color.fromARGB(255, 191, 255, 139), // Change background color here
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Text(
            'SeedScan',
            style: TextStyle(
              fontSize: 40, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Adjust the font weight as needed
              fontStyle: FontStyle.italic, // Adjust the font style as needed
              fontFamily:
                  'YourFontFamily', // Replace 'YourFontFamily' with your desired font family
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Image.asset(
              'assets/images/fingerPrintPerson.gif',
              width: 300,
              height: 300,
            ),
          ),
          if (_supportState)
            const Text("This App is Protected with Biometric Authentication")
          else
            const Text('Device is not Supported'),

          //ElevatedButton(
          //onPressed: _getAvailableBiometrics,
          //child: const Text('Get Available Biometrics'),
          //),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: _authenticate,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Color.fromARGB(255, 99, 201, 102), // Change button color here
            ),
            child: Text('Authenticate'),
          )
        ])));
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Unlock with your biometrics to continue.',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      print("Authenticated : $authenticated");
      if (authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //Future<void> _getAvailableBiometrics() async {
  ///List<BiometricType> availableBiometrics =
  //await auth.getAvailableBiometrics();

  // print("List of AvailableBiometrics : $availableBiometrics");

  //if(!mounted){
  // return;
  //}
  // }
}
