
import RealmSwift

// QsTask is the Task model for this QuickStart
class Task: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var owner: String?
    @Persisted var status: String = ""

    convenience init(name: String, status: String) {
        self.init()
        self.name = name
        self.status = status
    }
}

