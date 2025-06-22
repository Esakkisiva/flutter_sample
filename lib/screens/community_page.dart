import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key}); // ✅ Add const constructor

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}


class _CommunityPageState extends State<CommunityPage> {
  int _selectedTab = 0;
  final List<String> _tabs = ['For You', 'Tech', 'Wellness', 'Art'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Communities', style: TextStyle(color: Colors.purpleAccent)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _tabs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextButton(
                      onPressed: () {
                        setState(() => _selectedTab = index);
                      },
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          color: _selectedTab == index ? Colors.purpleAccent : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(color: Colors.purpleAccent.withOpacity(0.3)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildCommunityCard(
                    'Coding',
                    'Wees Bos has a great course on JavaScript 30. It\'s 30 days of building 30 things with vanilla JS.',
                    5200,
                  ),
                  const SizedBox(height: 16),
                  _buildCommunityCard(
                    'How to become a software engineer',
                    'I\'m currently working as a sales manager at Google and I want to transition into a software engineering role. What are some of the best ways to do so?',
                    3100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityCard(String name, String message, int members) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.purpleAccent.withOpacity(0.2),
                  child: Text(
                    name[0],
                    style: const TextStyle(color: Colors.purpleAccent),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.purpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${(members / 1000).toStringAsFixed(1)}K members',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.favorite_border, color: Colors.purpleAccent, size: 16),
                    SizedBox(width: 5),
                    Text('178', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    SizedBox(width: 15),
                    Icon(Icons.comment, color: Colors.purpleAccent, size: 16),
                    SizedBox(width: 5),
                    Text('78', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    SizedBox(width: 15),
                    Icon(Icons.share, color: Colors.purpleAccent, size: 16),
                    SizedBox(width: 5),
                    Text('39', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Join',
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
