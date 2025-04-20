import 'package:flutter/material.dart';
import 'widgets/navbar.dart';
import 'widgets/search_filters.dart';
import 'widgets/orders_table.dart';
import 'services/mock_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Orders',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OpenOrdersPage(),
    );
  }
}

class OpenOrdersPage extends StatelessWidget {
  const OpenOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = MockData.getOrders();
    return LayoutBuilder(
      builder: (context, constraints) {
        // 📱 treat anything under 1000px as "mobile"
        final isMobile = constraints.maxWidth < 1000;

        // scaffoldKey lets us open the drawer from inside NavBar
        final scaffoldKey = GlobalKey<ScaffoldState>();

        return Scaffold(
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            // pass the open-drawer callback into NavBar
            child:
                NavBar(onMenuTap: () => scaffoldKey.currentState?.openDrawer()),
          ),
          drawer: isMobile ? const NavDrawer() : null,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Open Orders',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const SearchFilters(
                  allClients: [
                    'AAA001',
                    'AAA002',
                    'AAA003', /*…*/
                  ],
                  allStocks: [
                    'RELIANCE',
                    'ASIANPAINT',
                    'MRF', /*…*/
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(child: OrdersTable(orders: orders)),
              ],
            ),
          ),
        );
      },
    );
  }
}
