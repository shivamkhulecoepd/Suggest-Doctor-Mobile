import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/responsive.dart';
import '../../widgets/network_image_widget.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  
  // Sample data for demonstration
  final List<FamilyMember> _familyMembers = [
    FamilyMember(
      id: '1',
      name: 'John Smith',
      dob: '15 Jan 1985',
      relation: 'Self',
      avatar: Icons.person,
      isPrimary: true,
    ),
    FamilyMember(
      id: '2',
      name: 'Sarah Smith',
      dob: '22 Mar 2015',
      relation: 'Daughter',
      avatar: Icons.person_outline,
      isPrimary: false,
    ),
    FamilyMember(
      id: '3',
      name: 'Robert Smith',
      dob: '05 Dec 1982',
      relation: 'Spouse',
      avatar: Icons.person_outline,
      isPrimary: false,
    ),
  ];
  
  // Profile data
  String _name = 'John Smith';
  String _email = 'john.smith@example.com';
  String _phone = '+1 (555) 123-4567';
  String _dob = '15 Jan 1985';
  String _bloodType = 'O+';
  String _height = '175 cm';
  String _weight = '72 kg';
  String _medicalHistory = 'Allergic to penicillin\nHypertension';
  String _allergies = 'Penicillin, Pollen';
  String _primaryDoctor = 'Dr. Sarah Johnson';
  
  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }
  
  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully')),
      );
    }
  }
  
  void _addFamilyMember() {
    // Show dialog to add new family member
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Family Member'),
          content: const Text('Feature coming soon!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  
  void _editFamilyMember(FamilyMember member) {
    // Show dialog to edit family member
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${member.name}'),
          content: const Text('Feature coming soon!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
  
  void _removeFamilyMember(FamilyMember member) {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Family Member'),
          content: Text('Are you sure you want to remove ${member.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _familyMembers.removeWhere((m) => m.id == member.id);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit,
              size: Responsive.size(context, 24),
            ),
            onPressed: _isEditing ? _saveProfile : _toggleEditMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              padding: Responsive.adaptivePadding(context),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: Responsive.size(context, 10),
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  NetworkImageWidget(
                    imageUrl: 'https://via.placeholder.com/150',
                    width: Responsive.size(context, AppConstants.avatarLg * 2),
                    height: Responsive.size(context, AppConstants.avatarLg * 2),
                    isCircle: true,
                  ),
                  SizedBox(width: Responsive.spacing(context, AppConstants.spacingMd)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: Responsive.fontSize(context, 18),
                              ),
                        ),
                        SizedBox(height: Responsive.spacing(context, AppConstants.spacingXs)),
                        Text(
                          _email,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).textTheme.bodySmall?.color,
                                fontSize: Responsive.fontSize(context, 14),
                              ),
                        ),
                        SizedBox(height: Responsive.spacing(context, AppConstants.spacingXs)),
                        Text(
                          _phone,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).textTheme.bodySmall?.color,
                                fontSize: Responsive.fontSize(context, 14),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: Responsive.spacing(context, AppConstants.spacingLg)),
            
            // Profile Details Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.spacing(context, AppConstants.spacingLg)),
              child: Text(
                'Profile Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: Responsive.fontSize(context, 18),
                ),
              ),
            ),
            
            SizedBox(height: Responsive.spacing(context, AppConstants.spacingSm)),
            
            Container(
              margin: EdgeInsets.symmetric(horizontal: Responsive.spacing(context, AppConstants.spacingLg)),
              padding: EdgeInsets.all(Responsive.spacing(context, AppConstants.spacingMd)),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Responsive.size(context, AppConstants.radiusMd)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: Responsive.size(context, 4),
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: _isEditing ? _buildEditForm() : _buildProfileDetails(),
            ),
            
            SizedBox(height: Responsive.spacing(context, AppConstants.spacingLg)),
            
            // Family Members Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.spacing(context, AppConstants.spacingLg)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Family Members',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: Responsive.fontSize(context, 18),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add,
                      size: Responsive.size(context, 24),
                    ),
                    onPressed: _addFamilyMember,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: Responsive.spacing(context, AppConstants.spacingSm)),
            
            // Family Members List
            Container(
              margin: EdgeInsets.symmetric(horizontal: Responsive.spacing(context, AppConstants.spacingLg)),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Responsive.size(context, AppConstants.radiusMd)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: Responsive.size(context, 4),
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: _familyMembers.map((member) => _buildFamilyMemberTile(member)).toList(),
              ),
            ),
            
            SizedBox(height: Responsive.spacing(context, AppConstants.spacingLg)),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Full Name', _name),
        const Divider(),
        _buildDetailRow('Email', _email),
        const Divider(),
        _buildDetailRow('Phone', _phone),
        const Divider(),
        _buildDetailRow('Date of Birth', _dob),
        const Divider(),
        _buildDetailRow('Blood Type', _bloodType),
        const Divider(),
        _buildDetailRow('Height', _height),
        const Divider(),
        _buildDetailRow('Weight', _weight),
        const Divider(),
        _buildDetailRow('Medical History', _medicalHistory),
        const Divider(),
        _buildDetailRow('Allergies', _allergies),
        const Divider(),
        _buildDetailRow('Primary Doctor', _primaryDoctor),
      ],
    );
  }
  
  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextFormField(
            label: 'Full Name',
            initialValue: _name,
            onSaved: (value) => _name = value ?? _name,
          ),
          const Divider(),
          _buildTextFormField(
            label: 'Email',
            initialValue: _email,
            onSaved: (value) => _email = value ?? _email,
          ),
          const Divider(),
          _buildTextFormField(
            label: 'Phone',
            initialValue: _phone,
            onSaved: (value) => _phone = value ?? _phone,
          ),
          const Divider(),
          _buildTextFormField(
            label: 'Date of Birth',
            initialValue: _dob,
            onSaved: (value) => _dob = value ?? _dob,
          ),
          const Divider(),
          _buildTextFormField(
            label: 'Blood Type',
            initialValue: _bloodType,
            onSaved: (value) => _bloodType = value ?? _bloodType,
          ),
          const Divider(),
          _buildTextFormField(
            label: 'Height',
            initialValue: _height,
            onSaved: (value) => _height = value ?? _height,
          ),
          const Divider(),
          _buildTextFormField(
            label: 'Weight',
            initialValue: _weight,
            onSaved: (value) => _weight = value ?? _weight,
          ),
          const Divider(),
          _buildTextFormField(
            label: 'Medical History',
            initialValue: _medicalHistory,
            maxLines: 3,
            onSaved: (value) => _medicalHistory = value ?? _medicalHistory,
          ),
          const Divider(),
          _buildTextFormField(
            label: 'Allergies',
            initialValue: _allergies,
            onSaved: (value) => _allergies = value ?? _allergies,
          ),
          const Divider(),
          _buildTextFormField(
            label: 'Primary Doctor',
            initialValue: _primaryDoctor,
            onSaved: (value) => _primaryDoctor = value ?? _primaryDoctor,
          ),
        ],
      ),
    );
  }
  
  Widget _buildTextFormField({
    required String label,
    required String initialValue,
    ValueChanged<String?>? onSaved,
    int maxLines = 1,
  }) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: onSaved,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.spacing(context, AppConstants.spacingXs)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Responsive.size(context, 120),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontWeight: FontWeight.w500,
                    fontSize: Responsive.fontSize(context, 14),
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: Responsive.fontSize(context, 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFamilyMemberTile(FamilyMember member) {
    return ListTile(
      leading: NetworkImageWidget(
        imageUrl: 'https://via.placeholder.com/150',
        width: Responsive.size(context, 40),
        height: Responsive.size(context, 40),
        isCircle: true,
      ),
      title: Text(
        member.name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: Responsive.fontSize(context, 16),
        ),
      ),
      subtitle: Text(
        '${member.dob} • ${member.relation}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontSize: Responsive.fontSize(context, 12),
            ),
      ),
      trailing: member.isPrimary
          ? Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.spacing(context, 8), 
                vertical: Responsive.spacing(context, 4)
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
              ),
              child: Text(
                'Primary',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Responsive.fontSize(context, 10),
                    ),
              ),
            )
          : IconButton(
              icon: Icon(Icons.more_vert,
                size: Responsive.size(context, 24),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.edit,
                              size: Responsive.size(context, 24),
                            ),
                            title: Text('Edit',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 16),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              _editFamilyMember(member);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.delete,
                              size: Responsive.size(context, 24),
                            ),
                            title: Text('Remove',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 16),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              _removeFamilyMember(member);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
      onTap: () {
        // Navigate to family member profile
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Viewing profile for ${member.name}')),
        );
      },
    );
  }
}

class FamilyMember {
  final String id;
  final String name;
  final String dob;
  final String relation;
  final IconData avatar;
  final bool isPrimary;
  
  FamilyMember({
    required this.id,
    required this.name,
    required this.dob,
    required this.relation,
    required this.avatar,
    required this.isPrimary,
  });
}