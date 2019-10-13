// 原型模式
// 百度百科：用原型实例指定创建对象的种类，并且通过拷贝这些原型创建新的对象
// 设计模式分类：创建型模式

class ChungasRevengeDisplay {
    var name: String?
    let font: String
    
    init(font: String) {
        self.font = font
    }
    
    func clone() -> ChungasRevengeDisplay {
        return ChungasRevengeDisplay(font:self.font)
    }
}

let Prototype = ChungasRevengeDisplay(font:"GotanProject")

let Philippe = Prototype.clone()
Philippe.name = "Philippe"

let Christoph = Prototype.clone()
Christoph.name = "Christoph"

let Eduardo = Prototype.clone()
Eduardo.name = "Eduardo"

Philippe.name
Christoph.name
Eduardo.name
