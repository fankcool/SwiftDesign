// 组合模式
// 百度百科：将对象组合成树形结构以表示“部分-整体”的层次结构，组合模式使得用户对单个对象和组合对象的使用具有一致性。掌握组合模式的重点是要理解清楚 “部分/整体” 还有 ”单个对象“ 与 "组合对象" 的含义
// 设计模式分类：结构型模式

/**
 *  零件接口
 */
protocol Shape {
    func draw(fillColor: String)
}

/// 零件实现， 正方形
class Square : Shape {
    func draw(fillColor: String) {
        print("Drawing a Square with color \(fillColor)")
    }
}

/// 零件实现， 圆形
class Circle : Shape {
    func draw(fillColor: String) {
        print("Drawing a circle with color \(fillColor)")
    }
}

/// 白板, 组合型
class Whiteboard : Shape {
    lazy var shapes = [Shape]()
    
    init(_ shapes:Shape...) {
        self.shapes = shapes
    }
    
    func draw(fillColor:String) {
        for shape in self.shapes {
            shape.draw(fillColor)
        }
    }
}

var whiteboard = Whiteboard(Circle(), Square())
whiteboard.draw("Red")