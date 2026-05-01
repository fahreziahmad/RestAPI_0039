import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:restapi/logic/bloc/auth/auth_bloc.dart';
import 'package:restapi/logic/bloc/auth/auth_event.dart';
import 'package:restapi/logic/bloc/hewan/hewan_bloc.dart';
import 'package:restapi/logic/bloc/hewan/hewan_event.dart';
import 'package:restapi/logic/bloc/hewan/hewan_state.dart';
import '../../data/repositories/hewan_repository.dart';
import 'add_hewan_page.dart';
import 'edit_hewan_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HewanBloc(repository: HewanRepository())..add(FetchHewan()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            "Koleksi Ternak",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => context.read<AuthBloc>().add(LogoutRequested()),
              icon: const Icon(Icons.logout, color: Colors.white),
              tooltip: 'Logout',
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1A237E), Color(0xFFAD1457)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}