import 'package:flutter/material.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'dart:io';


class SlidingUpPanelPopup extends StatefulWidget {
  @override
  _SlidingUpPanelPopupState createState() => _SlidingUpPanelPopupState();
}

class _SlidingUpPanelPopupState extends State<SlidingUpPanelPopup>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  File image;
  bool _isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
//    )..repeat(reverse: false);
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _getImage() async {
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _isImageLoaded = true;
        image = pickedImage;
      }
    });
  }

  void _removeImage() {
    setState(() {
      _isImageLoaded = false;
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Column(
        children: <Widget>[
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.1, color: Colors.grey))),
                  child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.grey[400],
                      highlightedBorderColor: Colors.grey[400],
                      child: Text(
                        "Choisir une autre image",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        _getImage();
                      }),
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: OutlineButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.grey[300],
                    highlightedBorderColor: Colors.grey[300],
                    child: Text(
                      "Supprimer l'image",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      _removeImage();
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyImagePicker extends StatefulWidget {
  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker>
    with SingleTickerProviderStateMixin {
  File image;
  bool _isImageLoaded = false;

  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
//    )..repeat(reverse: false);
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _getImage() async {
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _isImageLoaded = true;
        image = pickedImage;
      }
    });
  }

  void _removeImage() {
    setState(() {
      _isImageLoaded = false;
      image = null;
    });
  }

  Widget _slidingUpPanelPopup(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Column(
        children: <Widget>[
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.1, color: Colors.grey))),
                  child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.grey[300],
                      highlightedBorderColor: Colors.grey[300],
                      child: Text(
                        "Choisir une autre image",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        _getImage();
                      }),
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: OutlineButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.grey[300],
                    highlightedBorderColor: Colors.grey[300],
                    child: Text(
                      "Supprimer l'image",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      _removeImage();
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.grey, width: 0.3),
          color: Colors.grey[350]),
      child: _isImageLoaded
          ? Material(
              color: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(5.0)),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Ink.image(
                    image: Image.file(image).image,
                    child: InkWell(
                      child: Center(
//                        child: Image.file(image),
                          ),
                      highlightColor: Color.fromRGBO(50, 50, 50, 0.5),
                      splashColor: Colors.transparent,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SlidingUpPanelPopup();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                elevation: 2,
                icon: Icon(
                  Icons.add_photo_alternate,
                  color: Colors.white,
                ),
                label: Text("Ajouter une image",
                    style: TextStyle(color: Colors.white)),
                onPressed: () => _getImage(),
                color: Colors.pink,
              ),
            ),
    );
  }
}
