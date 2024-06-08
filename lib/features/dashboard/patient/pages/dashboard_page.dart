import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/all_chat/chat_bloc.dart';
import 'package:konsul_dok/features/dashboard/patient/cubit/navbar_cubit.dart';
import 'package:konsul_dok/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:konsul_dok/utils/navbar_item.dart';
import 'package:konsul_dok/widgets/navbar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, stateOnBoarding) {
        if (stateOnBoarding is OnBoardingSuccess) {
          if (!stateOnBoarding.isOnBoarding) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.goNamed('onboarding');
            });
          }
        }
        return BlocBuilder<NavbarCubit, int>(
          builder: (context, state) {
            return Scaffold(
              body: BlocProvider.of<NavbarCubit>(context).pageNow,
              bottomNavigationBar: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, stateChat) {
                  if (stateChat is ChatLoaded) {
                    int countChat = stateChat.chats.fold(
                        0,
                        (previousValue, element) =>
                            previousValue + element.countChat!);

                    return MyBottomNavigationBar(
                      itemNavbar:
                          NavbarItem(countChat: countChat).getNavbarItems(),
                      selectedIndex: state,
                      onItemTapped: (index) {
                        context.read<NavbarCubit>().change(index);
                      },
                    );
                  }
                  return MyBottomNavigationBar(
                    itemNavbar: NavbarItem(countChat: 0).getNavbarItems(),
                    selectedIndex: state,
                    onItemTapped: (index) {
                      context.read<NavbarCubit>().change(index);
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
