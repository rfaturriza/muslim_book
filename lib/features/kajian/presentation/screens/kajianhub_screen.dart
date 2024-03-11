import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quranku/core/components/search_box.dart';
import 'package:quranku/core/constants/asset_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

import '../../../../core/components/spacer.dart';
import '../../../../core/utils/pair.dart';
import '../../../../core/utils/themes/color_schemes_material.dart';

class KajianHubScreen extends StatelessWidget {
  const KajianHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    const tabBar = TabBar(
      tabs: [
        Tab(text: 'Kajian'),
        Tab(text: 'Ramadhan'),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          context.isDarkMode
              ? AssetConst.kajianHubTextLogoLight
              : AssetConst.kajianHubTextLogoDark,
          width: 100,
        ),
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            scrollBehavior: const ScrollBehavior().copyWith(
              physics: const NeverScrollableScrollPhysics(),
            ),
            controller: controller,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  leading: const SizedBox(),
                  backgroundColor: Colors.transparent,
                  expandedHeight: tabBar.preferredSize.height + 8,
                  pinned: false,
                  flexibleSpace: const FlexibleSpaceBar(
                    background: tabBar,
                  ),
                  collapsedHeight: tabBar.preferredSize.height + 8,
                ),
              ];
            },
            body: const TabBarView(
              children: [
                _KajianSection(),
                _RamadhanSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _KajianSection extends StatelessWidget {
  const _KajianSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VSpacer(height: 10),
        SearchBox(
          isDense: true,
          initialValue: '',
          hintText: 'Cari kajian...',
          onChanged: (value) {},
          onSubmitted: () {},
        ),
        const VSpacer(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Chip(label: Text('Terdekat')),
                      HSpacer(width: 5),
                      Chip(label: Text('Terdekat')),
                      HSpacer(width: 5),
                      Chip(label: Text('Terdekat')),
                      HSpacer(width: 5),
                      Chip(label: Text('Terdekat')),
                      HSpacer(width: 5),
                      Chip(label: Text('Terdekat')),
                      HSpacer(width: 5),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: context.theme.colorScheme.tertiary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    foregroundColor: context.theme.colorScheme.tertiary,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.settings_input_composite_outlined,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(const Duration(seconds: 1));
            },
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const _KajianTile();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _RamadhanSection extends StatelessWidget {
  const _RamadhanSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VSpacer(height: 10),
        SearchBox(
          isDense: true,
          initialValue: '',
          hintText: 'Cari Tata Laksana Ramadhan...',
          onChanged: (value) {},
          onSubmitted: () {},
        ),
        const VSpacer(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Chip(label: Text('Terdekat')),
                      HSpacer(width: 5),
                      Chip(label: Text('Terdekat')),
                      HSpacer(width: 5),
                      Chip(label: Text('Terdekat')),
                      HSpacer(width: 5),
                      Chip(label: Text('Terdekat')),
                      HSpacer(width: 5),
                      Chip(label: Text('Terdekat')),
                      HSpacer(width: 5),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: context.theme.colorScheme.tertiary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    foregroundColor: context.theme.colorScheme.tertiary,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.settings_input_composite_outlined,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(const Duration(seconds: 1));
            },
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const _RamadhanTile();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _KajianTile extends StatelessWidget {
  const _KajianTile();

  @override
  Widget build(BuildContext context) {
    final prayerName = ['Subuh', 'Dzuhur', 'Ashar', 'Maghrib', 'Isya']
        .elementAt(Random().nextInt(5));
    final Pair<Color, Color> prayerColor = () {
      switch (prayerName.toLowerCase()) {
        case 'subuh':
          return Pair(
            context.theme.colorScheme.tertiaryContainer,
            context.theme.colorScheme.onTertiaryContainer,
          );
        case 'dzuhur':
          return Pair(
            context.theme.colorScheme.tertiary,
            context.theme.colorScheme.onTertiary,
          );
        case 'ashar':
          return Pair(
            context.theme.colorScheme.error,
            context.theme.colorScheme.onError,
          );
        case 'maghrib':
          return Pair(
            context.theme.colorScheme.primaryContainer,
            context.theme.colorScheme.onPrimaryContainer,
          );
        case 'isya':
          return Pair(
            context.theme.colorScheme.secondaryContainer,
            context.theme.colorScheme.onSecondaryContainer,
          );
        default:
          return Pair(
            context.theme.colorScheme.tertiaryContainer,
            context.theme.colorScheme.onTertiaryContainer,
          );
      }
    }();
    return GestureDetector(
      onTap: () {
        // context.navigateTo(const KajianDetailScreen());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? MaterialTheme.darkScheme().surfaceContainer
              : MaterialTheme.lightScheme().surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ImageContainer(
              imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpLXvF1SYbbcheqztxEUnGqC4jb-0q4Dv9ep-37gx5pA&s',
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 2),
                            padding: const EdgeInsets.all(2),
                            decoration: ShapeDecoration(
                              color: prayerColor.first,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              prayerName,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: prayerColor.second,
                              ),
                            ),
                          ),
                          Text(
                            'Kajian Jumat Malam asdas das dasadsadss dasda',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const VSpacer(height: 2),
                          Text(
                            'Ustadz Abdul Somad dsadasdasdasds asdasdasdasdaadssda',
                            style: context.textTheme.bodySmall,
                          ),
                          const VSpacer(height: 2),
                          const Row(
                            children: [
                              _IconText(
                                icon: Icons.date_range_outlined,
                                text: 'Setiap Jumat',
                              ),
                              HSpacer(width: 5),
                              _IconText(
                                icon: Icons.access_time,
                                text: '19.00 - 21.00',
                              ),
                            ],
                          ),
                          const VSpacer(height: 2),
                          const _IconText(
                            icon: Icons.place_outlined,
                            text: 'Masjid Raya An-Nashr Bintaro Sektor 5',
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.navigate_next,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RamadhanTile extends StatelessWidget {
  const _RamadhanTile();

  @override
  Widget build(BuildContext context) {
    final prayerName = ['Subuh', 'Terawih'].elementAt(Random().nextInt(2));
    final Pair<Color, Color> prayerColor = () {
      switch (prayerName.toLowerCase()) {
        case 'subuh':
          return Pair(
            context.theme.colorScheme.tertiaryContainer,
            context.theme.colorScheme.onTertiaryContainer,
          );
        case 'terawih':
          return Pair(
            context.theme.colorScheme.secondaryContainer,
            context.theme.colorScheme.onSecondaryContainer,
          );
        default:
          return Pair(
            context.theme.colorScheme.primaryContainer,
            context.theme.colorScheme.onPrimaryContainer,
          );
      }
    }();
    return GestureDetector(
      onTap: () {
        // context.navigateTo(const KajianDetailScreen());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? MaterialTheme.darkScheme().surfaceContainer
              : MaterialTheme.lightScheme().surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ImageContainer(
              imageUrl:
                  'https://pict-a.sindonews.net/dyn/850/pena/new23/02/05/45/1014487/fakta-seputar-masjid-sheikh-zayed-abu-dhabi-teh.jpg',
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 2),
                            padding: const EdgeInsets.all(2),
                            decoration: ShapeDecoration(
                              color: prayerColor.first,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              prayerName,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: prayerColor.second,
                              ),
                            ),
                          ),
                          Text(
                            'Lailatul Qodar, Kapan Waktu yang Tepat Datangnya?',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const VSpacer(height: 2),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Imam: ',
                              style: context.textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: 'Ustadz Abdul Somad',
                              style: context.textTheme.bodySmall,
                            ),
                          ])),
                          const VSpacer(height: 2),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Khatib: ',
                              style: context.textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: 'Ustadz Adi Hidayat',
                              style: context.textTheme.bodySmall,
                            ),
                          ])),
                          const VSpacer(height: 2),
                          const _IconText(
                            icon: Icons.date_range_outlined,
                            text: 'Senin, 11 Maret 2023',
                          ),
                          const VSpacer(height: 2),
                          const _IconText(
                            icon: Icons.place_outlined,
                            text: 'Masjid Raya An-Nashr Bintaro Sektor 5',
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.navigate_next,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageContainer extends StatelessWidget {
  final String imageUrl;

  const _ImageContainer({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(
          child: Icon(
            Icons.error,
            color: context.theme.colorScheme.error,
          ),
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconText({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16),
        const HSpacer(width: 5),
        Text(
          text,
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }
}
