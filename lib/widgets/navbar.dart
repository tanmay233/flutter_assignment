import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  /// Called when the menu (☰) icon is tapped
  final VoidCallback onMenuTap;

  const NavBar({Key? key, required this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 1000;

    // Slight elevation and rounded bottom corners
    final appBarShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
    );

    if (isMobile) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        shape: appBarShape,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: onMenuTap,
        ),
        title: Row(
          children: [
            const Icon(Icons.show_chart, size: 28, color: Colors.orange),
            const SizedBox(width: 8),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    _StockTicker(symbol: 'NIFTY BANK', price: '52,323.30'),
                    _StockTicker(symbol: 'FIN SERVICE', price: '25,255.75'),
                    _StockTicker(symbol: 'RELCHEM', price: '162.73'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Desktop / Tablet AppBar
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      shape: appBarShape,
      title: Row(
        children: [
          const Icon(Icons.show_chart, size: 32, color: Colors.orange),
          const SizedBox(width: 16),
          const _StockTicker(symbol: 'NIFTY BANK', price: '52,323.30'),
          const _StockTicker(symbol: 'FIN SERVICE', price: '25,255.75'),
          const _StockTicker(symbol: 'RELCHEM', price: '162.73'),
          const Spacer(),
          const _NavItem(label: 'Market Watch'),
          const _NavItem(label: 'Exchange Files'),
          const _NavItem(label: 'Portfolio'),
          const _NavItem(label: 'Funds'),
          const Padding(
            padding: EdgeInsets.only(left: 24.0),
            child: CircleAvatar(child: Text('LK')),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  const _NavItem({required this.label});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
        ),
      );
}

class _StockTicker extends StatelessWidget {
  final String symbol;
  final String price;
  const _StockTicker({required this.symbol, required this.price});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(symbol,
                    style: const TextStyle(fontSize: 12, color: Colors.black)),
                const SizedBox(height: 4),
                Text(price,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ],
            ),
            const SizedBox(width: 15),
          ],
        ),
      );
}

/// Drawer that shows your Market Watch / Exchange Files / Portfolio / Funds
class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.show_chart),
            title: const Text('Market Watch'),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            leading: const Icon(Icons.insert_drive_file),
            title: const Text('Exchange Files'),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            leading: const Icon(Icons.pie_chart),
            title: const Text('Portfolio'),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('Funds'),
            onTap: () => Navigator.of(context).pop(),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('LK'),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
