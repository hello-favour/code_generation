import 'package:code_generation/service_locator/setup_locator.dart';
import 'package:flutter/material.dart';
import 'models/public.dart';
import 'repositories/public_repository.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Public API Demo with GetIt',
      home: PublicsPage(),
    );
  }
}

class PublicsPage extends StatefulWidget {
  const PublicsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PublicsPageState createState() => _PublicsPageState();
}

class _PublicsPageState extends State<PublicsPage> {
  late final Future<List<Public>> futurePublics;

  @override
  void initState() {
    super.initState();
    // Use GetIt to retrieve the repository instance
    final publicRepository = getIt<PublicRepository>();
    futurePublics = publicRepository.getPublics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Public API Demo with GetIt'),
      ),
      body: FutureBuilder<List<Public>>(
        future: futurePublics,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            final publics = snapshot.data!;
            return ListView.builder(
              itemCount: publics.length,
              itemBuilder: (context, index) {
                final public = publics[index];
                return ListTile(
                  title: Text(public.title),
                  subtitle: Text(public.description ?? 'No description'),
                  trailing: Text(public.id),
                );
              },
            );
          }
        },
      ),
    );
  }
}
