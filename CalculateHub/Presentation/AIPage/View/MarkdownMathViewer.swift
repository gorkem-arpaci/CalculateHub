//
//  MarkdownMathViewer.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 10.09.2025.
//
// MathDisplayView.swift
import SwiftUI
import WebKit

// WebKit tabanlı LaTeX renderer
func convertMarkdownToHTML(_ markdown: String) -> String {
    let lines = markdown.components(separatedBy: .newlines)
    var processedLines: [String] = []
    var inMathBlock = false
    var inStep = false
    
    for line in lines {
        let trimmedLine = line.trimmingCharacters(in: .whitespaces)
        
        // Matematik blok kontrolü
        if trimmedLine.hasPrefix("$$") {
            inMathBlock.toggle()
            processedLines.append(line)
            continue
        }
        
        // Matematik bloğu içindeyse olduğu gibi ekle
        if inMathBlock {
            processedLines.append(line)
            continue
        }
        
        // Başlık kontrolü
        if trimmedLine.hasPrefix("#### ") {
            if inStep {
                processedLines.append("</div>")
                inStep = false
            }
            let title = String(trimmedLine.dropFirst(5))
            let processedTitle = processBoldText(title)
            processedLines.append("<div class=\"step\"><h4>\(processedTitle)</h4>")
            inStep = true
        } else if trimmedLine.hasPrefix("### ") {
            if inStep {
                processedLines.append("</div>")
                inStep = false
            }
            let title = String(trimmedLine.dropFirst(4))
            let processedTitle = processBoldText(title)
            processedLines.append("<div class=\"step\"><h3>\(processedTitle)</h3>")
            inStep = true
        } else if trimmedLine.hasPrefix("## ") {
            if inStep {
                processedLines.append("</div>")
                inStep = false
            }
            let title = String(trimmedLine.dropFirst(3))
            let processedTitle = processBoldText(title)
            processedLines.append("<h2>\(processedTitle)</h2>")
        } else if trimmedLine.hasPrefix("# ") {
            if inStep {
                processedLines.append("</div>")
                inStep = false
            }
            let title = String(trimmedLine.dropFirst(2))
            let processedTitle = processBoldText(title)
            processedLines.append("<h1>\(processedTitle)</h1>")
        }
        // Boş satır kontrolü
        else if trimmedLine.isEmpty || trimmedLine == "---" {
            continue
        }
        // Normal metin satırı
        else if !trimmedLine.isEmpty {
            let processedLine = processBoldText(line)
            processedLines.append("<p>\(processedLine)</p>")
        }
    }
    
    // Son step'i kapat
    if inStep {
        processedLines.append("</div>")
    }
    
    return processedLines.joined(separator: "\n")
}

// Bold metinleri işleyen yardımcı fonksiyon
func processBoldText(_ text: String) -> String {
    let boldPattern = "\\*\\*(.*?)\\*\\*"
    return text.replacingOccurrences(of: boldPattern, with: "<strong>$1</strong>", options: .regularExpression)
}

struct MathDisplayView: UIViewRepresentable {
    let mathContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // Markdown'ı HTML'e dönüştür
        let processedContent = convertMarkdownToHTML(mathContent)
        
        let html = """
        <!DOCTYPE html>
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
            <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
            <script>
                window.MathJax = {
                    tex: {
                        inlineMath: [['$', '$'], ['\\\\(', '\\\\)']],
                        displayMath: [['$$', '$$'], ['\\\\[', '\\\\]']]
                    },
                    svg: {
                        fontCache: 'global'
                    }
                };
            </script>
            <style>
                body {
                    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                    margin: 15px;
                    background-color: transparent;
                    color: #1d1d1f;
                    line-height: 1.6;
                    width: 100%;
                    max-width: 100%;
                    overflow-x: hidden;
                }
                .math-container {
                    background: transparent;
                    box-sizing: border-box;
                    word-wrap: break-word;
                    padding: 20px;
                    border-radius: 15px;
                    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
                    max-width: 100%;
                    overflow-x: hidden;
                }
                h1, h2, h3, h4, h5, h6 {
                    color: #1d1d1f;
                    margin-top: 25px;
                    margin-bottom: 15px;
                    font-weight: 600;
                }
                h1 { 
                    font-size: 28px; 
                    text-align: center;
                    color: #007AFF;
                    border-bottom: 3px solid #007AFF;
                    padding-bottom: 10px;
                    margin: 30px 0 20px 0;
                }
                h2 { 
                    font-size: 24px; 
                    color: #2c3e50;
                    margin: 25px 0 15px 0;
                    padding: 10px 0;
                    border-bottom: 2px solid #ecf0f1;
                }
                h3 { 
                    font-size: 20px; 
                    color: #007AFF;
                    margin: 20px 0 10px 0;
                    font-weight: 600;
                }
                h4 { 
                    font-size: 18px; 
                    color: #34495e;
                    margin: 15px 0 10px 0;
                    font-weight: 600;
                }
                .step {
                    margin: 20px 0;
                    padding: 20px;
                    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                    border-radius: 12px;
                    border-left: 5px solid #007AFF;
                    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                }
                .final-answer {
                    background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                    border: 3px solid #28a745;
                    padding: 25px;
                    border-radius: 15px;
                    text-align: center;
                    margin: 30px 0;
                    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.2);
                }
                strong {
                    color: #007AFF;
                    font-weight: 600;
                }
                p {
                    margin: 10px 0;
                    text-align: justify;
                }
                mjx-container {
                    max-width: 100%;
                    overflow-x: auto;
                    overflow-y: hidden;
                    margin: 15px 0;
                }
                /* Matematik kutuları için özel stil */
                mjx-container[display="true"] {
                    background: #f8f9fa;
                    padding: 15px;
                    border-radius: 8px;
                    border: 1px solid #dee2e6;
                    margin: 20px 0;
                }
                /* Final Answer özel stili */
                .final-answer h2 {
                    color: #28a745;
                    text-align: center;
                    font-size: 22px;
                    margin: 10px 0;
                    border: none;
                }
                .final-answer h3 {
                    color: #28a745;
                    text-align: center;
                    font-size: 20px;
                    margin: 10px 0;
                }
                /* Responsive tasarım */
                @media (max-width: 480px) {
                    .math-container {
                        padding: 15px;
                        margin: 10px;
                    }
                    h1 { font-size: 24px; }
                    h2 { font-size: 20px; }
                    h3 { font-size: 18px; }
                }
            </style>
        </head>
        <body>
            <div class="math-container">
                \(processedContent.isEmpty ? "<p>Soru çözülüyor...</p>" : processedContent)
            </div>
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}



//#Preview {
//    MarkdownMathViewer()
//}
