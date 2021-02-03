package com.flutter.communication;

import java.util.ArrayList;
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
public class PluginCenterImpl implements IPluginCenter {
    private List<Object> plugins = new ArrayList<>();


    @Override
    public void addPigeonPlugin(Object object) {
        if (!plugins.contains(object)) {
            plugins.add(object);
        }
    }

    @Override
    public void remotePigeonPlugin(Object object) {
        if (plugins.contains(object)) {
            plugins.remove(object);
        }
    }

    @Override
    public List<Object> getAllPigeon() {
        return plugins;
    }
}
