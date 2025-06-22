import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key}); // ✅ Add const constructor

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = true;
  bool _badges = true;
  bool _birthdayNotifications = true;
  bool _connections = true;
  bool _findByPhone = true;
  bool _notifications = true;
  bool _messageSound = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Settings', style: TextStyle(color: Colors.purpleAccent)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Theme',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purpleAccent,
            ),
          ),
          const SizedBox(height: 10),
          _buildSettingSwitch('Dark Mode', _darkMode, (value) => setState(() => _darkMode = value)),
          _buildSettingSwitch('Badges', _badges, (value) => setState(() => _badges = value)),
          _buildSettingSwitch('Birthday notifications', _birthdayNotifications, 
              (value) => setState(() => _birthdayNotifications = value)),
          _buildSettingSwitch('Connections', _connections, 
              (value) => setState(() => _connections = value)),
          _buildSettingSwitch('Find me by phone number', _findByPhone, 
              (value) => setState(() => _findByPhone = value)),
          _buildSettingSwitch('Notifications', _notifications, 
              (value) => setState(() => _notifications = value)),
          _buildSettingSwitch('Message sound', _messageSound, 
              (value) => setState(() => _messageSound = value)),
          const SizedBox(height: 30),
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purpleAccent,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            title: const Text(
              'Log out',
              style: TextStyle(color: Colors.purpleAccent),
            ),
            trailing: const Icon(Icons.arrow_forward, color: Colors.purpleAccent),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSwitch(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.purpleAccent,
            activeTrackColor: Colors.purpleAccent.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}