import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/utils/strings.dart';
import 'package:myapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:myapp/features/home/presentation/bloc/home_event.dart';
import 'package:myapp/features/home/presentation/bloc/home_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    AppStrings.appTitle,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  floating: true,
                  backgroundColor: theme.appBarTheme.backgroundColor,
                  elevation: theme.appBarTheme.elevation ?? 2,
                  centerTitle: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: CarouselSlider(
                              carouselController: _carouselController,
                              options: CarouselOptions(
                                height: double.infinity,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 6,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                viewportFraction: 0.85,
                                onPageChanged: (index, reason) {
                                  _current.value = index;
                                },
                              ),
                              items: state.offerCarouselImages.map((carousalItem) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        boxShadow: [
                                          BoxShadow(
                                            color: theme.shadowColor.withValues(alpha: .08),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              carousalItem.imageUrl,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              loadingBuilder: (context, child, progress) {
                                                if (progress == null) return child;
                                                return Container(
                                                  color: theme.colorScheme.surfaceContainerHighest,
                                                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                                );
                                              },
                                              // TODO: dont use minwdth, try other layout combination
                                              errorBuilder: (context, error, stackTrace) => Container(
                                                color: theme.colorScheme.surfaceContainerHighest,
                                                constraints: BoxConstraints(minWidth: 300),
                                                child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                                              ),
                                            ),
                                            // Text overlay on the right half
                                            Positioned.fill(
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width / (2 * 0.85), // half of the carousel item width (0.85 viewportFraction)
                                                  padding: const EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.centerLeft,
                                                      end: Alignment.centerRight,
                                                      colors: [
                                                        theme.colorScheme.shadow.withValues(alpha: 0.5),
                                                        theme.colorScheme.shadow.withValues(alpha: 0)
                                                      ],
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        carousalItem.title, 
                                                        style: theme.textTheme.titleLarge?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      const SizedBox(height: 8.0),
                                                      Text(
                                                        carousalItem.description, 
                                                        style: theme.textTheme.bodyMedium?.copyWith(
                                                          color: Colors.white70,
                                                        ),
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ValueListenableBuilder<int>(
                          valueListenable: _current,
                          builder: (context, index, child) {
                            return AnimatedSmoothIndicator(
                              activeIndex: index,
                              count: state.offerCarouselImages.length,
                              effect: ExpandingDotsEffect(
                                activeDotColor: theme.colorScheme.primary,
                                dotColor: theme.colorScheme.onSurface.withOpacity(0.3),
                                dotHeight: 8,
                                dotWidth: 8,
                                expansionFactor: 4,
                                spacing: 5.0,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                         Align(
                          alignment: Alignment.centerLeft,
                           child: Padding(
                             padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0),
                             child: Text(
                              AppStrings.galleryTitle,
                               style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                               ),
                                ),
                           ),
                         ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  sliver: SliverGrid.builder(
                   gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: MediaQuery.of(context).size.width >= 900 ? 4 : 2,
        pattern: [
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
        ],
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: state.imageUrls.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            state.imageUrls[index],
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                color: theme.colorScheme.surfaceContainerHighest,
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: theme.colorScheme.surfaceContainerHighest,
              child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
            ),
          ),
        );
      },
    ),
  ),
              ],
            );
          } else if (state is HomeError) {
            return Center(child: Text('${AppStrings.errorPrefix}${state.message}'));
          }
          return const Center(child: Text(AppStrings.pressButtonToLoadImages));
        },
      ),
    );
  }
}
