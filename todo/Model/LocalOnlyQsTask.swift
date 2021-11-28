import RealmSwift


// LocalOnlyQsTask is the Task model for this QuickStart
class LocalOnlyQsTask: Object {


     var name: String = ""
     var owner: String?
     var status: String = ""

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

// Entrypoint. Call this to run the example.

