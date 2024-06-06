import 'package:flutter/material.dart';
import 'OTPConfirmationPage.dart';

class ActivationPage extends StatefulWidget {
  @override
  _ActivationPageState createState() => _ActivationPageState();
}

class _ActivationPageState extends State<ActivationPage> {
  bool _agreedToTOS = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your mobile number to activate your account.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.flag),
                hintText: '+60',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTOS = value!;
                    });
                  },
                ),
                Text('I agree to the terms & conditions')
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _agreedToTOS
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTPConfirmationPage()),
                        );
                      }
                    : null,
                child: Text('Get Activation Code'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
