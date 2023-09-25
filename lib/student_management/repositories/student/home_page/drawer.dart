import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../authentication/login_signup/services/auth_provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // width: double.infinity,
              color: Colors.green,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                            'https://i.pinimg.com/736x/06/43/d9/0643d990c0edfab74356a12003e7b76b.jpg',
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "Self Stack",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      "selfstack@gmail.com",
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profiles"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Dark Theme"),
              trailing: Switch.adaptive(
                value: false,
                activeColor: Colors.grey,
                onChanged: (val) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Provider.of<AuthService>(context, listen: false).signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('login', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
