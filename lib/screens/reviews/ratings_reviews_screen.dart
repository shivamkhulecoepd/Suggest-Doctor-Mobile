import 'package:flutter/material.dart';
import '../../core/constants.dart';

class RatingsReviewsScreen extends StatefulWidget {
  final String providerName;
  final String providerSpecialty;
  final IconData providerIcon;

  const RatingsReviewsScreen({
    super.key,
    required this.providerName,
    required this.providerSpecialty,
    required this.providerIcon,
  });

  @override
  State<RatingsReviewsScreen> createState() => _RatingsReviewsScreenState();
}

class _RatingsReviewsScreenState extends State<RatingsReviewsScreen> {
  double _rating = 0.0;
  final List<CategoryRating> _categoryRatings = [
    CategoryRating(category: 'Diagnosis', rating: 0.0),
    CategoryRating(category: 'Behavior', rating: 0.0),
    CategoryRating(category: 'Waiting Time', rating: 0.0),
    CategoryRating(category: 'Facility', rating: 0.0),
    CategoryRating(category: 'Value', rating: 0.0),
  ];
  final TextEditingController _reviewController = TextEditingController();
  bool _isAnonymous = false;
  String? _selectedPhoto;
  final List<ReviewTag> _selectedTags = [];

  // Sample existing reviews
  final List<Review> _existingReviews = [
    Review(
      id: '1',
      userName: 'John Smith',
      rating: 4.5,
      categories: [
        CategoryRating(category: 'Diagnosis', rating: 5.0),
        CategoryRating(category: 'Behavior', rating: 4.0),
        CategoryRating(category: 'Waiting Time', rating: 4.0),
      ],
      comment:
          'Dr. Johnson was very thorough in her examination and explained everything clearly. The only downside was the waiting time.',
      date: 'Nov 15, 2023',
      helpful: 12,
      tags: ['Helpful', 'Professional'],
      isVerified: true,
    ),
    Review(
      id: '2',
      userName: 'Sarah Johnson',
      rating: 5.0,
      categories: [
        CategoryRating(category: 'Diagnosis', rating: 5.0),
        CategoryRating(category: 'Behavior', rating: 5.0),
        CategoryRating(category: 'Waiting Time', rating: 5.0),
      ],
      comment:
          'Excellent experience! Dr. Johnson is knowledgeable and caring. Would definitely recommend to others.',
      date: 'Nov 10, 2023',
      helpful: 8,
      tags: ['Highly Recommend', 'Professional'],
      isVerified: true,
    ),
    Review(
      id: '3',
      userName: 'Robert Wilson',
      rating: 3.5,
      categories: [
        CategoryRating(category: 'Diagnosis', rating: 4.0),
        CategoryRating(category: 'Behavior', rating: 3.0),
        CategoryRating(category: 'Waiting Time', rating: 3.0),
      ],
      comment:
          'The consultation was okay, but I felt rushed. The doctor seemed busy and didn\'t spend much time with me.',
      date: 'Nov 5, 2023',
      helpful: 3,
      tags: ['Average Experience'],
      isVerified: false,
    ),
  ];

