package com.flutter.communication;

import java.util.List;

/**
 * <pre>
 *     author : 刘辉良
 *     e-mail :
 *     time   : 2021/01/06
 *     desc   :
 *     version: 1.0
 * </pre>
 */
public class PluginCenterDelegate implements IPluginCenter {

    final static PluginCenterDelegate instance = new PluginCenterDelegate();

    final IPluginCenter center = new PluginCenterImpl();


    public static PluginCenterDelegate getInstance() {
        return instance;
    }


    @Override
    public void addPigeonPlugin(Object object) {
        center.addPigeonPlugin(object);
    }

    @Override
    public void remotePigeonPlugin(Object object) {
        center.remotePigeonPlugin(object);
    }

    @Override
    public List<Object> getAllPigeon() {
        return center.getAllPigeon();
    }
}
