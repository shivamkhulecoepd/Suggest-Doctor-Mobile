import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../core/responsive.dart';
import '../widgets/network_image_widget.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final int reviewCount;
  final String experience;
  final double consultationFee;
  final bool isOnline;
  final String? imageUrl;
  final VoidCallback onTap;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    required this.experience,
    required this.consultationFee,
    required this.isOnline,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: Responsive.spacing(context, AppConstants.spacingSm)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Responsive.size(context, AppConstants.radiusLg)),
        child: Padding(
          padding: EdgeInsets.all(Responsive.spacing(context, AppConstants.spacingMd)),
          child: Row(
            children: [
              // Doctor avatar with network image support
              Stack(
                children: [
                  NetworkImageWidget(
                    imageUrl: imageUrl ?? 'https://via.placeholder.com/150',
                    width: Responsive.size(context, 60),
                    height: Responsive.size(context, 60),
                    isCircle: true,
                  ),
                  if (isOnline)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: Responsive.size(context, 16),
                        height: Responsive.size(context, 16),
                        decoration: BoxDecoration(
                          color: LightColors.success,
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: Responsive.size(context, 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: Responsive.spacing(context, AppConstants.spacingMd)),
              
              // Doctor info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.verified,
                          color: LightColors.primary,
                          size: Responsive.size(context, 16),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.spacing(context, 4)),
                    Text(
                      specialty,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                        color: LightColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: Responsive.spacing(context, 4)),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: Responsive.size(context, 16),
                        ),
                        SizedBox(width: Responsive.spacing(context, 4)),
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 14),
                          ),
                        ),
                        SizedBox(width: Responsive.spacing(context, 4)),
                        Text(
                          '($reviewCount)',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 12),
                            color: LightColors.textSecondary,
                          ),
                        ),
                        SizedBox(width: Responsive.spacing(context, 8)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.spacing(context, 6),
                            vertical: Responsive.spacing(context, 2),
                          ),
                          decoration: BoxDecoration(
                            color: LightColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(Responsive.size(context, 8)),
                          ),
                          child: Text(
                            experience,
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 12),
                              color: LightColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Consultation info
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${consultationFee.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 16),
                      fontWeight: FontWeight.bold,
                      color: LightColors.primary,
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 4)),
                  Text(
                    'Consultation',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 8)),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.spacing(context, 12),
                        vertical: Responsive.spacing(context, 8),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Responsive.size(context, 8)),
                      ),
                      minimumSize: Size(
                        Responsive.size(context, 60),
                        Responsive.size(context, 30),
                      ),
                    ),
                    child: Text(
                      'Book',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}