  final List<ReviewTag> _availableTags = [
    ReviewTag(name: 'Helpful', color: Colors.green),
    ReviewTag(name: 'Professional', color: Colors.blue),
    ReviewTag(name: 'Knowledgeable', color: Colors.purple),
    ReviewTag(name: 'Friendly', color: Colors.orange),
    ReviewTag(name: 'Punctual', color: Colors.teal),
    ReviewTag(name: 'Highly Recommend', color: Colors.green),
    ReviewTag(name: 'Average Experience', color: Colors.grey),
    ReviewTag(name: 'Not Satisfied', color: Colors.red),
  ];

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    if (_rating == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide an overall rating')),
      );
      return;
    }

    if (_reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write a review comment')),
      );
      return;
    }

    // In a real app, you would submit the review to the server
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Review submitted successfully!')),
    );

    // Reset form
    setState(() {
      _rating = 0.0;
      for (var category in _categoryRatings) {
        category.rating = 0.0;
      }
      _reviewController.clear();
      _isAnonymous = false;
      _selectedPhoto = null;
      _selectedTags.clear();
    });
  }

  void _toggleTag(ReviewTag tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Rate ${widget.providerName}'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Write Review'),
              Tab(text: 'Reviews'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildWriteReviewTab(),
            _buildReviewsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildWriteReviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Provider info
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.providerIcon,
                    color: Theme.of(context).primaryColor,
                    size: AppConstants.iconLg,
                  ),
                ),
                const SizedBox(width: AppConstants.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.providerName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        widget.providerSpecialty,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // Overall rating
          Text(
            'Overall Rating',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildStarRating(
            rating: _rating,
            onRatingChanged: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // Category ratings
          Text(
            'Category Ratings',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ..._categoryRatings.map((category) {
            return _buildCategoryRating(category);
          }).toList(),

          const SizedBox(height: AppConstants.spacingLg),

          // Review comment
          Text(
            'Your Review',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          TextFormField(
            controller: _reviewController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Share your experience with ${widget.providerName}...',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // Review tags
          Text(
            'Tags',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Wrap(
            spacing: AppConstants.spacingXs,
            runSpacing: AppConstants.spacingXs,
            children: _availableTags.map((tag) {
              return FilterChip(
                label: Text(tag.name),
                selected: _selectedTags.contains(tag),
                onSelected: (selected) => _toggleTag(tag),
                selectedColor: tag.color.withOpacity(0.2),
                checkmarkColor: tag.color,
              );
            }).toList(),
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // Photo upload
          Text(
            'Add Photo',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            child: _selectedPhoto == null
                ? IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: () {
                      // In a real app, you would open the image picker
                      setState(() {
                        _selectedPhoto = 'sample_photo.jpg';
                      });
                    },
                  )
                : Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/placeholder.png',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () {
                            setState(() {
                              _selectedPhoto = null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // Anonymous toggle
          SwitchListTile(
            title: const Text('Post Anonymously'),
            subtitle: const Text('Your name will not be visible in the review'),
            value: _isAnonymous,
            onChanged: (value) {
              setState(() {
                _isAnonymous = value;
              });
            },
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // Review guidelines
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review Guidelines',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingXs),
                const Text(
                  '• Be honest and respectful\n'
                  '• Focus on the experience\n'
                  '• Avoid personal attacks\n'
                  '• Do not include personal information\n'
                  '• Reviews with inappropriate content will be removed',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // Submit button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitReview,
              child: const Text('Submit Review'),
            ),
          ),

          const SizedBox(height: AppConstants.spacingMd),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh reviews
        await Future.delayed(const Duration(seconds: 1));
      },
      child: _existingReviews.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.rate_review,
                    size: 80,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  Text(
                    'No reviews yet',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                  Text(
                    'Be the first to review ${widget.providerName}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              itemCount: _existingReviews.length,
              itemBuilder: (context, index) {
                return _buildReviewCard(_existingReviews[index]);
              },
            ),
    );
  }

  Widget _buildStarRating({
    required double rating,
    required Function(double) onRatingChanged,
  }) {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () => onRatingChanged(index + 1.0),
        );
      }),
    );
  }

  Widget _buildCategoryRating(CategoryRating category) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              category.category,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < category.rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: AppConstants.iconSm,
                  ),
                  onPressed: () {
                    setState(() {
                      category.rating = index + 1.0;
                    });
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
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
          // User info
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.isAnonymous ? 'Anonymous' : review.userName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (review.isVerified)
                          const SizedBox(width: AppConstants.spacingXs),
                        if (review.isVerified)
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      review.date,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                  ],
                ),
              ),
              _buildStarRatingDisplay(review.rating),
            ],
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Category ratings
          if (review.categories.isNotEmpty) ...[
            Wrap(
              spacing: AppConstants.spacingMd,
              runSpacing: AppConstants.spacingXs,
              children: review.categories.map((category) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      category.category,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    const SizedBox(width: AppConstants.spacingXs),
                    _buildStarRatingDisplay(category.rating),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: AppConstants.spacingMd),
          ],

          // Review comment
          Text(
            review.comment,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Tags
          if (review.tags.isNotEmpty) ...[
            Wrap(
              spacing: AppConstants.spacingXs,
              runSpacing: AppConstants.spacingXs,
              children: review.tags.map((tag) {
                final tagData = _availableTags.firstWhere(
                  (t) => t.name == tag,
                  orElse: () => ReviewTag(name: tag, color: Colors.grey),
                );
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingSm,
                    vertical: AppConstants.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: tagData.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: tagData.color,
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppConstants.spacingMd),
          ],

          // Helpful and actions
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.thumb_up),
                onPressed: () {
                  // Mark as helpful
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Marked as helpful')),
                  );
                },
              ),
              Text('${review.helpful} found helpful'),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.flag),
                onPressed: () {
                  // Report review
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reporting review...')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStarRatingDisplay(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: AppConstants.iconSm,
        ),
      ],
    );
  }
}

class CategoryRating {
  final String category;
  double rating;

  CategoryRating({
    required this.category,
    required this.rating,
  });
}

class Review {
  final String id;
  final String userName;
  final double rating;
  final List<CategoryRating> categories;
  final String comment;
  final String date;
  final int helpful;
  final List<String> tags;
  final bool isVerified;
  final bool isAnonymous;

  Review({
    required this.id,
    required this.userName,
    required this.rating,
    required this.categories,
    required this.comment,
    required this.date,
    required this.helpful,
    required this.tags,
    this.isVerified = false,
    this.isAnonymous = false,
  });
}

class ReviewTag {
  final String name;
  final Color color;

  ReviewTag({
    required this.name,
    required this.color,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReviewTag && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}