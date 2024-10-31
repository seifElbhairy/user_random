import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_random/provider/pro.dart';
import 'package:user_random/widgets/wedg.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider providerObject = UserProvider.getObject(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Users",style: TextStyle(fontSize: 35),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final result = userProvider.userData?.result;

          if (result == null) {
            providerObject.fetchUsers();
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) {
                final user = result[index];

                return UserItem(
                  name: user["name"],
                  email: user["email"],
                  image: user["image"],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          providerObject.fetchUsers();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}