import Foundation

class TodoViewModel: ObservableObject {
    @Published var items: [TodoItem] = []

    func addItem(title: String) {
        let newItem = TodoItem(title: title, isCompleted: false)
        items.append(newItem)
    }

    func toggleItemCompletion(at index: Int) {
        items[index].isCompleted.toggle()
    }

    func deleteItem(at index: Int) {
        items.remove(at: index)
    }
}
