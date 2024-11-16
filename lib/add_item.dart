import 'package:flutter/material.dart';
//import 'homepage.dart';

// import 'package:flutter/material.dart';
// import 'homepage.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  String _itemName = '';
  String _category = 'Vegetable';
  DateTime? _expiryDate;
  int _quantity = 1;
  String _notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    _itemName = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Category'),
                value: _category,
                items: <String>['Vegetable', 'Fruit', 'Meat', 'Dairy', 'Other']
                    .map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Expiry Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _expiryDate = pickedDate;
                    });
                  }
                },
                validator: (value) {
                  if (_expiryDate == null) {
                    return 'Please select an expiry date';
                  }
                  return null;
                },
                controller: TextEditingController(
                    text: _expiryDate != null
                        ? '${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}'
                        : ''),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Quantity'),
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      setState(() {
                        if (_quantity > 1) _quantity--;
                      });
                    },
                  ),
                  Text('$_quantity'),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes'),
                onChanged: (value) {
                  setState(() {
                    _notes = value;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveItem();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddItem()),
                        );
                      }
                    },
                    child: const Text('Save And Next'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveItem();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveItem() {
    // Save item data to the global items list
    items.add({
      'name': _itemName,
      'category': _category,
      'expiryDate': _expiryDate,
      'quantity': _quantity,
      'notes': _notes,
    });
  }
}

List<Map<String, dynamic>> items = [];
