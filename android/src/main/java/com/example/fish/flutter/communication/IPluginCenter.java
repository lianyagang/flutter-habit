package com.flutter.communication;


import java.util.List;

interface IPluginCenter {

    /**
     * 添加鸽子生成的实现类
     */
    void addPigeonPlugin(Object object);


    /**
     * 移除鸽子生成的实现类
     */
    void remotePigeonPlugin(Object object);


    /**
     * 获取所有的插件
     *
     * @return
     */
    List<Object> getAllPigeon();
}
