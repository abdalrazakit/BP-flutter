package com.yesilkalacal.final_project


import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingService

class Application : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
    }

    override fun registerWith(registry: PluginRegistry?) {
        registry?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin");
    }
}