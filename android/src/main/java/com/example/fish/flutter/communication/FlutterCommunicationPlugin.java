package com.flutter.communication;

import androidx.annotation.NonNull;

import com.flutter.communication.RouterManager;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * PigeonPlugin
 */
public class FlutterCommunicationPlugin implements FlutterPlugin {

    private RouterManager.FlutterRouterManager routerManager;

    public FlutterCommunicationPlugin() {

    }

    public FlutterCommunicationPlugin(RouterManager.FlutterRouterManager routerManager) {
        this.routerManager = routerManager;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        // 注册Pigeon实现类
        if (routerManager != null) {
            RouterManager.FlutterRouterManager.setup(flutterPluginBinding.getBinaryMessenger(), routerManager);
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }

}
