import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/utils/strings.dart';
import 'package:myapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:myapp/features/home/presentation/bloc/home_event.dart';
import 'package:myapp/features/home/presentation/bloc/home_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  final ValueNotifier<int> _current = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadImages());
  }

  @override
  void dispose() {
    _current.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text(
                    AppStrings.appTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 1.2,
                    ),
                  ),
                  floating: true,
                  backgroundColor: Colors.white,
                  elevation: 2,
                  centerTitle: true,
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: CarouselSlider(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                              height: 180.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                              viewportFraction: 0.85,
                              onPageChanged: (index, reason) {
                                _current.value = index;
                              },
                            ),
                            items: state.offerCarouselImages.map((imageUrl) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        loadingBuilder: (context, child, progress) {
                                          if (progress == null) return child;
                                          return Container(
                                            color: Colors.grey[300],
                                            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                          );
                                        },
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 12),

                        ValueListenableBuilder<int>(
                          valueListenable: _current,
                          builder: (context, index, child) {
                            return AnimatedSmoothIndicator(
                              activeIndex: index,
                              count: state.offerCarouselImages.length,
                              effect: const ExpandingDotsEffect(
                                activeDotColor: Colors.blueAccent,
                                dotColor: Colors.grey,
                                dotHeight: 8,
                                dotWidth: 8,
                                expansionFactor: 4,
                                spacing: 5.0,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14.0,
                      mainAxisSpacing: 14.0,
                      childAspectRatio: 0.95,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                state.imageUrls[index],
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.28),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                alignment: Alignment.center,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    AppStrings.fishImageAltText,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black54,
                                          blurRadius: 4,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: state.imageUrls.length,
                    ),
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
