import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reverbeo/view_models/audio_view_model.dart';
import 'package:reverbeo/views/home_page.dart';
import 'package:reverbeo/views/recordings_page.dart';
import 'package:reverbeo/views/settings_page.dart';
import 'package:reverbeo/constants/app_colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioViewModel = Provider.of<AudioViewModel>(context);

    final List<Widget> widgetOptions = <Widget>[
      const HomePage(),
      const RecordingsPage(),
      const SettingsPage(),
    ];

    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(audioViewModel.tabIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Recordings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: audioViewModel.tabIndex,
        selectedItemColor: AppColors.primary,
        onTap: (index) => audioViewModel.changeTab(index),
      ),
    );
  }
}