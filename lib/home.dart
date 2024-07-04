import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'query_list_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disaster Management App'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('About'),
                      onTap: () {
                        Navigator.pop(context);
                        // Handle About action
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('Helpline'),
                      onTap: () {
                        Navigator.pop(context);
                        // Handle Helpline action
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.login),
                        title: const Text('Login'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.app_registration),
                        title: const Text('Sign Up'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
                        },
                      ),
                      
                      ListTile(
                        leading: const Icon(Icons.question_answer),
                        title: const Text('View Queries'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const QueryListPage()));
                        },
                      ),

                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusCard(),
            SizedBox(height: 16.0),
            WarningCard(),
            SizedBox(height: 16.0),
            DisasterGuide(),
            SizedBox(height: 16.0),
            WeatherForecast(),
          ],
        ),
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Everything looks normal. Have a great day!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 8.0),
                Text('Nakuru, Kenya'),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WarningCard extends StatelessWidget {
  const WarningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.yellow[700],
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                '10 minutes ago there was an earthquake in Nakuru. 30 Km near your location. Stay Safe!',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DisasterGuide extends StatelessWidget {
  const DisasterGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Disaster Guide',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: const [
                DisasterGuideItem(
                  icon: Icons.error,
                  label: 'Earthquake',
                ),
                DisasterGuideItem(
                  icon: Icons.local_fire_department,
                  label: 'Fire',
                ),
                DisasterGuideItem(
                  icon: Icons.air,
                  label: 'Strong Winds',
                ),
                DisasterGuideItem(
                  icon: Icons.water,
                  label: 'Floods',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DisasterGuideItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const DisasterGuideItem({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.black),
        const SizedBox(height: 8.0),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weather Forecast (February 4, 2024)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherForecastItem(
                  location: 'Nakuru',
                  time: '08:00 AM',
                ),
                WeatherForecastItem(
                  location: 'Nairobi',
                  time: '08:00 AM',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherForecastItem extends StatelessWidget {
  final String location;
  final String time;

  const WeatherForecastItem({
    required this.location,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(location, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4.0),
        Text(time, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
