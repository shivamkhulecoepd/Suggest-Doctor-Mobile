import 'package:flutter/material.dart';
import '../../core/constants.dart';

class HealthFeedScreen extends StatefulWidget {
  const HealthFeedScreen({super.key});

  @override
  State<HealthFeedScreen> createState() => _HealthFeedScreenState();
}

class _HealthFeedScreenState extends State<HealthFeedScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Feed', 'Symptom Checker'];

  // Sample data
  final List<HealthArticle> _articles = [
    HealthArticle(
      id: '1',
      title: '10 Ways to Maintain a Healthy Heart',
      excerpt:
          'Learn simple lifestyle changes that can significantly improve your heart health and reduce the risk of cardiovascular diseases.',
      readTime: '5 min read',
      category: 'Cardiology',
      isDoctorVerified: true,
      imageUrl: '',
      date: 'Nov 18, 2023',
      isBookmarked: false,
    ),
    HealthArticle(
      id: '2',
      title: 'Understanding Common Cold vs Flu',
      excerpt:
          'How to distinguish between a common cold and the flu, and when you should seek medical attention.',
      readTime: '3 min read',
      category: 'General Health',
      isDoctorVerified: true,
      imageUrl: '',
      date: 'Nov 15, 2023',
      isBookmarked: true,
    ),
    HealthArticle(
      id: '3',
      title: 'The Importance of Regular Health Checkups',
      excerpt:
          'Why regular health screenings are crucial for early detection and prevention of serious health conditions.',
      readTime: '4 min read',
      category: 'Preventive Care',
      isDoctorVerified: false,
      imageUrl: '',
      date: 'Nov 12, 2023',
      isBookmarked: false,
    ),
    HealthArticle(
      id: '4',
      title: 'Managing Stress in the Digital Age',
      excerpt:
          'Effective techniques to manage stress and maintain mental well-being in our increasingly connected world.',
      readTime: '6 min read',
      category: 'Mental Health',
      isDoctorVerified: true,
      imageUrl: '',
      date: 'Nov 10, 2023',
      isBookmarked: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleBookmark(HealthArticle article) {
    setState(() {
      article.isBookmarked = !article.isBookmarked;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          article.isBookmarked 
              ? 'Article bookmarked' 
              : 'Bookmark removed',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Open search
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search functionality coming soon')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab bar
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingMd,
              vertical: AppConstants.spacingSm,
            ),
            child: TabBar(
              controller: _tabController,
              tabs: _tabs.map((String name) => Tab(text: name)).toList(),
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingMd,
              ),
            ),
          ),

          // Tab bar view
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFeedTab(),
                _buildSymptomCheckerTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh articles
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          // Featured article
          _buildFeaturedArticle(_articles[0]),
          const SizedBox(height: AppConstants.spacingMd),
          
          // Article list
          ..._articles.skip(1).map((article) {
            return _buildArticleCard(article);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSymptomCheckerTab() {
    return const SymptomCheckerScreen();
  }

  Widget _buildFeaturedArticle(HealthArticle article) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Article image placeholder
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Center(
              child: Icon(
                Icons.article,
                size: 60,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          
          // Article content
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingSm,
                    vertical: AppConstants.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                  ),
                  child: Text(
                    article.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingXs),
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppConstants.spacingXs),
                Row(
                  children: [
                    Text(
                      article.readTime,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                    const SizedBox(width: AppConstants.spacingSm),
                    if (article.isDoctorVerified)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingSm,
                          vertical: AppConstants.spacingXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                        ),
                        child: const Text(
                          'Doctor Verified',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          
          // Bookmark button
          Positioned(
            top: AppConstants.spacingMd,
            right: AppConstants.spacingMd,
            child: IconButton(
              icon: Icon(
                article.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: Colors.white,
              ),
              onPressed: () => _toggleBookmark(article),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(HealthArticle article) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Article image placeholder
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusMd),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.article,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          
          // Article content
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spacingSm,
                        vertical: AppConstants.spacingXs,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                      ),
                      child: Text(
                        article.category,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        article.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      ),
                      onPressed: () => _toggleBookmark(article),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppConstants.spacingXs),
                
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                
                const SizedBox(height: AppConstants.spacingXs),
                
                Text(
                  article.excerpt,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: AppConstants.spacingMd),
                
                Row(
                  children: [
                    Text(
                      article.date,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    const SizedBox(width: AppConstants.spacingSm),
                    Text(
                      article.readTime,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    const Spacer(),
                    if (article.isDoctorVerified)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingSm,
                          vertical: AppConstants.spacingXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                        ),
                        child: const Text(
                          'Doctor Verified',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: AppConstants.spacingMd),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Read article
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetailScreen(article: article),
                          ),
                        );
                      },
                      child: const Text('Read More'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        // Share article
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sharing article...')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HealthArticle {
  final String id;
  final String title;
  final String excerpt;
  final String readTime;
  final String category;
  final bool isDoctorVerified;
  final String imageUrl;
  final String date;
  bool isBookmarked;

  HealthArticle({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.readTime,
    required this.category,
    required this.isDoctorVerified,
    required this.imageUrl,
    required this.date,
    required this.isBookmarked,
  });
}

class ArticleDetailScreen extends StatelessWidget {
  final HealthArticle article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        actions: [
          IconButton(
            icon: Icon(
              article.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            ),
            onPressed: () {
              // Toggle bookmark
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    article.isBookmarked 
                        ? 'Bookmark removed' 
                        : 'Article bookmarked',
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share article
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing article...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article image placeholder
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
              child: Center(
                child: Icon(
                  Icons.article,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            
            const SizedBox(height: AppConstants.spacingMd),
            
            // Article metadata
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingSm,
                    vertical: AppConstants.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                  ),
                  child: Text(
                    article.category,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.spacingSm),
                if (article.isDoctorVerified)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingSm,
                      vertical: AppConstants.spacingXs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                    ),
                    child: const Text(
                      'Doctor Verified',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: AppConstants.spacingMd),
            
            // Article title
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            
            const SizedBox(height: AppConstants.spacingSm),
            
            // Article date and read time
            Text(
              '${article.date} • ${article.readTime}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            
            const SizedBox(height: AppConstants.spacingLg),
            
            // Article content
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\n'
              'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n'
              'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.\n\n'
              'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.\n\n'
              'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            
            const SizedBox(height: AppConstants.spacingLg),
            
            // Disclaimer
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.warning,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: AppConstants.spacingSm),
                      Text(
                        'Disclaimer',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                  const Text(
                    'This article is for informational purposes only and does not constitute medical advice. Always consult with a qualified healthcare professional for diagnosis and treatment of any medical condition.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppConstants.spacingLg),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Save article
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Article saved')),
                      );
                    },
                    child: const Text('Save Article'),
                  ),
                ),
                const SizedBox(width: AppConstants.spacingMd),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Share article
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sharing article...')),
                      );
                    },
                    child: const Text('Share'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  int _currentStep = 0;
  final List<String> _symptoms = [];
  String _severity = 'Mild';
  bool _hasRedFlags = false;
  List<String> _selectedRedFlags = [];
  String _suggestedSpecialty = '';
  String _nextStep = '';

  final List<String> _commonSymptoms = [
    'Headache',
    'Fever',
    'Cough',
    'Fatigue',
    'Nausea',
    'Chest Pain',
    'Shortness of Breath',
    'Abdominal Pain',
    'Joint Pain',
    'Skin Rash',
  ];

  final List<String> _severityOptions = ['Mild', 'Moderate', 'Severe'];

  final List<String> _redFlags = [
    'Chest pain with sweating',
    'Difficulty breathing',
    'Severe headache',
    'High fever',
    'Loss of consciousness',
    'Severe abdominal pain',
    'Persistent vomiting',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Symptom Checker',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            'Describe your symptoms and we\'ll help you understand what might be causing them and what to do next.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < 4) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  // Complete symptom check
                  _showResults();
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep--;
                  });
                }
              },
              steps: [
                Step(
                  title: const Text('Describe Symptoms'),
                  content: _buildSymptomSelection(),
                  isActive: _currentStep == 0,
                  state: _currentStep > 0 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Severity'),
                  content: _buildSeveritySelection(),
                  isActive: _currentStep == 1,
                  state: _currentStep > 1 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Red Flags'),
                  content: _buildRedFlagSelection(),
                  isActive: _currentStep == 2,
                  state: _currentStep > 2 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Additional Info'),
                  content: _buildAdditionalInfo(),
                  isActive: _currentStep == 3,
                  state: _currentStep > 3 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Results'),
                  content: _buildResults(),
                  isActive: _currentStep == 4,
                  state: StepState.indexed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select your symptoms:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Wrap(
          spacing: AppConstants.spacingXs,
          runSpacing: AppConstants.spacingXs,
          children: _commonSymptoms.map((symptom) {
            return FilterChip(
              label: Text(symptom),
              selected: _symptoms.contains(symptom),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _symptoms.add(symptom);
                  } else {
                    _symptoms.remove(symptom);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Other symptoms...',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              setState(() {
                _symptoms.add(value.trim());
              });
            }
          },
        ),
        const SizedBox(height: AppConstants.spacingMd),
        if (_symptoms.isNotEmpty)
          Text(
            'Selected: ${_symptoms.join(', ')}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          ),
      ],
    );
  }

  Widget _buildSeveritySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How severe are your symptoms?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        ..._severityOptions.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: _severity,
            onChanged: (value) {
              setState(() {
                _severity = value!;
              });
            },
          );
        }).toList(),
        const SizedBox(height: AppConstants.spacingMd),
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Severity Guide:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppConstants.spacingSm),
              const Text(
                '• Mild: Symptoms are manageable and not interfering with daily activities\n'
                '• Moderate: Symptoms are bothersome and affect some daily activities\n'
                '• Severe: Symptoms are intense and significantly impact daily life',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRedFlagSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Do you have any of these warning signs?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        ..._redFlags.map((flag) {
          return CheckboxListTile(
            title: Text(flag),
            value: _selectedRedFlags.contains(flag),
            onChanged: (value) {
              setState(() {
                if (value!) {
                  _selectedRedFlags.add(flag);
                } else {
                  _selectedRedFlags.remove(flag);
                }
                _hasRedFlags = _selectedRedFlags.isNotEmpty;
              });
            },
          );
        }).toList(),
        const SizedBox(height: AppConstants.spacingMd),
        if (_hasRedFlags)
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                const SizedBox(width: AppConstants.spacingSm),
                Expanded(
                  child: Text(
                    'You have selected warning signs that require immediate medical attention. Consider seeking emergency care.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.red,
                        ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildAdditionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How long have you had these symptoms?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'e.g., 2 days, 1 week',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Text(
          'Have you taken any medications?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'List any medications taken...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildResults() {
    // Determine suggested specialty and next steps based on symptoms
    _determineResults();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Based on your symptoms:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        
        // Suggested specialty
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          child: Row(
            children: [
              Icon(
                Icons.local_hospital,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Suggested Specialty',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      _suggestedSpecialty,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: AppConstants.spacingMd),
        
        // Next steps
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.directions,
                color: Colors.green,
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next Steps',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      _nextStep,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: AppConstants.spacingMd),
        
        // Disclaimer
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.warning,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: AppConstants.spacingSm),
                  Text(
                    'Important Disclaimer',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingSm),
              const Text(
                'This symptom checker is not a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition.',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _determineResults() {
    // Simple logic to determine specialty and next steps
    if (_symptoms.contains('Headache') && _hasRedFlags) {
      _suggestedSpecialty = 'Neurologist';
      _nextStep = 'Seek immediate medical attention at the emergency room';
    } else if (_symptoms.contains('Chest Pain') || _symptoms.contains('Shortness of Breath')) {
      _suggestedSpecialty = 'Cardiologist';
      _nextStep = 'Book an appointment with a cardiologist within 24 hours';
    } else if (_symptoms.contains('Fever') && _severity == 'Severe') {
      _suggestedSpecialty = 'General Physician';
      _nextStep = 'Book an appointment with a general physician today';
    } else if (_symptoms.contains('Skin Rash')) {
      _suggestedSpecialty = 'Dermatologist';
      _nextStep = 'Book an appointment with a dermatologist within a week';
    } else {
      _suggestedSpecialty = 'General Physician';
      _nextStep = 'Monitor symptoms and book an appointment if they worsen';
    }
  }

  void _showResults() {
    // Determine results and show them
    _determineResults();
    
    setState(() {
      _currentStep = 4;
    });
  }
}