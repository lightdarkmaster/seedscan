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
            Card(
              elevation: 5, // Adds shadow to the card
              color: Colors.grey[200], // Light grey background color
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Adds padding inside the card
                child: const Text(
                  "This App is Protected with Biometric Authentication",
                  style: TextStyle(
                    fontSize: 16, // Adjust text size
                    fontWeight: FontWeight.w300,
                    color: Colors.black, // Sets text color
                  ),
                  textAlign: TextAlign.center, // Center-align the text
                ),
              ),
            )
          else
            const Text('Device is not Supported'),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: _authenticate,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Color.fromARGB(255, 99, 201, 102), // Change button color here
            ),
            child: Text('Authenticate'),
          ),
        ],
      ),
    ),
  );
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
