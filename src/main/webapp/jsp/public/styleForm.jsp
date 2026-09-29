<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Interior Style Recommender - RK Group</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f0eb; }
        .container { max-width: 750px; margin: 40px auto; padding: 20px; }
        h1 { text-align: center; color: #5a3e28; margin-bottom: 8px; }
        .subtitle { text-align: center; color: #999; margin-bottom: 30px; font-size: 14px; }
        .card { background: white; padding: 30px; border-radius: 14px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .section-title { font-size: 13px; font-weight: bold; color: #999;
                         text-transform: uppercase; letter-spacing: 1px;
                         margin: 25px 0 15px; border-bottom: 2px solid #f0e8e0;
                         padding-bottom: 8px; }
        .form-group { margin-bottom: 18px; }
        .form-row { display: flex; gap: 15px; }
        .form-row .form-group { flex: 1; }
        label { display: block; font-weight: bold; color: #5a3e28;
                margin-bottom: 8px; font-size: 14px; }
        select, input[type="number"], input[type="text"] {
                width: 100%; padding: 11px; border: 2px solid #e0d5c8;
                border-radius: 8px; font-size: 14px; color: #333; }
        select:focus, input:focus { outline: none; border-color: #5a3e28; }
        .photo-box { border: 2px dashed #c8b8a8; border-radius: 10px;
                     padding: 25px; text-align: center; cursor: pointer; }
        .photo-box:hover { border-color: #5a3e28; background: #faf7f4; }
        .photo-box p { color: #999; margin-top: 8px; font-size: 13px; }
        #previewImg { width: 100%; max-height: 180px; object-fit: cover;
                      border-radius: 8px; margin-top: 10px; display: none; }
        .btn { width: 100%; padding: 14px; background: #5a3e28; color: white;
               border: none; border-radius: 8px; font-size: 16px; cursor: pointer; margin-top: 15px; }
        .btn:hover { background: #7a5c40; }
        .lock-box { background: #fff3e0; border: 2px solid #ffab40;
                    border-radius: 10px; padding: 20px; text-align: center;
                    margin-top: 20px; display: none; }
        .lock-box h3 { color: #e65100; }
        .lock-box p { color: #666; margin-top: 8px; font-size: 14px; }
        .pay-btn { background: #e65100; color: white; border: none;
                   padding: 12px 30px; border-radius: 8px; cursor: pointer;
                   margin-top: 12px; font-size: 15px; }
        .loading { text-align: center; padding: 20px; display: none; }
        .loading p { color: #888; margin-top: 10px; }
        .spinner { width: 40px; height: 40px; border: 4px solid #e0d5c8;
                   border-top-color: #5a3e28; border-radius: 50%;
                   animation: spin 0.8s linear infinite; margin: auto; }
        @keyframes spin { to { transform: rotate(360deg); } }
        .error-box { background: #ffebee; border: 2px solid #ef9a9a;
                     border-radius: 10px; padding: 15px; text-align: center;
                     margin-top: 20px; display: none; }
        .error-box p { color: #c62828; font-size: 14px; }
        .hint { font-size: 12px; color: #aaa; margin-top: 4px; }
    </style>
</head>
<body>
<div class="container">
    <h1>Room Layout &amp; Style Recommender</h1>
    <p class="subtitle">Enter your room details — AI will suggest furniture placement and design</p>

    <div class="card">

        <!-- Photo Upload -->
        <div class="section-title">Room Photo</div>
        <div class="form-group">
            <div class="photo-box" onclick="document.getElementById('roomPhoto').click()">
                <svg width="36" height="36" viewBox="0 0 24 24" fill="none"
                     stroke="#c8b8a8" stroke-width="1.5">
                    <rect x="3" y="3" width="18" height="18" rx="3"/>
                    <circle cx="8.5" cy="8.5" r="1.5"/>
                    <polyline points="21 15 16 10 5 21"/>
                </svg>
                <p>Click here to upload your room photo</p>
                <input type="file" id="roomPhoto" accept="image/*"
                       style="display:none" onchange="photoSelect(this)">
            </div>
            <img id="previewImg" src="" alt="Room preview">
        </div>

        <!-- Room Dimensions -->
        <div class="section-title">Room Dimensions</div>
        <div class="form-row">
            <div class="form-group">
                <label>Room Length</label>
                <input type="number" id="room_length" placeholder="E.g.: 12" min="6" max="30">
                <p class="hint">Enter in feet</p>
            </div>
            <div class="form-group">
                <label>Room Width</label>
                <input type="number" id="room_width" placeholder="E.g.: 10" min="6" max="30">
                <p class="hint">Enter in feet</p>
            </div>
        </div>

        <!-- Room Type -->
        <div class="section-title">Room Information</div>
        <div class="form-group">
            <label>Which room do you want to design?</label>
            <select id="room_type">
                <option value="">-- Select --</option>
                <option value="1">Bedroom</option>
                <option value="2">Living Room</option>
                <option value="3">Kitchen</option>
            </select>
        </div>

        <!-- Door & Window -->
        <div class="form-row">
            <div class="form-group">
                <label>Door Position</label>
                <select id="door_pos">
                    <option value="">-- Select --</option>
                    <option value="1">Left</option>
                    <option value="2">Right</option>
                    <option value="3">Front</option>
                </select>
            </div>
            <div class="form-group">
                <label>Window Position</label>
                <select id="window_pos">
                    <option value="">-- Select --</option>
                    <option value="1">Left</option>
                    <option value="2">Right</option>
                    <option value="3">Front</option>
                </select>
            </div>
        </div>

        <!-- Budget & Preferences -->
        <div class="section-title">Budget &amp; Preferences</div>
        <div class="form-group">
            <label>What is your budget?</label>
            <select id="budget">
                <option value="">-- Select --</option>
                <option value="1">Low — Under ₹25,000</option>
                <option value="2">Medium — ₹25,000 to ₹75,000</option>
                <option value="3">High — Above ₹75,000</option>
            </select>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Color Preference</label>
                <select id="color_pref">
                    <option value="">-- Select --</option>
                    <option value="1">Light Colors (White, Beige)</option>
                    <option value="2">Dark Colors (Black, Grey)</option>
                    <option value="3">Colorful (Mixed)</option>
                </select>
            </div>
            <div class="form-group">
                <label>Family Size</label>
                <select id="family_size">
                    <option value="">-- Select --</option>
                    <option value="1">1-2 members</option>
                    <option value="2">3-4 members</option>
                    <option value="3">5 or more</option>
                </select>
            </div>
        </div>

        <!-- Personal Details -->
        <div class="section-title">Your Details</div>
        <div class="form-row">
            <div class="form-group">
                <label>Your Name</label>
                <input type="text" id="naam" placeholder="Enter your name">
            </div>
            <div class="form-group">
                <label>Mobile Number</label>
                <input type="text" id="phone" placeholder="10 digit number">
            </div>
        </div>

        <button class="btn" onclick="formSubmit()">
            Generate Room Layout
        </button>

        <div class="loading" id="loading">
            <div class="spinner"></div>
            <p>AI is calculating your room layout...</p>
        </div>

        <div class="error-box" id="errorBox">
            <p id="errorMsg">Something went wrong, please try again.</p>
        </div>

        <div class="lock-box" id="lockBox">
            <h3>&#128274; Layout Ready!</h3>
            <p>Your personalized room layout and furniture plan is ready!</p>
            <p><strong>View for just Rs. 199</strong> — furniture placement, budget breakdown and 2D diagram.</p>
            <button class="pay-btn" onclick="paymentKaro()">View Now — Rs. 199</button>
        </div>
    </div>
</div>

<script>
var photoBase64 = '';
var orderId = '';
var projectName = '/RKGroupFurnituresInterior';

function photoSelect(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            photoBase64 = e.target.result;
            document.getElementById('previewImg').src = e.target.result;
            document.getElementById('previewImg').style.display = 'block';
        };
        reader.readAsDataURL(input.files[0]);
    }
}

function showError(msg) {
    document.getElementById('loading').style.display = 'none';
    document.getElementById('errorMsg').innerText = msg;
    document.getElementById('errorBox').style.display = 'block';
}

function formSubmit() {
    var budget      = document.getElementById('budget').value;
    var room_type   = document.getElementById('room_type').value;
    var color_pref  = document.getElementById('color_pref').value;
    var family_size = document.getElementById('family_size').value;
    var room_length = document.getElementById('room_length').value;
    var room_width  = document.getElementById('room_width').value;
    var door_pos    = document.getElementById('door_pos').value;
    var window_pos  = document.getElementById('window_pos').value;
    var naam        = document.getElementById('naam').value;
    var phone       = document.getElementById('phone').value;

    if (!budget || !room_type || !color_pref || !family_size ||
        !room_length || !room_width || !door_pos || !window_pos || !naam || !phone) {
        alert('Please fill in all fields!');
        return;
    }

    document.getElementById('loading').style.display = 'block';
    document.getElementById('lockBox').style.display = 'none';
    document.getElementById('errorBox').style.display = 'none';

    fetch(projectName + '/StyleServlet', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            budget: budget,
            room_type: room_type,
            color_pref: color_pref,
            family_size: family_size,
            room_length: room_length,
            room_width: room_width,
            door_pos: door_pos,
            window_pos: window_pos,
            naam: naam,
            phone: phone,
            photo: photoBase64
        })
    })
    .then(function(res) {
        if (!res.ok) throw new Error('Server error: ' + res.status);
        return res.json();
    })
    .then(function(data) {
        document.getElementById('loading').style.display = 'none';
        if (data.orderSaved) {
            orderId = data.orderId;
            document.getElementById('lockBox').style.display = 'block';
        } else {
            showError('Order could not be saved: ' + (data.error || 'Unknown error'));
        }
    })
    .catch(function(err) {
        showError('Could not connect to server. Error: ' + err.message);
    });
}

function paymentKaro() {
    if (!orderId) { alert('Order ID not found.'); return; }
    window.location.href = projectName + '/StyleResultServlet?orderId=' + orderId + '&paid=true';
}
</script>
</body>
</html>
