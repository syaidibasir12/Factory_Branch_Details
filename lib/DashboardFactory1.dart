import 'package:flutter/material.dart';

class DashboardFactory1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Amazing CSC Employee - Factory 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Factory 1',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImage('images/ihdin.jpg', 'Ihdin'),
                _buildImage('images/zarif.jpg', 'Zarif'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImage('images/nips.jpg', 'Munip'),
                _buildImage('images/riz.jpg', 'Hariz'),
              ],
            ),
            SizedBox(height: 10),
            Text('2024-04-26 13:45:25'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/factory2');
              },
              child: Text('Go to Factory 2'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath, String title) {
    return Column(
      children: [
        Text(title),
        SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ],
    );
  }
}