import 'dart:io';

import 'package:essistant/repository/SecureStorage.dart';
import 'package:googleapis/drive/v3.dart' as gd;
import 'package:googleapis_auth/auth_io.dart';
import "package:http/http.dart" as http;
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

const _clientID = "258895982335-jnr82p5g5gt1i6h8ni16uhst6iottlk8.apps.googleusercontent.com";
const _clientSecret = "WejuJ0J7umZNWVnKj6xyN_-1";
const _scopes = const [gd.DriveApi.DriveAppdataScope];

class GoogleDriveRepository {
  final storage = SecureStorage();
  
  //Get Authenticated Http Client
  Future<http.Client> _getHttpClient() async {
    //Get Credentials
    var credentials = await storage.getCredentials();
    if (credentials == null) {
      //Needs user authentication
      var authClient = await clientViaUserConsent(
          ClientId(_clientID, _clientSecret), _scopes, (url) {
        //Open Url in Browser
        launch(url);
      });
      //Save Credentials
      await storage.saveCredentials(authClient.credentials.accessToken,
          authClient.credentials.refreshToken);
      return authClient;
    } else {
      print(credentials["expiry"]);
      //Already authenticated
      return authenticatedClient(
          http.Client(),
          AccessCredentials(
              AccessToken(credentials["type"], credentials["data"],
                  DateTime.tryParse(credentials["expiry"])),
              credentials["refreshToken"],
              _scopes));
    }
  }

  Future<bool> isAuthorized() async {
    var credentials = await storage.getCredentials();

    return credentials != null;
  }

  Future login() async {
    await _getHttpClient();
  }

  //Upload File
  Future upload(File file) async {
    var client = await _getHttpClient();
    var drive = gd.DriveApi(client);
    print("Uploading file");
    var response = await drive.files.create(
        gd.File()..name = basename(file.absolute.path),
        uploadMedia: gd.Media(file.openRead(), file.lengthSync()));

    print("Result ${response.toJson()}");
  }
}
