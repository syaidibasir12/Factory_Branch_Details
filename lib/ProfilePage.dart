import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Factory 1 Employees',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildEmployeeInfo('Employee Name: John Doe', 'Phone Number: +1234567890'),
            SizedBox(height: 10),
            _buildEmployeeInfo('Employee Name: Jane Smith', 'Phone Number: +0987654321'),
            SizedBox(height: 10),
            _buildEmployeeInfo('Employee Name: Bob Johnson', 'Phone Number: +1122334455'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Factory2EmployeesPage()),
                );
              },
              child: Text('Go to Factory 2 Employees'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeInfo(String name, String phone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 18),
        ),
        Text(
          phone,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class Factory2EmployeesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Factory 2 Employees'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Factory 2 Employees',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildEmployeeInfo('Employee Name: Alice Brown', 'Phone Number: +1231231234'),
            SizedBox(height: 10),
            _buildEmployeeInfo('Employee Name: Charlie Davis', 'Phone Number: +3213214321'),
            SizedBox(height: 10),
            _buildEmployeeInfo('Employee Name: Eve Foster', 'Phone Number: +4564564567'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Factory 1 Employees'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeInfo(String name, String phone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 18),
        ),
        Text(
          phone,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
