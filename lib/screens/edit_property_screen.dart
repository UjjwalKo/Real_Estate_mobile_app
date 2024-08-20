// edit_property_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPropertyScreen extends StatefulWidget {
  final DocumentSnapshot property;

  EditPropertyScreen({required this.property});

  @override
  _EditPropertyScreenState createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  final _formKey = GlobalKey<FormState>(); // Initialize the form key
  late TextEditingController _imageController;
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _squareFeetController;
  late TextEditingController _bedroomsController;
  late TextEditingController _bathroomsController;
  late TextEditingController _addressController;
  late TextEditingController _contactController;
  late TextEditingController _descriptionController; // New field

  @override
  void initState() {
    super.initState();
    _imageController = TextEditingController(text: widget.property['image']);
    _titleController = TextEditingController(text: widget.property['title']);
    _priceController = TextEditingController(text: widget.property['price']);
    _squareFeetController =
        TextEditingController(text: widget.property['squareFeet']);
    _bedroomsController =
        TextEditingController(text: widget.property['bedrooms']);
    _bathroomsController =
        TextEditingController(text: widget.property['bathrooms']);
    _addressController =
        TextEditingController(text: widget.property['address']);
    _contactController =
        TextEditingController(text: widget.property['contact']);
    _descriptionController = TextEditingController(
        text: widget.property['description']); // New field
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Property'),
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
                  onPressed: () {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      FirebaseFirestore.instance
                          .collection('properties')
                          .doc(widget.property.id)
                          .update({
                        'image': _imageController.text,
                        'title': _titleController.text,
                        'price': _priceController.text,
                        'squareFeet': _squareFeetController.text,
                        'bedrooms': _bedroomsController.text,
                        'bathrooms': _bathroomsController.text,
                        'address': _addressController.text,
                        'contact': _contactController.text,
                        'description': _descriptionController.text, // New field
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _imageController.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _squareFeetController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _descriptionController.dispose(); // Dispose the new field
    super.dispose();
  }
}
