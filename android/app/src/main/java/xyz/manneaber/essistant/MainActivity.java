package xyz.manneaber.essistant;

import android.graphics.drawable.Drawable;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.DrawableSplashScreen;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterFragment;
import io.flutter.embedding.android.SplashScreen;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
  }

  public class MainFragment extends FlutterFragment {
    @Override
    public SplashScreen provideSplashScreen() {
      // Load the splash Drawable.
      Drawable splash = getResources().getDrawable(R.drawable.launch_background, getResources().newTheme());

      // Construct a DrawableSplashScreen with the loaded splash Drawable and
      // return it.
      return new DrawableSplashScreen(splash);
    }
  }
}
