import SwiftUI
import NaturalLanguage

struct ContentView: View {
    @State private var text: String = ""
    @State private var results: [Result] = []
    @State private var textEditorHeight: CGFloat = 100
    
    var body: some View {
        VStack {
            Text("Speech Parse")
                .font(.title)
            
            GeometryReader { geometry in
                VStack {
                    TextEditor(text: $text)
                        .frame(height: textEditorHeight)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding()
                    HStack{
                        Button {
                            speechParse()
                        } label: {
                            Text("Parse")
                                .frame(width: 150, height: 50)
                                .foregroundColor(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.gray, lineWidth: 1)
                                )
                        }
                        Button {
                            clearData()
                        } label: {
                            Text("Clear")
                                .frame(width: 150, height: 50)
                                .foregroundColor(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.gray, lineWidth: 1)
                                )
                        }

                   }
                   
                    List(results) { result in
                        HStack {
                            Text(result.word)
                            Spacer()
                            Text(result.partOfSpeech)
                        }
                    }
                    
                }
            }
            
         
        }
        .padding()
    }
    
    func speechParse() {
        if #available(iOS 12.0, *) {
            let tagger = NLTagger(tagSchemes: [.lexicalClass])
            tagger.string = text
            
            var resultArray: [Result] = []
            
            tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass, options: [.omitPunctuation, .omitWhitespace]) { (tag, range) -> Bool in
                if let lexicalTag = tag {
                    let result = Result(word: String(text[range]), partOfSpeech: lexicalTag.rawValue)
                    resultArray.append(result)
                }
                return true
            }
            
            results = resultArray
        }
    }
    
    func clearData() {
            text = ""
            results.removeAll()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
