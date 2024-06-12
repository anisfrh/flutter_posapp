import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possapp/core/assets/assets.gen.dart';
import 'package:possapp/core/components/menu_button.dart';
import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/core/constants/colors.dart';
import 'package:possapp/core/extensions/build_context_ext.dart';
import 'package:possapp/data/datasources/auth_local_datasource.dart';
import 'package:possapp/data/datasources/product_local_datasource.dart';
import 'package:possapp/presentation/auth/pages/login_page.dart';
import 'package:possapp/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:possapp/presentation/home/bloc/product/product_bloc.dart';
import 'package:possapp/presentation/setting/pages/manage_product_page.dart';
import 'package:possapp/presentation/setting/pages/sync_order_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                MenuButton(
                  iconPath: Assets.images.manageProduct.path,
                  label: 'Kelola Produk',
                  onPressed: () => context.push(const ManageProductPage()),
                  isImage: true,
                ),
                const SpaceWidth(15),
                MenuButton(
                  iconPath: Assets.images.managePrinter.path,
                  label: 'Kelola Printer',
                  onPressed:
                      () {}, //=> context.push(const ManagePrinterPage()),
                  isImage: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                MenuButton(
                  iconPath: Assets.images.manageProduct.path,
                  label: 'QRIS Server Key',
                  onPressed: () => context.push(const ManageProductPage()),
                  isImage: true,
                ),
                const SpaceWidth(15),
                MenuButton(
                  iconPath: Assets.images.managePrinter.path,
                  label: 'Sinkronisasi Data',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SyncDataPage(),
                      ),
                    );
                  },
                  isImage: true,
                ),
              ],
            ),
          ),
          const SpaceHeight(60),
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (_) {
                  AuthLocalDataSource().removeAuthData();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
              );
            },
            // dibuilder bakal mengembalikan widget
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(const LogoutEvent.logout());
                },
                child: const Text('Logout'),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
