import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/home/widgets/home_widgets.dart';
import '/presentation/home/bloc/dischi_cubit/dischi_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DischiCubit>().getDischi();
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: const Column(
        children: [
          InputRicerca(),
          BarraOrdinamento(),
          ElencoDischi(),
        ],
      ),
    );
  }
}
