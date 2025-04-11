import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "TaskData")
    init() {
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

}
