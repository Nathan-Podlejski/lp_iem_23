import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:spots_discovery/data/endpoint/spot_endpoint.dart';
import 'package:spots_discovery/infrastructure/viewmodel/home_viewmodel.dart';

import '../data/model/spot.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(SpotEndpoint(GetIt.I.get<Dio>())),
      builder: (_, __) => Scaffold(
        body: Consumer<HomeViewModel>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: Provider.of<HomeViewModel>(context).spots.length,
              itemBuilder: (context, index) {
                Spot item = Provider.of<HomeViewModel>(context).spots[index];
                return ListTile(
                  leading: Image.network(
                    item.imageThumbnail ?? "",
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(),
                  ),
                  title: Text(item.title.toString()),
                  subtitle: Text(item.address.toString()),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(
                                spot: item,
                              )),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      lazy: false,
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.spot}) : super(key: key);

  final Spot spot;

  @override
  Widget build(Object context) {
    return Column(
      children: [
        Text(spot.title ?? ""),
        Image.network(
          spot.imageFullsize ?? "",
          errorBuilder: (context, error, stackTrace) => const Center(),
        ),
        Text(spot.address ?? ""),
        Text(spot.trainStation ?? ""),
        Text((spot.isRecommended != null && spot.isRecommended!)
            ? "Recommandé"
            : ""),
        Text((spot.isClosed != null && spot.isClosed!) ? "FERMÉ" : ""),
        /*ListView.builder(
          itemCount: spot.tagsCategory?.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(spot.tagsCategory?[index].name ?? ""),
          ),
        ),*/
      ],
    );
  }
}
