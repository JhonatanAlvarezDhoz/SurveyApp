import 'package:flutter/material.dart';
import 'package:survey_app/themes/theme_colors.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ThemeColors.white,
        title: const Text("Opciones"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Perfil
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12), // Bordes redondeados
                child: Image.asset(
                  'assets/images/profile_image.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Jorge Zetien",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.verified, color: Colors.amber, size: 20),
                    ],
                  ),
                  Text("Mi Perfil >"),
                  Row(
                    children: [
                      Text("732", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(" siguiendo   "),
                      Text("15321", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(" Seguidores"),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Opciones del menú
          ListTile(
            iconColor: ThemeColors.primary,
            leading: const Icon(Icons.history),
            title: const Text('Historial'),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          ListTile(
            iconColor: ThemeColors.primary,
            leading: const Icon(Icons.collections),
            title: const Text('Encuestas'),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          ListTile(
            iconColor: ThemeColors.primary,
            leading: const Icon(Icons.favorite_border),
            title: const Text('Likes'),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          ListTile(
            iconColor: ThemeColors.primary,
            leading: const Icon(Icons.settings),
            title: const Text('Opciones'),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          ListTile(
            iconColor: ThemeColors.primary,
            leading: const Icon(Icons.share),
            title: const Text('Comparte esta App'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}