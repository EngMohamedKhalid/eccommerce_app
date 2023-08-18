import 'package:eccommerce_app/features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
             children: [

             ],
          ),
        );
      },
    );
  }
}
