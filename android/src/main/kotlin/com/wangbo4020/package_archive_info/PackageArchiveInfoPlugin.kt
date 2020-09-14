package com.wangbo4020.package_archive_info

import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*

/** PackageArchiveInfoPlugin */
public class PackageArchiveInfoPlugin: FlutterPlugin, MethodCallHandler {

  companion object {

    @JvmStatic
    fun getLongVersionCode(info: PackageInfo): Long {
      return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
        info.longVersionCode
      } else info.versionCode.toLong()
    }
  }

  private lateinit var context : Context
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.wangbo4020/package_archive_info")
    channel.setMethodCallHandler(this);
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPackageArchiveInfo") {

      val filePath = call.argument<String>("archiveFilePath")

      if (filePath == null) {
        result.error("Invalid", "archiveFilePath must not be null", null)
        return
      }

      val pm: PackageManager = context.packageManager
      val info = pm.getPackageArchiveInfo(filePath, 0)

      if (info == null) {
        result.error("Invalid", "Package parse error", filePath)
        return
      }

      val map: MutableMap<String, String> = HashMap()
      map["appName"] = info.applicationInfo.loadLabel(pm).toString()
      map["packageName"] = info.packageName
      map["version"] = info.versionName
      map["buildNumber"] = getLongVersionCode(info).toString()

      result.success(map)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
