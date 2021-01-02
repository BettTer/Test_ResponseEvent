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
         * UI优化步骤 (整体思想: 平衡CPU与GPU的负载)
         * 1. 圆角等关于layer的操作交给CPU处理(CoreGraphics)
         * 2. UILabel替换为YYText
         * 3. 减少离屏渲染
         * 4. 异步绘制直接生成位图(实现CALayerDelegate下的display(_ layer: CALayer)并返回位图Bitmap, 即为layer.contents)
         */
        
    }
}

extension AboutOptimization {
    /// 编译
    func build() {
        /*
         * 编译流程:
         * 1. 写入辅助文件: 写入辅助文件并创建一个app包, 后面编译后的文件都会放到该包内
         * 2. 运行预设脚本: 运行在Bulid Phases中预设的脚本
         * 3. 编译文件: 对每一个文件进行编译, 生成可执行文件(即Mach-O文件). 该过程即为LLVM架构工作的完整流程: 进行词法, 语法及语义分析并生成中间代码(Clang前端) -> 代码优化(优化器) -> 生成目标文件(后端)
         * 4. 链接文件: 将多个Mach-O文件合并为一个
         * 5. 拷贝资源文件: 将项目中的资源文件拷贝到app包中
         * 6. 编译并链接storyboard文件: 同34
         * 7. 编译Asset: 将Asset中的图片文件编译为机器码
         * 8. 运行Cocoapods脚本
         * 9. 生成app包并将Swift标准库拷贝到包中
         * 10. 完成打包
         */
        
    }
    
    /// 离屏渲染
    
}
