import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ActivationPage(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/factory2': (context) => DashboardFactory2(),
      },
    );
  }
}

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

class OTPConfirmationPage extends StatelessWidget {
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
              'Enter the activation code you received via SMS.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text('Activate'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    DashboardFactory1(),
    ProfilePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Factory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DashboardFactory1 extends StatefulWidget {
  @override
  _DashboardFactory1State createState() => _DashboardFactory1State();
}

class _DashboardFactory1State extends State<DashboardFactory1> {
  late Timer _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _currentTime = _getCurrentTime();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getCurrentTime() {
    return DateTime.now().toString().split('.')[0]; // Removes microseconds
  }

  void _updateTime() {
    setState(() {
      _currentTime = _getCurrentTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Amazing CSC Employee - Factory 1'),
      ),
      body: SingleChildScrollView(
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
                _buildGauge('Steam Pressure', 90),
                _buildGauge('Steam Flow', 80),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGauge('Water Level', 70),
                _buildGauge('Power Frequency', 60),
              ],
            ),
            SizedBox(height: 10),
            Text(_currentTime),
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

  Widget _buildGauge(String title, double value) {
    return Column(
      children: [
        Text(title),
        SizedBox(
          height: 150,
          width: 150,
          child: SfLinearGauge(
            ranges: [
              LinearGaugeRange(
                startValue: 0,
                endValue: 50,
                color: Colors.green,
              ),
              LinearGaugeRange(
                startValue: 50,
                endValue: 100,
                color: Colors.orange,
              ),
              LinearGaugeRange(
                startValue: 100,
                endValue: 150,
                color: Colors.red,
              ),
            ],
            markerPointers: [
              LinearShapePointer(
                value: value,
              ),
            ],
            barPointers: [LinearBarPointer(value: value)],
          ),
        ),
      ],
    );
  }
}

class DashboardFactory2 extends StatefulWidget {
  @override
  _DashboardFactory2State createState() => _DashboardFactory2State();
}

class _DashboardFactory2State extends State<DashboardFactory2> {
  late Timer _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _currentTime = _getCurrentTime();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getCurrentTime() {
    return DateTime.now().toString().split('.')[0]; // Removes microseconds
  }

  void _updateTime() {
    setState(() {
      _currentTime = _getCurrentTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Amazing CSC Employee - Factory 2'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Factory 2',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGauge('Steam Pressure', 60),
                _buildGauge('Steam Flow', 70),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGauge('Water Level', 80),
                _buildGauge('Power Frequency', 90),
              ],
            ),
            SizedBox(height: 10),
            Text(_currentTime),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go to Factory 1'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGauge(String title, double value) {
    return Column(
      children: [
        Text(title),
        SizedBox(
          height: 150,
          width: 150,
          child: SfLinearGauge(
            ranges: [
              LinearGaugeRange(
                startValue: 0,
                endValue: 50,
                color: Colors.green,
              ),
              LinearGaugeRange(
                startValue: 50,
                endValue: 100,
                color: Colors.orange,
              ),
              LinearGaugeRange(
                startValue: 100,
                endValue: 150,
                color: Colors.red,
              ),
            ],
            markerPointers: [
              LinearShapePointer(
                value: value,
              ),
            ],
            barPointers: [LinearBarPointer(value: value)],
          ),
        ),
      ],
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map<String, String>> _engineers = [
    {'name': 'Ben', 'phone': '+60109219938'},
    {'name': 'Testing 1', 'phone': '+601234567891'},
    {'name': 'Hello', 'phone': '+60123456789'},
  ];

  void _addEngineer(Map<String, String> engineer) {
    setState(() {
      _engineers.add(engineer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Factory 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _engineers.length,
                itemBuilder: (context, index) {
                  final engineer = _engineers[index];
                  return Card(
                    child: ListTile(
                      title: Text(engineer['name']!),
                      subtitle: Text(engineer['phone']!),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvitationPage(),
                    ),
                  );
                  if (result != null) {
                    _addEngineer(result);
                  }
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
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

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Minimum Threshold',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildThreshold('Steam Pressure', 'bar', 29),
                  _buildThreshold('Steam Flow', 'T/H', 22),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildThreshold('Water Level', '%', 53),
                  _buildThreshold('Power Frequency', 'Hz', 48),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThreshold(String title, String unit, double value) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                value.toString(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(unit, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}

class InvitationPage extends StatefulWidget {
  @override
  _InvitationPageState createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invitation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invite users',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Owner\'s Name',
                  hintText: 'Type here',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the owner\'s name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Owner\'s Phone Number',
                  hintText: 'Enter your phone number',
                  prefixText: '+60 ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context, {
                        'name': _nameController.text,
                        'phone': '+60' + _phoneController.text,
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
