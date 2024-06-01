
import 'package:flutter/material.dart';
import 'package:learn_api/user_data_model.dart';
import 'package:provider/provider.dart';

import 'api_services.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenProvider homeScreenProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeScreenProvider= Provider.of<HomeScreenProvider>(context, listen : false);
      homeScreenProvider.fetchPhotos();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text("Unsplash Data"),
        ),
        body: Consumer<HomeScreenProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.list.isEmpty) {
              return const Center(child: Text('No photos available.'));
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: provider.list.length,
              itemBuilder: (context, index) {
                UsersIteamModel photo = provider.list[index];
                return ListTile(
                  leading:CircleAvatar(
                    backgroundImage: NetworkImage("${photo.user?.profileImage?.small}"),
                    radius:30,
                  ),// Ensure the correct field for image URL
                  title: Text("${photo.user?.name}",style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle:
                  Text("${photo.user?.firstName}"),

                  // Ensure the correct field for title
                );
              },
            );
          },
        )
    );
  }
}

