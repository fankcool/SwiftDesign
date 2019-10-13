// 创建者模式
// 百度百科：其核心思想是将一个“复杂对象的构建算法”与它的“部件及组装方式”分离，使得构件算法和组装方式可以独立应对变化；复用同样的构建算法可以创建不同的表示，不同的构建过程可以复用相同的部件组装方式
// 设计模式分类：创建型模式

/// 创建者
class DeathStarBuilder {
    
    var x: Double?
    var y: Double?
    var z: Double?
    
        /// 创建者闭包
    typealias BuilderClosure = (DeathStarBuilder) -> ()
    
    init(buildClosure: BuilderClosure) {
        buildClosure(self)
    }
}

/**
 *  创建对象
 */
struct DeathStar : CustomStringConvertible {
    
    let x: Double
    let y: Double
    let z: Double
    
    init?(builder: DeathStarBuilder) {
        
        if let x = builder.x, let y = builder.y, let z = builder.z {
            self.x = x
            self.y = y
            self.z = z
        } else {
            return nil
        }
    }
    
    var description:String {
        return "Death Star at (x:\(x) y:\(y) z:\(z))"
    }
}

let empire = DeathStarBuilder { builder in
    builder.x = 0.1
    builder.y = 0.2
    builder.z = 0.3
}

let deathStar = DeathStar(builder:empire)
