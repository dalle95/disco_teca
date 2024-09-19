import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/pages/home_page/bloc/home_blocs.dart';
import '/pages/home_page/bloc/home_states.dart';
import '/pages/home_page/home_page_controller.dart';
import '/pages/home_page/widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController _controller;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _controller = HomePageController(context: context);

    _controller.estraiDati();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: appBar(context: context),
          body: Column(
            children: [
              inputRicerca(
                  context: context, searchController: searchController),
              barraOrdinamento(context: context),
              elencoDischi(context: context),
            ],
          ),
        );
      },
    );
  }
}
