import 'package:api_training/models/profile_model.dart';
import 'package:api_training/repos/dio_helper.dart';
import 'package:api_training/repos/end_points.dart';
import 'package:api_training/repos/shared_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  Future<Response> _getProfile() {
    return DioHelper.dio.get(getProfile,
        options: Options(
          headers: {
            "Authorization": "Bearer ${SharedHelper.prefs.getString("token")}"
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: FutureBuilder<Response>(
        future: _getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = ProfileModel.fromJson(snapshot.data!.data);
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(data.avatar!),
                      maxRadius: 50,
                    ),
                    ListTile(
                      title: Text(data.name!),
                    ),
                    ListTile(
                      title: Text(data.email!),
                    ),
                  ]),
            );
          }
        },
      ),
    );
  }
}
