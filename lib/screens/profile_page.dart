import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
   const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.purpleAccent)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.purpleAccent.withOpacity(0.2),
                        child: const Icon(Icons.person, size: 40, color: Colors.purpleAccent),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Catherine',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '@catherinewu',
                            style: TextStyle(color: Colors.purpleAccent),
                          ),
                          Text(
                            'Product designer',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'About Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildProfileInfo('Lives in', 'San Francisco'),
                  _buildProfileInfo('Worked at', 'Google'),
                  _buildProfileInfo('From', 'New York'),
                  _buildProfileInfo('Studied at', 'Stanford'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('Following', 85),
                      _buildStatColumn('Followers', 1091),
                      _buildStatColumn('Lives', 4384),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.purpleAccent.withOpacity(0.3)),
            _buildTabBar(),
            _buildPostsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purpleAccent,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTabButton('Posts'),
          _buildTabButton('Updates'),
          _buildTabButton('Tagged'),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.purpleAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPostsGrid() {
    List<Map<String, dynamic>> posts = [
      {'title': 'Golden Gate Bridge', 'views': 435},
      {'title': 'Ramen dinner', 'views': 275},
      {'title': 'Hiking on Sunday', 'views': 542},
      {'title': 'New House', 'views': 745},
      {'title': 'Birthday celebration', 'views': 935},
      {'title': 'Palm Springs getaway', 'views': 123},
      {'title': 'New plants', 'views': 583},
      {'title': 'At Golden Gate Park', 'views': 493},
      {'title': 'Yosemite trip', 'views': 238},
      {'title': 'New car', 'views': 346},
      {'title': 'Christmas tree shopping', 'views': 384},
      {'title': 'Siding at Tahoe', 'views': 238},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[900],
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: Colors.purple.withOpacity(0.1),
                child: Center(
                  child: Icon(Icons.image, color: Colors.purpleAccent.withOpacity(0.5)),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Text(
                  posts[index]['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Text(
                  '${posts[index]['views']} views',
                  style: const TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}