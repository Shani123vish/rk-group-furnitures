<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String suggestions   = (String) session.getAttribute("ai_suggestions");
    String generatedImg  = (String) session.getAttribute("generated_image");
    String roomType      = (String) session.getAttribute("room_type");
    String budget        = (String) session.getAttribute("budget");
    String txnId         = (String) session.getAttribute("transaction_id");
    if (suggestions == null) { response.sendRedirect("ai-design.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="hi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AI Design Report — RK Group</title>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600&family=Jost:wght@300;400;500&display=swap" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
<style>
*{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Jost',sans-serif;background:#fdf8ee;}
.top-bar{background:#1a1208;padding:16px 32px;display:flex;justify-content:space-between;align-items:center;}
.top-logo{font-family:'Cormorant Garamond',serif;color:#f0c040;font-size:20px;}
.top-txn{font-size:11px;color:#6a5a38;}
.container{max-width:860px;margin:30px auto;padding:0 16px;}
.report-box{background:white;border:0.5px solid #e8d9a0;border-radius:16px;overflow:hidden;}
.report-header{background:linear-gradient(135deg,#1a1208,#2d1f08);padding:28px 36px;border-bottom:3px solid #c9a227;}
.report-title{font-family:'Cormorant Garamond',serif;font-size:26px;color:#f0c040;}
.report-meta{font-size:12px;color:#8a7a55;margin-top:6px;}
.report-meta b{color:#c9a227;}
.gen-img{width:100%;max-height:320px;object-fit:cover;}
.gen-img-cap{text-align:center;font-size:11px;color:#8a7a55;padding:8px;font-style:italic;background:#fffef5;border-bottom:1px solid #e8d9a0;}
.suggestions-body{padding:28px 36px;}
.suggestions-text{font-size:14px;color:#2d1f08;line-height:1.9;white-space:pre-wrap;}
.contact-footer{background:#fffef5;padding:16px 36px;text-align:center;font-size:12px;color:#8a7a55;border-top:1px solid #e8d9a0;}
.contact-footer b{color:#c9a227;}
.action-bar{background:#1a1208;padding:18px 32px;display:flex;justify-content:space-between;align-items:center;border-radius:0 0 16px 16px;}
.action-info{font-size:12px;color:#8a7a55;}
.btn-dl{background:linear-gradient(135deg,#c9a227,#f0c040);border:none;padding:12px 28px;border-radius:8px;font-family:'Jost',sans-serif;font-size:13px;font-weight:500;cursor:pointer;color:#1a1208;letter-spacing:0.5px;}
.btn-home{background:transparent;border:1px solid #c9a227;padding:12px 20px;border-radius:8px;font-family:'Jost',sans-serif;font-size:13px;color:#c9a227;cursor:pointer;margin-right:10px;}
</style>
</head>
<body>
<div class="top-bar">
  <div class="top-logo">RK Group Furnitures & Interior</div>
  <div class="top-txn">TXN: <%= txnId %></div>
</div>

<div class="container">
  <div class="report-box" id="reportContent">
    <div class="report-header">
      <div class="report-title">✦ Aapka AI Interior Design Report</div>
      <div class="report-meta">
        Room: <b><%= roomType %></b> &nbsp;|&nbsp;
        Budget: <b><%= budget %></b> &nbsp;|&nbsp;
        Powered by Claude AI + Stable Diffusion
      </div>
    </div>

    <% if(generatedImg != null && !generatedImg.isEmpty()) { %>
    <img class="gen-img"
         src="data:image/jpeg;base64,<%= generatedImg %>"
         alt="AI Generated Room Design"/>
    <div class="gen-img-cap">↑ AI ki nazar se aapki redesigned room</div>
    <% } %>

    <div class="suggestions-body">
      <div class="suggestions-text"><%= suggestions %></div>
    </div>

    <div class="contact-footer">
      <b>RK Group Furnitures & Interior</b> &nbsp;|&nbsp;
      Rahul Vishwakarma &nbsp;|&nbsp;
      📞 7772897077 &nbsp;|&nbsp;
      ✉ rahulvishwakarma111999@gmail.com
    </div>
  </div>

  <div class="action-bar">
    <div class="action-info">✦ Report ready hai — download karo!</div>
    <div>
      <button class="btn-home" onclick="window.location='index.jsp'">🏠 Home</button>
      <button class="btn-dl" onclick="downloadPDF()">⬇ PDF Download Karo</button>
    </div>
  </div>
</div>

<script>
function downloadPDF() {
  const el = document.getElementById('reportContent');
  const opt = {
    margin: 8,
    filename: 'RK-AI-Interior-Design-Report.pdf',
    image: { type: 'jpeg', quality: 0.95 },
    html2canvas: { scale: 2, useCORS: true },
    jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
  };
  html2pdf().set(opt).from(el).save();
}
</script>
</body>
</html>