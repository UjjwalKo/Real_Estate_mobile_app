// add_property_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPropertyScreen extends StatefulWidget {
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imageController = TextEditingController();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _squareFeetController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _bathroomsController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _descriptionController = TextEditingController(); // New field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _imageController,
                  decoration: InputDecoration(labelText: 'Image URL'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an image URL';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _squareFeetController,
                  decoration: InputDecoration(labelText: 'Square Feet'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter square feet';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bedroomsController,
                  decoration: InputDecoration(labelText: 'Bedrooms'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the number of bedrooms';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bathroomsController,
                  decoration: InputDecoration(labelText: 'Bathrooms'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the number of bathrooms';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _contactController,
                  decoration: InputDecoration(labelText: 'Contact Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a contact number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController, // New field
                  decoration: InputDecoration(labelText: 'Description'),
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final user = FirebaseAuth.instance.currentUser;
                      await FirebaseFirestore.instance
                          .collection('properties')
                          .add({
                        'image': _imageController.text,
                        'title': _titleController.text,
                        'price': _priceController.text,
                        'squareFeet': _squareFeetController.text,
                        'bedrooms': _bedroomsController.text,
                        'bathrooms': _bathroomsController.text,
                        'address': _addressController.text,
                        'contact': _contactController.text,
                        'description': _descriptionController.text, // New field
                        'createdBy': user?.uid,
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add Property'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
