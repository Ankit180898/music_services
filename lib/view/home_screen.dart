import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_services/view/service_details_screen.dart';
import 'package:music_services/view_model/music_service_view_model.dart';
import 'package:music_services/widgets/service_card.dart';
import 'package:music_services/widgets/squircle_widget.dart';
import 'package:provider/provider.dart';
import 'package:music_services/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: const Color(0xff18171C),
      body: SingleChildScrollView(
        child: Column(
          spacing: 24.0,
          children: [_buildBanner(), _buildServicesList()],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff18171C),
          border: Border(top: BorderSide(color: Colors.grey[800]!, width: 0.5)),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              unselectedItemColor: Colors.grey[600],
              selectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/logo.png',
                    height: 40,
                    width: 40,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/news.svg',
                    color: Colors.grey[600],
                    height: 24,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/news.svg',
                    color: Colors.white,
                    height: 24,
                  ),
                  label: 'News',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/music.svg',
                    color: Colors.grey[600],
                    height: 24,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/music.svg',
                    color: Colors.white,
                    height: 24,
                  ),
                  label: 'TrackBox',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/projects.svg',
                    color: Colors.grey[600],
                    height: 24,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/projects.svg',
                    color: Colors.white,
                    height: 24,
                  ),
                  label: 'Projects',
                ),
              ],
            ),

            // Semi-circular indicator
            Positioned(
              top: -10,

              left:
                  MediaQuery.of(context).size.width / 8 +
                  (_selectedIndex * MediaQuery.of(context).size.width / 4) -
                  10,
              child: Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Top Banner
  Widget _buildBanner() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.37,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffA90140), Color(0xff550120)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildSearchBar(),
          ),
          const SizedBox(height: 36),
          buildFreeDemoSection(context),
        ],
      ),
    );
  }

  // Music Services List
  Widget _buildServicesList() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Hire hand-picked Pros for popular music services',
              style: Utils.syneTextStyle.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Consumer<MusicServiceViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFFB91D73)),
                );
              }

              if (viewModel.hasError) {
                return Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${viewModel.errorMessage}',
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => viewModel.loadMusicServices(),
                          child: const Text('Retry'),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => viewModel.setupInitialData(),
                          child: const Text('Setup Initial Data'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (!viewModel.hasData) {
                return const Center(
                  child: Text(
                    'No services available',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => viewModel.refreshMusicServices(),
                color: const Color(0xFFB91D73),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16),
                  itemCount: viewModel.musicServices.length,
                  itemBuilder: (context, index) {
                    final service = viewModel.musicServices[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ServiceCard(
                        service: service,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      ServiceDetailScreen(service: service),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        children: [
          Expanded(
            child: SquircleWidget(
              borderRadius: 16,
              child: Container(
                height: 48,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: Color(0xff2C2D31),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/search.svg'),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search 'Punjabi Lyrics'",
                          hintStyle: Utils.syneTextStyle.copyWith(
                            color: Color(0xff61616B),
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const VerticalDivider(
                            color: Color(0xff45454F),
                            thickness: 1,
                            indent: 8,
                            endIndent: 8,
                          ),

                          SvgPicture.asset('assets/icons/mic.svg'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          SvgPicture.asset('assets/icons/profile.svg'),
        ],
      ),
    );
  }

  // Free Demo Section
  Widget buildFreeDemoSection(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.22,
        width: double.infinity,

        child: Stack(
          children: [
            // Left CD Image
            Positioned(
              bottom: 0,
              left: -30,

              child: SvgPicture.asset('assets/images/cd.svg'),
            ),
            // Right Keyboard Image
            Positioned(
              top: 50,
              right: -36,
              child: SvgPicture.asset('assets/images/keyboard.svg'),
            ),

            // Centered Text and Button
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Claim your",
                        style: Utils.syneBoldTextStyle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Free Demo",
                        style: Utils.syneBoldItalicTextStyle.copyWith(
                          fontSize: 45,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "for custom Music Production",
                        style: Utils.syneTextStyle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 110,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 7,
                            ),
                          ),
                          child: Text(
                            "Book Now",
                            style: Utils.syneBoldTextStyle.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
