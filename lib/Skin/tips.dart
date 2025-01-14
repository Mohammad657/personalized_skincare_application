import 'package:flutter/material.dart';
import 'profile.dart';

class TipsArticlesPage extends StatefulWidget {
  const TipsArticlesPage({Key? key}) : super(key: key);

  @override
  _TipsArticlesPageState createState() => _TipsArticlesPageState();
}

class _TipsArticlesPageState extends State<TipsArticlesPage> {
  List<Map<String, String>> tips = [
    {
      "title": "Hydration is Key",
      "description": "Drinking plenty of water keeps your skin hydrated and glowing. Make sure to consume at least 8 glasses of water a day.",
      "category": "Hydration",
    },
    {
      "title": "Sunscreen Every Day",
      "description": "Using sunscreen with SPF 30 or higher protects your skin from harmful UV rays and prevents premature aging.",
      "category": "Sunscreen",
    },
    {
      "title": "Gentle Cleansing",
      "description": "Avoid harsh scrubs and use gentle cleansers to maintain the natural moisture barrier of your skin.",
      "category": "Cleansing",
    },
    {
      "title": "Night Care Routine",
      "description": "Moisturize your skin before bedtime to promote overnight repair and keep your skin soft and healthy.",
      "category": "Night Care",
    },
    {
      "title": "Vitamin C Boost",
      "description": "Incorporate vitamin C serums into your skincare routine for brightening and to reduce dark spots.",
      "category": "Serums",
    },
    {
      "title": "Balanced Diet",
      "description": "A diet rich in fruits, vegetables, and omega-3 fatty acids promotes glowing, healthy skin.",
      "category": "Nutrition",
    },
    {
      "title": "Exfoliation Matters",
      "description": "Exfoliating once or twice a week helps to remove dead skin cells and reveal brighter skin. Don't overdo it!",
      "category": "Exfoliation",
    },
    {
      "title": "Sleep & Skin Health",
      "description": "Getting enough sleep is crucial for healthy skin as it allows for proper regeneration and repair.",
      "category": "Night Care",
    },
    {
      "title": "Avoid Touching Your Face",
      "description": "Touching your face can transfer bacteria and oils, leading to breakouts. Keep your hands away from your face.",
      "category": "General Care",
    },
    {
      "title": "Use Antioxidants",
      "description": "Antioxidants like vitamin E and green tea can protect your skin from environmental damage and keep it youthful.",
      "category": "Antioxidants",
    },
    {
      "title": "Hydrating Masks",
      "description": "Applying a hydrating mask once a week helps nourish your skin and provides extra moisture.",
      "category": "Hydration",
    },
    {
      "title": "Know Your Skin Type",
      "description": "Understanding your skin type (oily, dry, combination) helps you choose the right products for your skincare routine.",
      "category": "General Care",
    },
  ];

  String selectedCategory = "All";
  String searchText = "";
  int _currentIndex = 0; // Adjusted to start from the "Tips" tab
  final List<Widget> _pages = [
    const TipsArticlesPage(), // Keep TipsArticlesPage here
    const ProfilePage(), // Correctly reference ProfilePage here
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredTips = tips
        .where((tip) =>
            selectedCategory == "All" || tip["category"] == selectedCategory)
        .where((tip) =>
            tip["title"]!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 240, 243),
      appBar: AppBar(
        title: const Text(
          'Skincare Tips & Articles',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF610123),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Learn more about skincare!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF610123),
                ),
              ),
            ),
            _buildCategoryFilter(),
            _buildSearchBar(),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTips.length,
                itemBuilder: (context, index) {
                  return _buildArticleCard(
                    filteredTips[index]["title"]!,
                    filteredTips[index]["description"]!,
                    filteredTips[index]["category"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _pages[index]),
          );
        },
        backgroundColor: const Color.fromARGB(255, 97, 1, 35),
        selectedItemColor: const Color.fromARGB(255, 246, 246, 182),
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.tips_and_updates),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    List<String> categories = [
      "All",
      "Hydration",
      "Sunscreen",
      "Cleansing",
      "Night Care",
      "Serums",
      "Nutrition",
      "Exfoliation",
      "Antioxidants",
      "General Care"
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ChoiceChip(
              label: Text(
                categories[index],
                style: TextStyle(
                    color: selectedCategory == categories[index]
                        ? Colors.white
                        : Colors.black),
              ),
              selectedColor: const Color(0xFF610123),
              selected: selectedCategory == categories[index],
              onSelected: (selected) {
                setState(() {
                  selectedCategory = categories[index];
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search Tips...",
          prefixIcon: const Icon(Icons.search, color: Color(0xFF610123)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: (value) {
          Future.delayed(const Duration(milliseconds: 300), () {
            setState(() {
              searchText = value;
            });
          });
        },
      ),
    );
  }

  Widget _buildArticleCard(String title, String description, String category) {
    IconData categoryIcon;
    Color categoryColor;

    const categoryData = {
      "Hydration": Icons.water_drop,
      "Sunscreen": Icons.wb_sunny,
      "Cleansing": Icons.cleaning_services,
      "Night Care": Icons.nights_stay,
      "Serums": Icons.medication,
      "Nutrition": Icons.restaurant,
      "Exfoliation": Icons.exposure,
      "Antioxidants": Icons.shield,
      "General Care": Icons.help,
    };

    categoryIcon = categoryData[category] ?? Icons.help;
    categoryColor = _getCategoryColor(category);

    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Colors.black.withOpacity(0.2),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(categoryIcon, color: categoryColor, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: categoryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF610123),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Hydration":
        return Colors.blue;
      case "Sunscreen":
        return Colors.yellow;
      case "Cleansing":
        return Colors.green;
      case "Night Care":
        return Colors.purple;
      case "Serums":
        return Colors.orange;
      case "Nutrition":
        return Colors.red;
      case "Exfoliation":
        return Colors.cyan;
      case "Antioxidants":
        return Colors.teal;
      case "General Care":
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}
