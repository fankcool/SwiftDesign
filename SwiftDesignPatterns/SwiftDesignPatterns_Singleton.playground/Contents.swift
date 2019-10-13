// 单例模式
// 百度百科：单例模式是一种常用的软件设计模式。在它的核心结构中只包含一个被称为单例的特殊类。通过单例模式可以保证系统中一个类只有一个实例
// 设计模式分类：创建型模式

class DeathStarSuperlaser {
    static let sharedInstance = DeathStarSuperlaser()
    
    private init() {
        // 私有化构造函数来保证只有一个实例
    }
}

let laser = DeathStarSuperlaser.sharedInstance