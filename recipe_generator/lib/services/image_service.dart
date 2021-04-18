import 'dart:convert';
import 'dart:io';

import 'package:unsplash_client/unsplash_client.dart';

const accessKey = String.fromEnvironment("UNSPLASH_ACCESS_KEY");
const secretKey = String.fromEnvironment("UNSPLASH_SECRET_KEY");

Future<String> fetchImageUrl(String recipeName) async {
  // Load app credentials from environment variables
  var appCredentials = loadAppCredentialsFromEnv();

  // Create a client.
  final client = UnsplashClient(
    settings: ClientSettings(credentials: appCredentials),
  );

  // Fetch a photo
  String url = "https://img.chefkoch-cdn.de/rezepte/807111184564987/bilder/668266/crop-960x720/spaghetti-bolognese.jpg"; // Standard image
  try{
    final photos = await client.search.photos(recipeName, page: 1, perPage: 1).goAndGet();
    // URL
    url = photos.results[0].urls.regular.toString();
  } on Exception catch(e) {
     print(e);
  }

  // Close the client when it is done being used to clean up allocate resources
  client.close();

  return url;
}

/// Loads [AppCredentials] from environment variables
/// Returns `null` if the variables do not exist.
AppCredentials loadAppCredentialsFromEnv() {
    return AppCredentials(
      accessKey: accessKey,
      secretKey: secretKey,
    );
}
