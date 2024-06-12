import 'package:flutter/material.dart';
import 'package:possapp/core/assets/assets.gen.dart';
import 'package:possapp/core/constants/colors.dart';
import 'package:possapp/presentation/history/pages/history_page.dart';
import 'package:possapp/presentation/home/pages/home_page.dart';
import 'package:possapp/presentation/home/widgets/nav_item.dart';
import 'package:possapp/presentation/orders/pages/orders_page.dart';
import 'package:possapp/presentation/setting/pages/setting_page.dart';

class DashboardPageState extends StatefulWidget {
  const DashboardPageState({super.key});

  @override
  State<DashboardPageState> createState() => _DashboardPageStateState();
}

class _DashboardPageStateState extends State<DashboardPageState> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const OrdersPage(),
    const HistoryPage(),
    const SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 30.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              iconPath: Assets.icons.home.path,
              label: 'Home',
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            NavItem(
                iconPath: Assets.icons.orders.path,
                label: 'Orders',
                isActive: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                }),
            NavItem(
              iconPath: Assets.icons.history.path,
              label: 'History',
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            NavItem(
              iconPath: Assets.icons.dashboard.path,
              label: 'Kelola',
              isActive: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
