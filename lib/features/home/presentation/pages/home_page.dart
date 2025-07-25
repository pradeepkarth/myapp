import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/utils/strings.dart';
import 'package:myapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:myapp/features/home/presentation/bloc/home_event.dart';
import 'package:myapp/features/home/presentation/bloc/home_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import the indicator package

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselSliderController _carouselController = CarouselSliderController(); // Create a CarouselController
  final ValueNotifier<int> _current = ValueNotifier<int>(0); // ValueNotifier for current index

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadImages());
  }

  @override
  void dispose() {
    _current.dispose(); // Dispose the ValueNotifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return Column(
              children: [
                // Offer Carousel
                CarouselSlider(
                  carouselController: _carouselController, // Assign the controller
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) { // Update current index on page change
                      _current.value = index;
                    },
                  ),
                  items: state.offerCarouselImages.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10), // Add spacing between carousel and indicator

                // Carousel Indicator
                ValueListenableBuilder<int>(
                  valueListenable: _current,
                  builder: (context, index, child) {
                    return AnimatedSmoothIndicator(
                      activeIndex: index,
                      count: state.offerCarouselImages.length,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.blue,
                        dotColor: Colors.grey,
                        dotHeight: 8,
                        dotWidth: 8,
                        expansionFactor: 4,
                        spacing: 5.0,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20), // Add spacing

                // Grid View
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(state.imageUrls.length, (index) {
                      return Center(
                        child: Card(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                state.imageUrls[index],
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
                  ),
                ),
              ],
            );
          } else if (state is HomeError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Press button to load images'));
        },
      ),
    );
  }
}