import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import 'package:myapp/core/utils/strings.dart';
import 'package:myapp/features/home/presentation/bloc/home_bloc.dart'; // Import the BLoC
import 'package:myapp/features/home/presentation/bloc/home_event.dart'; // Import the events
import 'package:myapp/features/home/presentation/bloc/home_state.dart'; // Import the states

class HomePage extends StatefulWidget { // Change to StatefulWidget to dispatch event on init
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Dispatch the LoadImages event when the page is initialized
    context.read<HomeBloc>().add(LoadImages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: BlocBuilder<HomeBloc, HomeState>( // Use BlocBuilder to react to states
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator()); // Show loading indicator
          } else if (state is HomeLoaded) {
            return GridView.count(
              crossAxisCount: 2,
              children: List.generate(state.imageUrls.length, (index) {
                return Center(
                  child: Card(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          state.imageUrls[index], // Use image URL from state
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.3),
                          child: const Text(
                            AppStrings.fishImageAltText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          } else if (state is HomeError) {
            return Center(child: Text('Error: ${state.message}')); // Show error message
          }
          return const Center(child: Text('Press button to load images')); // Initial state text
        },
      ),
    );
  }
}