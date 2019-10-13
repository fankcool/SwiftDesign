// 访问者模式
// 百度百科：表示一个作用于某对象结构中的各元素的操作。它使你可以在不改变各元素类的前提下定义作用于这些元素的新操作
// 设计模式分类：行为型模式

/**
 *  星球访问者接口
 */
protocol PlanetVisitor {
    func visit(planet: Earth)
    func visit(planet: Mars)
    func visit(planet: Venus)
}

/**
 *  行星类
 */
protocol Planet {
    func accept(visitor: PlanetVisitor)
}

/// 地球
class Earth: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(self) }
}

/// 火星
class Mars: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(self) }
}

/// 金星
class Venus: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(self) }
}

/// 具体访问者类
class NameVisitor: PlanetVisitor {
    var name = ""
    
    func visit(planet: Earth)  { name = "Earth" }
    func visit(planet: Mars) { name = "Mars" }
    func visit(planet: Venus)  { name = "Venus" }
}

let planets: [Planet] = [Earth(), Mars(), Venus()]

let names = planets.map { (planet: Planet) -> String in
    let visitor = NameVisitor()
    planet.accept(visitor)
    return visitor.name
}

print(names)
