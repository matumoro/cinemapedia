import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {


    final initialloading = ref.watch(initialloadingProvider);
    if (initialloading) return const FullScreenLoader();  


    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(upComingMoviesProvider);
    final upComingMovies = ref.watch(topRatedMoviesProvider);


    //if (nowPlayingMovies.isEmpty) return const CircularProgressIndicator();

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(children: [
              //const CustomAppbar(),
              MoviesSlideshow(movies: slideShowMovies),

              MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: 'En cines',
                //subTitle: 'Lunes 20',
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),

              MovieHorizontalListview(
                  movies: upComingMovies,
                  title: 'Proximamente',
                  //subTitle: 'En este mes',
                  loadNextPage: () =>
                      ref.read(upComingMoviesProvider.notifier).loadNextPage()),

              MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  //subTitle: '',
                  loadNextPage: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage()),

              MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Best Qualitys',
                  //subTitle: 'Desde siempre',
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage()),
                  //const SizedBox( height: 10 ),    
            ],);
          },
          childCount: 1
        )),
      ]
    );
  }
}
