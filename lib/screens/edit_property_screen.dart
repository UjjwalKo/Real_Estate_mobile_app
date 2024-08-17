import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditPropertyScreen extends StatefulWidget {
  final DocumentSnapshot property;

  EditPropertyScreen({required this.property});

  @override
  _EditPropertyScreenState createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _imageController;
  late TextEditingController _priceController;
  late TextEditingController _squareFeetController;
  late TextEditingController _bedroomsController;
  late TextEditingController _bathroomsController;
  late TextEditingController _addressController;
  late TextEditingController _contactController;
  late TextEditingController _titleController;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Property'),
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
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter an image URL' : null,
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a title' : null,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a price' : null,
                ),
                TextFormField(
                  controller: _squareFeetController,
                  decoration: InputDecoration(labelText: 'Square Feet'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter square feet' : null,
                ),
                TextFormField(
                  controller: _bedroomsController,
                  decoration: InputDecoration(labelText: 'Bedrooms'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter number of bedrooms' : null,
                ),
                TextFormField(
                  controller: _bathroomsController,
                  decoration: InputDecoration(labelText: 'Bathrooms'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty
                      ? 'Please enter number of bathrooms'
                      : null,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter an address' : null,
                ),
                TextFormField(
                  controller: _contactController,
                  decoration: InputDecoration(labelText: 'Contact'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a contact' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (FirebaseAuth.instance.currentUser?.uid ==
                        widget.property['createdBy']) {
                      if (_formKey.currentState!.validate()) {
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
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Property updated successfully')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'You do not have permission to edit this property')),
                      );
                    }
                  },
                  child: Text('Update Property'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
