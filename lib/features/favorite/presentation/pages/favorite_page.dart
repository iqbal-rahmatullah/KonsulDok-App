import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/features/favorite/presentation/bloc/delete_favorite/delete_favorite_bloc.dart';
import 'package:konsul_dok/features/favorite/presentation/bloc/get_favorite/get_favorite_bloc.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/card_detail_dokter.dart';
import 'package:konsul_dok/widgets/favorite_dokter_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    context.read<GetFavoriteBloc>().add(OnGetFavorite());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorite',
          style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
        ),
      ),
      body: Padding(
        padding: MySpacing.paddingInsetPage,
        child: BlocBuilder<GetFavoriteBloc, GetFavoriteState>(
          builder: (context, state) {
            if (state is GetFavoriteLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetFavoriteSuccess) {
              return Column(
                children: state.favorites.map((e) {
                  return CardFavoriteDoctor(
                    doctor: e.doctor,
                    idFavorite: e.id,
                  );
                }).toList(),
              );
            } else if (state is GetFavoriteFailure) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
