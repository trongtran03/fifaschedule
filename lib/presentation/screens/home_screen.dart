import 'package:fifaschedule/presentation/screens/matches_screen.dart';
import 'package:fifaschedule/presentation/screens/profile_screen.dart';
import 'package:fifaschedule/presentation/screens/standings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _pages = [
      _HomeTabContent(tabController: _tabController),
      const StandingsScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
            automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Image.asset('assets/images/logofifa.png', height: 40),
                  const Text("schedule", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(icon: SizedBox(height: 50, child: Image.asset('assets/images/uefa.png'))),
                  Tab(icon: SizedBox(height: 50, child: Image.network('https://crests.football-data.org/PL.png'))),
                  Tab(icon: SizedBox(height: 30, child: Image.network('https://crests.football-data.org/laliga.png'))),
                  Tab(icon: SizedBox(height: 50, child: Image.network('https://crests.football-data.org/BL1.png'))),
                ],
              ),
            )
          : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard_rounded), label: 'Standings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _HomeTabContent extends StatelessWidget {
  final TabController tabController;

  const _HomeTabContent({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const [
        MatchesScreen(filter: 'all'),
        MatchesScreen(filter: 'PL'),
        MatchesScreen(filter: 'PD'),
        MatchesScreen(filter: 'FL1'),
      ],
    );
  }
}
