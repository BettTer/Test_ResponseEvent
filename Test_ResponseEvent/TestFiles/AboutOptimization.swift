//
//  AboutOptimization.swift
//  Test_ResponseEvent
//
//  Created by XC_Young on 2020/12/30.
//  Copyright © 2020 Young Robine. All rights reserved.
//

import UIKit

class AboutOptimization: NSObject {
    /// 启动优化
    func start() {
        /*
         * 流程为 main函数执行前 -> 执行main函数 ->  main函数执行后
         */
        
        /*
         * 一. main函数执行前所做事情:
         * 1. 读取App的可执行文件(Mach-O文件), 并获得dyld的路径 [⚠️优化策略: 检查项目中没有用到的方法及变量等]
         * 2. 加载dyld(初始化运行环境), 加载动态链接库及可执行文件 [⚠️优化策略: 减少或者合并动态库]
         * 3. Runtime的初始处理, 如Objc相关类的注册, category注册, selector唯一性检查等
         * 4. 初始化, 如执行+load()方法, constructor修饰的函数的调用, 创建 C++ 静态全局变量等 [⚠️优化策略: 减少非必要存在+load()方法或延后执行, 控制全局变量的数量]
         * 5. dyld返回main函数地址
         */
        
        /*
         * 二. 执行main函数.
         */
        
        /*
         * 三. 执行main函数后所做事情:
         * 1. 首屏初始化所需配置文件及数据的读写操作 [⚠️优化策略: 只保留App启动必要的初始化功能, 将对应功能开始使用时才需要初始化的移到其他合适的位置]
         * 2. 渲染等
         */
        
    }
    
    /// 体积优化
    func volume() {
        /*
         * 体积优化步骤
         * 1. 删除掉项目中的无用图片资源, 其他图片资源则进行压缩, 某些图片体积过大则考虑使用webP格式替代
         * 2. 找到并删除无用代码
         */
        
    }
    
    /// 耗电优化
    func battery() {
        /*
         * 耗电优化步骤
         * 1. 找到CPU使用率较高的线程(thread_basic_info中的cpu_usage), 通过打印方法堆栈找到问题方法所在, 并作出针对性处理
         * 2. 减少非必要的文件读写操作
         * 3. 减少非必要的定位, 请求
         */
    }

    /// UI优化
    func UI() {
        /*
         * UI优化步骤
         * 1. 找到CPU使用率较高的线程(thread_basic_info中的cpu_usage), 通过打印方法堆栈找到问题方法所在, 并作出针对性处理
         * 2. 减少非必要的文件读写操作
         * 3. 减少非必要的定位, 请求
         */
    }
}
