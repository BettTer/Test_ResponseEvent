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
         * 流程为 main函数执行前 -> 执行main函数 -> main函数执行后
         */
        
        /*
         * 一. main函数执行前所做事情:
         * 1. 读取App的可执行文件(Mach-O文件), 并获得dyld的路径
            [⚠️优化策略: 检查项目中没有用到的方法及变量等]
         
         * 2. 加载dyld(初始化运行环境), 加载动态链接库及可执行文件
            [⚠️优化策略: 减少或者合并动态库]
         
         * 3. Runtime的初始处理, 如Objc相关类的注册, category注册, selector唯一性检查等
         
         * 4. 初始化, 如执行+load()方法, constructor修饰的函数的调用, 创建 C++ 静态全局变量等
            [⚠️优化策略: 减少非必要存在+load()方法或延后执行, 控制全局变量的数量]
         
         * 5. dyld返回main函数地址
         */
        
        /*
         * 二. 执行main函数.
         */
        
        /*
         * 三. 执行main函数后所做事情:
         * 1. 首屏初始化所需配置文件及数据的读写操作
            [⚠️优化策略: 只保留App启动必要的初始化功能, 将对应功能开始使用时才需要初始化的移到其他合适的位置]
         
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

extension AboutOptimization {
    /// 三次握手_TCP
    func threeTimesShakeHands_TCP() {
        /*
         * 三次握手流程:
         * 1. 客户端向服务端发起请求链接并发送SYN报文: SYN = 1, seq = x, 且客户端进入SYN_SENT状态
         
         * 2. 服务端收到请求链接后进行回复并发送响应报文: SYN = 1, seq = y, ACK = 1, ack = x + 1, 且服务端进入SYN_RCVD状态
         
         * 3. 客户端收到响应报文后, 向服务端发送确认报文: ACK = 1, ack = y + 1, 且进入ESTABLISHED. 服务端收到确认报文后, 也进入ESTABLISHED状态, 链接创建成功
         
         * ⚠️. 为什么需要三次握手? 为了防止已经失效的请求链接突然又传送到了服务端, 而产生错误
         */
        
    }
    
    /// 四次挥手_TCP
    func fourTimesWave_TCP() {
        /*
         * 四次挥手流程:
         * 1. 客户端向服务端发起关闭链接的请求, 并停止发送数据
         
         * 2. 服务端收到请求时向客户端回应, 并停止接收数据
         
         * 3. 当服务端发送数据结束后向客户端发起关闭链接的请求, 并停止发送数据
         
         * 4. 客户端收到请求时向服务端回应, 并停止接收数据
         */
        
    }
    
    /// 完整握手流程_HTTPS
    func handshakeProcess_TCP() {
        /*
         * HTTPS握手流程:
         * 1. 客户端发送"Client Hello"报文开始SSL通信
         
         * 2. 服务端收到"Client Hello"报文后, 回应"Server Hello"报文. 然后发送CA证书, 最后发送"Server Hello Done"报文(SSL第一次握手结束)
         
         * 3. 客户端收到报文后通过证书获取服务端公钥, 回应"Client Key Exchange"报文(生成随机数F后加密形成密钥), 然后发送"Change Clipher Space"报文(提示服务器之后的通信都会用密钥加密), 最后发送"Finished"报文(包含至今全部报文的整体校验值)
         
         * 4. 服务端收到"Finished"报文后, 同样发送"Change Clipher Space"与"Finished"报文, 逻辑同上
         
         * 5. 客户端收到"Finished"报文后, SSL链接建立, 从此开始HTTP通信(内容都用密钥加密). 开始发送HTTP请求
         
         * 6. 应用层收到请求后发送响应
         
         * 7. 客户端断开连接
         
         * ⚠️. 这是单向认证(即只验证服务端的身份), 双向验证是在单向验证的基础上再添加对客户端的验证
         */
        
    }
    
    /// Charles抓包原理
    func captureDataPrinciple_Charles() {
        /*
         * 流程:
         * 1. 在上述第二步中拦截CA证书, 从CA证书中获取服务端公钥并制作一张假证书返回给客户端
         
         * 2. 在上述第三步中拦截密钥, 并用自己的私钥解密得到随机数F, 用服务端证书的公钥加密后得到假密钥, 返回给服务端
         
         */
        
    }
}
