<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="hi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AI Interior Design — RK Group</title>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600&family=Jost:wght@300;400;500&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Jost',sans-serif;background:#fdf8ee;color:#2d1f08;}
.rk-wrap{max-width:680px;margin:40px auto;padding:0 16px;}
.rk-header{background:#1a1208;padding:28px 32px 24px;text-align:center;border-radius:16px 16px 0 0;position:relative;}
.rk-header::after{content:'';position:absolute;bottom:0;left:0;right:0;height:3px;background:linear-gradient(90deg,transparent,#c9a227,#f0c040,#c9a227,transparent);}
.rk-brand{font-size:10px;letter-spacing:3px;color:#c9a227;text-transform:uppercase;margin-bottom:5px;}
.rk-title{font-family:'Cormorant Garamond',serif;font-size:28px;font-weight:600;color:#f5e6b8;}
.rk-sub{font-size:12px;color:#6a5a38;letter-spacing:1px;margin-top:5px;}
.rk-body{background:white;border:0.5px solid #e8d9a0;border-top:none;padding:28px 32px;}
.step-row{display:flex;gap:12px;margin-bottom:22px;align-items:flex-start;}
.step-num{width:28px;height:28px;border-radius:50%;background:#1a1208;border:1.5px solid #c9a227;color:#c9a227;font-size:11px;display:flex;align-items:center;justify-content:center;flex-shrink:0;margin-top:2px;}
.step-label{font-size:10px;letter-spacing:1.5px;color:#8a7a55;text-transform:uppercase;margin-bottom:7px;}
.upload-zone{border:1.5px dashed #c9a227;border-radius:12px;padding:20px;text-align:center;background:#fffef5;cursor:pointer;transition:all 0.2s;}
.upload-zone:hover{background:#faf3d8;}
.upload-zone input{display:none;}
.upload-text{font-size:13px;color:#4a3a1a;margin-top:6px;}
.upload-sub{font-size:11px;color:#8a7a55;margin-top:3px;}
.preview-img{max-width:100%;border-radius:8px;margin-top:10px;display:none;border:1px solid #e8d9a0;}
.room-grid{display:grid;grid-template-columns:1fr 1fr 1fr;gap:7px;margin-top:5px;}
.room-chip{border:1px solid #d4c080;border-radius:20px;padding:7px 8px;font-size:11px;text-align:center;cursor:pointer;background:#fffef5;color:#4a3a1a;transition:all 0.2s;user-select:none;}
.room-chip.active{background:#1a1208;border-color:#c9a227;color:#f0c040;}
.rk-input{width:100%;border:1px solid #d4c080;border-radius:8px;padding:10px 14px;font-family:'Jost',sans-serif;font-size:13px;background:#fffef5;color:#2d1f08;outline:none;transition:border 0.2s;}
.rk-input:focus{border-color:#c9a227;}
.budget-grid{display:grid;grid-template-columns:1fr 1fr;gap:8px;margin-top:5px;}
.budget-chip{border:1px solid #d4c080;border-radius:10px;padding:12px 8px;text-align:center;cursor:pointer;background:#fffef5;transition:all 0.2s;user-select:none;}
.budget-chip.active{background:#1a1208;border-color:#c9a227;}
.budget-chip .amt{font-family:'Cormorant Garamond',serif;font-size:17px;font-weight:600;color:#4a3a1a;}
.budget-chip.active .amt{color:#f0c040;}
.budget-chip .lbl{font-size:10px;color:#8a7a55;letter-spacing:0.5px;margin-top:3px;}
.divider{height:1px;background:linear-gradient(90deg,transparent,#d4c080,transparent);margin:22px 0;}
.pay-box{background:linear-gradient(135deg,#1a1208,#2d1f08);border-radius:12px;padding:20px 24px;border:1px solid #c9a227;}
.pay-top{display:flex;justify-content:space-between;align-items:flex-start;}
.pay-amount{font-family:'Cormorant Garamond',serif;font-size:38px;font-weight:600;color:#f0c040;}
.pay-amount sup{font-size:16px;color:#c9a227;vertical-align:super;}
.pay-desc{font-size:11px;color:#8a7a55;margin-top:4px;}
.pay-badge{font-size:10px;color:#6ecf6e;background:#1a3a1a;border:1px solid #2d6a2d;padding:4px 12px;border-radius:20px;letter-spacing:1px;}
.pay-features{margin-top:12px;display:flex;flex-direction:column;gap:5px;}
.pay-feat{font-size:12px;color:#c9a227;display:flex;align-items:center;gap:6px;}
.phonepe-btn{width:100%;margin-top:16px;background:linear-gradient(135deg,#5f259f,#7b35c7);border:none;border-radius:10px;padding:14px;color:white;font-family:'Jost',sans-serif;font-size:14px;font-weight:500;cursor:pointer;display:flex;align-items:center;justify-content:center;gap:8px;letter-spacing:0.5px;}
.phonepe-btn:hover{opacity:0.9;}
.sec-row{display:flex;gap:16px;margin-top:12px;flex-wrap:wrap;}
.sec-item{display:flex;align-items:center;gap:5px;font-size:10px;color:#6a5a38;}
.error-msg{background:#3a1a1a;border:1px solid #c9a227;color:#f0a0a0;padding:10px 16px;border-radius:8px;font-size:13px;margin-bottom:16px;display:none;}
.rk-footer{background:#1a1208;padding:14px 32px;text-align:center;border-radius:0 0 16px 16px;border-top:1px solid #3a2d10;}
.rk-footer-text{font-size:11px;color:#5a4a28;}
.rk-footer-text b{color:#c9a227;}
</style>
</head>
<body>

<div class="rk-wrap">
  <div class="rk-header">
    <div class="rk-brand">RK Group Furnitures & Interior</div>
    <div class="rk-title">AI Interior Design Studio</div>
    <div class="rk-sub">Upload • Design • Transform</div>
  </div>

  <div class="rk-body">
    <div class="error-msg" id="errorMsg"></div>

    <form action="phonepe-init" method="post" enctype="multipart/form-data" id="designForm">
      <input type="hidden" name="room_type" id="roomTypeInput" value="Living Room"/>
      <input type="hidden" name="budget_range" id="budgetInput" value="₹1L–3L"/>

      <!-- STEP 1: Photo -->
      <div class="step-row">
        <div class="step-num">1</div>
        <div style="flex:1">
          <div class="step-label">Room Ki Photo Upload Karein</div>
          <div class="upload-zone" onclick="document.getElementById('photoFile').click()">
            <div style="font-size:30px;color:#c9a227;">📷</div>
            <input type="file" id="photoFile" name="room_photo" accept="image/*" onchange="previewImage(this)"/>
            <div class="upload-text">Click karein ya photo drag karein</div>
            <div class="upload-sub">JPG, PNG supported • Max 10MB</div>
          </div>
          <img class="preview-img" id="previewImg" alt="Room preview"/>
        </div>
      </div>

      <!-- STEP 2: Room Type -->
      <div class="step-row">
        <div class="step-num">2</div>
        <div style="flex:1">
          <div class="step-label">Room Type Chunein</div>
          <div class="room-grid">
            <div class="room-chip active" onclick="selectRoom(this)">Living Room</div>
            <div class="room-chip" onclick="selectRoom(this)">Bedroom</div>
            <div class="room-chip" onclick="selectRoom(this)">Kitchen</div>
            <div class="room-chip" onclick="selectRoom(this)">Dining Room</div>
            <div class="room-chip" onclick="selectRoom(this)">Study/Office</div>
            <div class="room-chip" onclick="selectRoom(this)">Bathroom</div>
          </div>
        </div>
      </div>

      <!-- STEP 3: Demands -->
      <div class="step-row">
        <div class="step-num">3</div>
        <div style="flex:1">
          <div class="step-label">Apni Design Demands Likhein</div>
          <textarea class="rk-input" name="demands" rows="3"
            placeholder="Jaise: Modern luxury look chahiye, gold accents, marble flooring, light aur spacious feel..."></textarea>
        </div>
      </div>

      <!-- STEP 4: Budget -->
      <div class="step-row">
        <div class="step-num">4</div>
        <div style="flex:1">
          <div class="step-label">Apna Budget Chunein</div>
          <div class="budget-grid">
            <div class="budget-chip" onclick="selectBudget(this,'₹50K–1L')">
              <div class="amt">₹50K–1L</div>
              <div class="lbl">Basic Refresh</div>
            </div>
            <div class="budget-chip active" onclick="selectBudget(this,'₹1L–3L')">
              <div class="amt">₹1L–3L</div>
              <div class="lbl">Standard</div>
            </div>
            <div class="budget-chip" onclick="selectBudget(this,'₹3L–7L')">
              <div class="amt">₹3L–7L</div>
              <div class="lbl">Premium</div>
            </div>
            <div class="budget-chip" onclick="selectBudget(this,'₹7L+')">
              <div class="amt">₹7L+</div>
              <div class="lbl">Ultra Luxury</div>
            </div>
          </div>
          <input type="number" class="rk-input" name="custom_budget"
                 id="customBudget"
                 style="margin-top:8px;"
                 placeholder="Ya custom amount likhein (₹ mein)..."
                 oninput="customBudgetSelected(this)"/>
        </div>
      </div>

      <!-- STEP 5: Customer Info -->
      <div class="step-row">
        <div class="step-num">5</div>
        <div style="flex:1">
          <div class="step-label">Aapki Jankari</div>
          <input type="text" class="rk-input" name="customer_name"
                 placeholder="Aapka naam" style="margin-bottom:8px;" required/>
          <input type="tel" class="rk-input" name="customer_phone"
                 placeholder="Mobile number" maxlength="10" required/>
        </div>
      </div>

      <div class="divider"></div>

      <!-- Payment Box -->
      <div class="pay-box">
        <div class="pay-top">
          <div>
            <div style="font-size:10px;color:#8a7a55;letter-spacing:1.5px;margin-bottom:5px;">AI DESIGN FEE</div>
            <div class="pay-amount"><sup>₹</sup>500</div>
            <div class="pay-desc">Ek baar • Instant result • PDF download included</div>
          </div>
          <div class="pay-badge">SECURE</div>
        </div>
        <div class="pay-features">
          <div class="pay-feat">✦ Budget ke hisaab se customized suggestions</div>
          <div class="pay-feat">✦ Room-wise detailed design breakdown</div>
          <div class="pay-feat">✦ AI-generated redesigned room image</div>
          <div class="pay-feat">✦ PDF download + share option</div>
        </div>
        <button type="submit" class="phonepe-btn" onclick="return validateForm()">
          💜 PhonePe se ₹500 Payment Karein
        </button>
        <div class="sec-row">
          <div class="sec-item">🔒 SSL Secured</div>
          <div class="sec-item">🛡 PhonePe Protected</div>
          <div class="sec-item">⚡ Instant Result</div>
        </div>
      </div>
    </form>
  </div>

  <div class="rk-footer">
    <div class="rk-footer-text">
      <b>RK Group Furnitures & Interior</b> •
      Rahul Vishwakarma • 📞 7772897077
    </div>
  </div>
</div>

<script>
function previewImage(input) {
  if (input.files && input.files[0]) {
    const reader = new FileReader();
    reader.onload = function(e) {
      const img = document.getElementById('previewImg');
      img.src = e.target.result;
      img.style.display = 'block';
    };
    reader.readAsDataURL(input.files[0]);
  }
}

function selectRoom(el) {
  document.querySelectorAll('.room-chip').forEach(c => c.classList.remove('active'));
  el.classList.add('active');
  document.getElementById('roomTypeInput').value = el.innerText;
}

function selectBudget(el, val) {
  document.querySelectorAll('.budget-chip').forEach(c => c.classList.remove('active'));
  el.classList.add('active');
  document.getElementById('budgetInput').value = val;
  document.getElementById('customBudget').value = '';
}

function customBudgetSelected(input) {
  if (input.value) {
    document.querySelectorAll('.budget-chip').forEach(c => c.classList.remove('active'));
    document.getElementById('budgetInput').value = '₹' + input.value;
  }
}

function validateForm() {
  const photo = document.getElementById('photoFile').files[0];
  const name = document.querySelector('input[name="customer_name"]').value.trim();
  const phone = document.querySelector('input[name="customer_phone"]').value.trim();
  const errMsg = document.getElementById('errorMsg');

  if (!photo) {
    errMsg.style.display = 'block';
    errMsg.innerText = '⚠ Pehle room ki photo upload karein!';
    window.scrollTo(0,0);
    return false;
  }
  if (!name) {
    errMsg.style.display = 'block';
    errMsg.innerText = '⚠ Apna naam zaroor bharein!';
    return false;
  }
  if (phone.length !== 10) {
    errMsg.style.display = 'block';
    errMsg.innerText = '⚠ Valid 10-digit mobile number bharein!';
    return false;
  }
  errMsg.style.display = 'none';
  return true;
}
</script>
</body>
</html>