import 'package:flutter/material.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = [
    'Travel destinations',
    'Photography tips',
    'Healthy recipes',
    'Workout routines',
  ];
  final List<String> _trendingSearches = [
    'Summer vacation',
    'Digital marketing',
    'Home decor',
    'Financial advice',
    'Tech gadgets',
  ];
  List<String> _searchResults = [];
  bool _isSearching = false;

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
      return;
    }

    // Simulate search results
    setState(() {
      _isSearching = true;
      _searchResults = List.generate(
        10,
            (index) => 'Result for "$query" - Item ${index + 1}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: _performSearch,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              _performSearch('');
            },
          ),
        ],
      ),
      body: _isSearching
          ? ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.search),
            title: Text(_searchResults[index]),
            onTap: () {
              // Handle search result tap
            },
          );
        },
      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _recentSearches.map((search) {
                return Chip(
                  label: Text(search),
                  deleteIcon: const Icon(Icons.close, size: 16),
                  onDeleted: () {
                    setState(() {
                      _recentSearches.remove(search);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Trending Now',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: _trendingSearches.map((search) {
                return ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: Text(search),
                  onTap: () {
                    _searchController.text = search;
                    _performSearch(search);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}