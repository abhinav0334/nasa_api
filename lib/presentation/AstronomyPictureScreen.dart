import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AstronomyPictureState.dart';
class AstronomyPictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // NASA Logo
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                elevation: 4, // Shadow effect
                color: Colors.white, // Card background color
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Padding inside the card
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Rounded edges for the image
                    child: Image.asset(
                      'assets/images/nasa.png', // Ensure nasa.png is in your assets folder
                      height: 100,
                      width: 100, // Ensure the image remains square
                      fit: BoxFit.cover, // Ensures the image fits properly
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: BlocConsumer<AstronomyPictureCubit, AstronomyPictureState>(
                listener: (context, state) {
                  if (state is LoadedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Picture Loaded")));
                  } else if (state is ErrorState) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: Text(state.message),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text(
                            "Fetching latest picture of the day...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is LoadedState) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        color: Colors.white.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Astronomy Image
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(), // Loading Indicator
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      state.picture.imageUrl,
                                      fit: BoxFit.cover,
                                      height: 250,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return SizedBox.shrink();
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(Icons.error, size: 100, color: Colors.red);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              // Picture Title
                              Text(
                                state.picture.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              // Picture Explanation
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    state.picture.explanation,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Press the button to fetch the picture.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<AstronomyPictureCubit>().getPicture(),
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
