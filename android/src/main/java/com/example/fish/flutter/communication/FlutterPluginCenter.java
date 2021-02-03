package com.flutter.communication;

import androidx.annotation.NonNull;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;

/**
 * <pre>
 *     author : 刘辉良
 *     e-mail :
 *     time   : 2021/01/06
 *     desc   : 插件注册中心
 *     version: 1.0
 * </pre>
 */
public class FlutterPluginCenter extends PluginCenterImpl implements FlutterPlugin {


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        List<Object> objects = PluginCenterDelegate.getInstance().getAllPigeon();
        for (Object object : objects) {
            try {
                if (object.getClass().getInterfaces().length > 0) {
                    Class mClass = object.getClass().getInterfaces()[0];
                    Method method = object.getClass().getMethod("setup", BinaryMessenger.class, mClass);
                    method.invoke(object, binding.getBinaryMessenger(), object);
                }
            } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        List<Object> objects = PluginCenterDelegate.getInstance().getAllPigeon();
        for (Object object : objects) {
            try {
                Method method = object.getClass().getMethod("setup", FlutterPluginBinding.class, object.getClass());
                method.invoke(object, binding, null);
            } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
                e.printStackTrace();
            }
        }
    }
}
