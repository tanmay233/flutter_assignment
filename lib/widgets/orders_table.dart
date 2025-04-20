// lib/widgets/orders_table.dart
import 'package:flutter/material.dart';
import '../models/order.dart';

class OrdersTable extends StatefulWidget {
  final List<Order> orders;
  const OrdersTable({required this.orders, Key? key}) : super(key: key);

  @override
  _OrdersTableState createState() => _OrdersTableState();
}

class _OrdersTableState extends State<OrdersTable> {
  static const int _rowsPerPage = 4; // show 4 rows per page
  int _currentPage = 0;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  late List<Order> _allOrders;
  late ScrollController _horizontalController;

  @override
  void initState() {
    super.initState();
    _horizontalController = ScrollController();
    // Initialize with provided orders and dummy data
    _allOrders = List.from(widget.orders);
    for (int i = 0; i < 20; i++) {
      _allOrders.add(Order(
        time: '09:${(i % 60).toString().padLeft(2, '0')}:00',
        client: 'AAA00${i % 5}',
        ticker: 'DUMMY${i + 1}',
        side: i % 2 == 0 ? 'Buy' : 'Sell',
        product: 'NRML',
        executed: i + 1,
        total: (i + 1) * 2,
        price: 100.0 + i,
      ));
    }
    _horizontalController = ScrollController();
    // Use only the mock orders from mock_data.dart
    _allOrders = List.from(widget.orders);
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  void _sort<T>(Comparable<T> Function(Order o) getField, int columnIndex) {
    setState(() {
      if (_sortColumnIndex == columnIndex) {
        _sortAscending = !_sortAscending;
      } else {
        _sortColumnIndex = columnIndex;
        _sortAscending = true;
      }
      _allOrders.sort((a, b) {
        final aVal = getField(a);
        final bVal = getField(b);
        return _sortAscending
            ? Comparable.compare(aVal as Comparable, bVal as Comparable)
            : Comparable.compare(bVal as Comparable, aVal as Comparable);
      });
      _currentPage = 0;
    });
  }

  DataColumn _buildSortableColumn<T>(
      String title, int index, Comparable<T> Function(Order o) getField) {
    return DataColumn(
      label: Row(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (_sortColumnIndex == index)
            Icon(
              _sortAscending ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: 18,
            ),
        ],
      ),
      onSort: (_, __) => _sort(getField, index),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (_allOrders.length / _rowsPerPage).ceil();
    final start = _currentPage * _rowsPerPage;
    final pageOrders = _allOrders.skip(start).take(_rowsPerPage).toList();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Data table with horizontal scrolling
              Scrollbar(
                controller: _horizontalController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _horizontalController,
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width - 64,
                    ),
                    child: DataTable(
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columnSpacing: 24,
                      headingRowHeight: 48,
                      dataRowHeight: 56,
                      columns: [
                        _buildSortableColumn('Time', 0, (o) => o.time),
                        _buildSortableColumn('Client', 1, (o) => o.client),
                        const DataColumn(
                          label: Text('Ticker',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const DataColumn(
                          label: Text('Side',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        _buildSortableColumn('Product', 4, (o) => o.product),
                        _buildSortableColumn('Qty', 5, (o) => o.executed),
                        _buildSortableColumn('Price', 6, (o) => o.price),
                        const DataColumn(
                          label: Text('Actions',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                      rows: pageOrders
                          .map((o) => DataRow(cells: [
                                DataCell(Text(o.time)),
                                DataCell(Text(o.client)),
                                DataCell(Text(o.ticker)),
                                DataCell(
                                  Text(
                                    o.side,
                                    style: TextStyle(
                                      color: o.side == 'Buy'
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(Text(o.product)),
                                DataCell(Text('${o.executed}/${o.total}')),
                                DataCell(Text(o.price.toStringAsFixed(2))),
                                DataCell(
                                  PopupMenuButton<String>(
                                    icon: const Icon(Icons.more_horiz),
                                    onSelected: (action) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('$action on ${o.ticker}')),
                                      );
                                    },
                                    itemBuilder: (_) => const [
                                      PopupMenuItem(
                                          value: 'Edit',
                                          child: Text('Edit Order')),
                                      PopupMenuItem(
                                          value: 'Cancel',
                                          child: Text('Cancel Order')),
                                    ],
                                  ),
                                ),
                              ]))
                          .toList(),
                    ),
                  ),
                ),
              ),

              // Pagination controls bottom-right
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: _currentPage > 0
                            ? () => setState(() => _currentPage--)
                            : null,
                        child: const Text('Previous'),
                      ),
                      const SizedBox(width: 8),
                      Text('Page ${_currentPage + 1} of $totalPages'),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: _currentPage < totalPages - 1
                            ? () => setState(() => _currentPage++)
                            : null,
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
