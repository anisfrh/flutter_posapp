import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:possapp/core/constants/colors.dart';
import 'package:possapp/data/datasources/auth_local_datasource.dart';
import 'package:possapp/data/datasources/auth_remote_datasource.dart';
import 'package:possapp/data/datasources/order_remote_datasouces.dart';
import 'package:possapp/data/datasources/product_remote_datasource.dart';
import 'package:possapp/presentation/auth/bloc/login/login_bloc.dart';
import 'package:possapp/presentation/auth/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possapp/presentation/history/bloc/history/history_bloc.dart';
import 'package:possapp/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:possapp/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:possapp/presentation/home/bloc/product/product_bloc.dart';
import 'package:possapp/presentation/home/pages/dashboard_page.dart';
import 'package:possapp/presentation/orders/bloc/order/order_bloc.dart';
import 'package:possapp/presentation/setting/bloc/sync_order/sync_order_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( //multiblocprovider digunakan jika banyak bloc yg digunakan
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductRemoteDatasource())
            ..add(const ProductEvent.fetchLocal()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => HistoryBloc(),
        ),
        BlocProvider(
          create: (context) => SyncOrderBloc(OrderRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.primary,
            ),
          ),
        ),
        home: FutureBuilder<bool>(
          future: AuthLocalDataSource().isAuth(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return const DashboardPageState();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
