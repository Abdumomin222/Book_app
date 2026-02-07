import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/repository/repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;
  final AppRepository _repository = AppRepository();

  Map<String, dynamic>? profile;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    profile = await _repository.getProfile();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header Section
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF26B6C),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Top Bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'UniNeue',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Edit action
                          },
                          child: Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Profile Image and Name
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 30),
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          profile?['username'] ?? 'Unknown',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'UniNeue',
                            fontWeight: FontWeight.w600,
                            // nimaga ko'rinmayapti text
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Settings List
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildInfoTile(label: 'User Name', value: profile?['username'] ?? 'Unknown'),
                SizedBox(height: 8),
                Divider(height: 1, color: Color(0xFFF2F2F2)),
                SizedBox(height: 8),
                _buildInfoTile(
                  label: 'Email',
                  value: profile?['email'] ?? 'Unknown',
                ),
                Divider(height: 1, color: Color(0xFFF2F2F2)),
                SizedBox(height: 8),
                _buildActionTile(
                  label: 'Change Password',
                  icon: Icons.chevron_right,
                  onTap: () {
                    // Navigate to change password
                  },
                ),
                Divider(height: 1, color: Color(0xFFF2F2F2)),
                SizedBox(height: 8),
                _buildActionTile(
                  label: 'Notification',
                  icon: CupertinoIcons.bell,
                  onTap: () {
                    // Navigate to notifications
                  },
                ),
                Divider(height: 1, color: Color(0xFFF2F2F2)),
                SizedBox(height: 8),
                _buildActionTile(
                  label: 'Settings',
                  icon: CupertinoIcons.moon,
                  onTap: () {
                    // Navigate to settings
                  },
                ),
                Divider(height: 1, color: Color(0xFFF2F2F2)),
                SizedBox(height: 8),
                _buildActionTile(
                  label: 'Settings',
                  icon: Icons.settings_outlined,
                  onTap: () {
                    // Navigate to settings
                  },
                ),
                Divider(height: 1, color: Color(0xFFF2F2F2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({required String label, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFFF26B6C),
              fontSize: 15,
              fontFamily: 'UniNeue',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value, style: TextStyle(color: Colors.grey[800], fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Color(0xFFF26B6C),
                fontSize: 15,
                fontFamily: 'UniNeue',
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(icon, color: Colors.grey[600], size: 20),
          ],
        ),
      ),
    );
  }
}
