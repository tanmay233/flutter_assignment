import '../models/order.dart';

class MockData {
  static List<Order> getOrders() => [
        Order(
          time: '09:15:30',
          client: 'AAA001',
          ticker: 'RELIANCE',
          side: 'Buy',
          product: 'CNC',
          executed: 50,
          total: 100,
          price: 250.50,
        ),
        Order(
          time: '09:16:10',
          client: 'AAA002',
          ticker: 'TCS',
          side: 'Sell',
          product: 'MIS',
          executed: 30,
          total: 30,
          price: 3200.75,
        ),
        Order(
          time: '09:17:45',
          client: 'AAA003',
          ticker: 'HDFC BANK',
          side: 'Buy',
          product: 'NRML',
          executed: 20,
          total: 50,
          price: 1575.00,
        ),
        Order(
          time: '09:18:22',
          client: 'AAA004',
          ticker: 'INFOSYS',
          side: 'Sell',
          product: 'CNC',
          executed: 10,
          total: 10,
          price: 1420.40,
        ),
        Order(
          time: '09:19:05',
          client: 'AAA005',
          ticker: 'ICICI BANK',
          side: 'Buy',
          product: 'MIS',
          executed: 25,
          total: 25,
          price: 920.10,
        ),
        // …add as many realistic rows as you like
      ];
}
