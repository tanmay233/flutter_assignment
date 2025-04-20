import 'package:flutter/material.dart';

class SearchFilters extends StatefulWidget {
  /// Lists of all possible clients and stocks
  final List<String> allClients;
  final List<String> allStocks;

  const SearchFilters({
    Key? key,
    required this.allClients,
    required this.allStocks,
  }) : super(key: key);

  @override
  _SearchFiltersState createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  final List<String> _clientFilters = [];
  final List<String> _stockFilters = [];

  void _removeClientFilter(String filter) {
    setState(() => _clientFilters.remove(filter));
  }

  void _removeStockFilter(String filter) {
    setState(() => _stockFilters.remove(filter));
  }

  void _clearAll() {
    setState(() {
      _clientFilters.clear();
      _stockFilters.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Scrollable inputs and chips
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Client Autocomplete
                SizedBox(
                  width: 150,
                  child: Autocomplete<String>(
                    optionsBuilder: (textEditingValue) {
                      final input = textEditingValue.text.toLowerCase();
                      if (input.isEmpty) return const Iterable<String>.empty();
                      return widget.allClients.where(
                        (c) => c.toLowerCase().startsWith(input),
                      );
                    },
                    onSelected: (selection) {
                      if (!_clientFilters.contains(selection)) {
                        setState(() => _clientFilters.add(selection));
                      }
                    },
                    fieldViewBuilder:
                        (context, textController, focusNode, onSubmitted) {
                      return TextField(
                        controller: textController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          labelText: 'Client ID',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.person_search),
                        ),
                        onSubmitted: (_) => onSubmitted(),
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4.0,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 200,
                              maxWidth: 150,
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final option = options.elementAt(index);
                                return ListTile(
                                  title: Text(option),
                                  onTap: () => onSelected(option),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),

                // Client Chips
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: _clientFilters
                      .map((f) => Chip(
                            label: Text(f,
                                style: const TextStyle(color: Colors.white)),
                            backgroundColor: Colors.grey[700],
                            shape: const StadiumBorder(),
                            onDeleted: () => _removeClientFilter(f),
                          ))
                      .toList(),
                ),
                const SizedBox(width: 16),

                // Stock Autocomplete
                SizedBox(
                  width: 200,
                  child: Autocomplete<String>(
                    optionsBuilder: (textEditingValue) {
                      final input = textEditingValue.text.toLowerCase();
                      if (input.isEmpty) return const Iterable<String>.empty();
                      return widget.allStocks.where(
                        (s) => s.toLowerCase().startsWith(input),
                      );
                    },
                    onSelected: (selection) {
                      if (!_stockFilters.contains(selection)) {
                        setState(() => _stockFilters.add(selection));
                      }
                    },
                    fieldViewBuilder:
                        (context, textController, focusNode, onSubmitted) {
                      return TextField(
                        controller: textController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          labelText: 'Stock, future, option',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.search),
                        ),
                        onSubmitted: (_) => onSubmitted(),
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4.0,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 200,
                              maxWidth: 200,
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final option = options.elementAt(index);
                                return ListTile(
                                  title: Text(option),
                                  onTap: () => onSelected(option),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),

                // Stock Chips
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: _stockFilters
                      .map((f) => Chip(
                            label: Text(f,
                                style: const TextStyle(color: Colors.white)),
                            backgroundColor: Colors.grey[700],
                            shape: const StadiumBorder(),
                            onDeleted: () => _removeStockFilter(f),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),

        // Clear All button at far right
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: _clearAll,
          icon: const Icon(
            Icons.cancel,
            color: Colors.white,
          ),
          label: const Text(
            'Cancel All',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }
}
