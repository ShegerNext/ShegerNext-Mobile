import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shegernext/core/component/bottom_nav_bar.dart';
import 'package:shegernext/features/user_posts/presentation/bloc/user_posts_bloc.dart';

class UserPostsPage extends StatefulWidget {
  const UserPostsPage({super.key});

  @override
  State<UserPostsPage> createState() => _UserPostsPageState();
}

class _UserPostsPageState extends State<UserPostsPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserPostsBloc>().add(LoadUserPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Complaints')),
      body: BlocBuilder<UserPostsBloc, UserPostsState>(
        builder: (context, state) {
          if (state is UserPostsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserPostsLoaded) {
            if (state.complaints.isEmpty) {
              return const Center(child: Text('No complaints found.'));
            }
            return ListView.builder(
              itemCount: state.complaints.length,
              itemBuilder: (context, index) {
                final complaint = state.complaints[index];
                return ListTile(
                  title: Text(complaint.text),
                  subtitle: Text('Status: ${complaint.status ?? "Unknown"}'),
                  trailing: Text(
                    complaint.createdAt != null
                        ? complaint.createdAt!.toLocal().toString()
                        : '',
                  ),
                );
              },
            );
          } else if (state is UserPostsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}