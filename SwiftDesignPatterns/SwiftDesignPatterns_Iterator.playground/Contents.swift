// 迭代器模式
// 百度百科：提供一种方法顺序访问一个聚合对象中的各种元素，而又不暴露该对象的内部表示
// 设计模式分类：行为型模式

/**
 *  小说集类
 */
struct NovellasCollection<T> {
    let novellas: [T]
}

// 实现SequenceType接口
extension NovellasCollection: SequenceType {
    typealias Generator = AnyGenerator<T>
    
    func generate() -> AnyGenerator<T> {
        var i = 0
        return AnyGenerator{
            if i >= self.novellas.count {
                return nil
            } else {
                let r = self.novellas[i]
                i += 1
                return r
            }
        }
    }
}

let greatNovellas = NovellasCollection(novellas:["三国演义", "水浒", "红楼梦", "西游记"])

// 可以迭代
for novella in greatNovellas {
    print("I've read: \(novella)")
}
