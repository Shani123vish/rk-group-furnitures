<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    String style           = (String) request.getAttribute("style");
    String hindiNaam       = (String) request.getAttribute("hindiNaam");
    String description     = (String) request.getAttribute("description");
    String rang            = (String) request.getAttribute("rang");
    String suggestion      = (String) request.getAttribute("suggestion");
    String naam            = (String) request.getAttribute("naam");
    String imageUrl        = (String) request.getAttribute("generatedImageUrl");
    String furnitureList   = (String) request.getAttribute("furnitureList");
    String budgetBreakdown = (String) request.getAttribute("budgetBreakdown");
    String placement       = (String) request.getAttribute("placement");
    String freeSpace       = (String) request.getAttribute("freeSpace");
    String totalArea       = (String) request.getAttribute("totalArea");
    String walkablePercent = (String) request.getAttribute("walkablePercent");
    String roomLength      = (String) request.getAttribute("roomLength");
    String roomWidth       = (String) request.getAttribute("roomWidth");
    String roomSuggestions = (String) request.getAttribute("roomSuggestions");
    if (roomSuggestions == null) roomSuggestions = "{}";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Room Layout - RK Group</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f0eb; }
        .container { max-width: 750px; margin: 30px auto; padding: 20px; }
        .result-card { background: white; border-radius: 14px;
                       box-shadow: 0 4px 20px rgba(0,0,0,0.1); overflow: hidden;
                       margin-bottom: 20px; }
        .result-header { background: #5a3e28; color: white; padding: 25px; text-align: center; }
        .result-header h2 { font-size: 13px; opacity: 0.8; margin-bottom: 6px; }
        .result-header h1 { font-size: 26px; }
        .result-header p  { font-size: 14px; opacity: 0.9; margin-top: 4px; }
        .section { padding: 20px 25px; border-bottom: 1px solid #f0e8e0; }
        .section:last-child { border-bottom: none; }
        .section-title { font-size: 12px; font-weight: bold; color: #999;
                         text-transform: uppercase; letter-spacing: 1px;
                         margin-bottom: 15px; }
        .stats-row { display: flex; gap: 12px; }
        .stat-box { flex: 1; background: #faf7f4; border-radius: 10px;
                    padding: 15px; text-align: center; }
        .stat-box .num { font-size: 24px; font-weight: bold; color: #5a3e28; }
        .stat-box .label { font-size: 12px; color: #999; margin-top: 4px; }
        .furniture-item { display: flex; justify-content: space-between;
                          align-items: flex-start; padding: 12px 0;
                          border-bottom: 1px solid #f5f0eb; }
        .furniture-item:last-child { border-bottom: none; }
        .furniture-name { font-weight: bold; color: #333; font-size: 14px; }
        .furniture-pos { font-size: 12px; color: #888; margin-top: 3px; }
        .furniture-price { font-weight: bold; color: #5a3e28; font-size: 14px;
                           white-space: nowrap; margin-left: 10px; }
        .budget-total { background: #5a3e28; color: white; padding: 12px 20px;
                        border-radius: 8px; display: flex;
                        justify-content: space-between; margin-top: 12px; }
        .budget-total span { font-weight: bold; font-size: 16px; }
        .detail-row { display: flex; margin-bottom: 14px; }
        .detail-icon { font-size: 24px; margin-right: 12px; }
        .detail-title { font-weight: bold; color: #5a3e28; font-size: 13px; }
        .detail-text { color: #555; margin-top: 3px; font-size: 13px; line-height: 1.5; }
        .canvas-wrap { background: #faf7f4; border-radius: 10px;
                       padding: 15px; text-align: center; }
        canvas { border: 2px solid #e0d5c8; border-radius: 8px; max-width: 100%; }
        .room-photo { width: 100%; border-radius: 10px;
                      box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .cta-box { background: #fff8f0; border: 2px solid #5a3e28;
                   border-radius: 10px; padding: 20px; text-align: center; }
        .cta-box h3 { color: #5a3e28; margin-bottom: 8px; }
        .cta-box p { color: #666; font-size: 13px; margin-bottom: 15px; }
        .cta-btn { display: inline-block; background: #5a3e28; color: white;
                   padding: 12px 30px; border-radius: 8px;
                   text-decoration: none; font-size: 15px; }
    </style>
</head>
<body>
<div class="container">
    <div class="result-card">

        <div class="result-header">
            <h2>AI Recommendation for <%= naam %></h2>
            <h1><%= hindiNaam %></h1>
            <p>(<%= style %> Style) — <%= roomLength %> x <%= roomWidth %> feet room</p>
        </div>

        <% if (imageUrl != null && !imageUrl.isEmpty()) { %>
        <div class="section">
            <div class="section-title">Your Room</div>
            <img src="<%= imageUrl %>" class="room-photo" alt="Your Room"/>
        </div>
        <% } %>

        <div class="section">
            <div class="section-title">Room Summary</div>
            <div class="stats-row">
                <div class="stat-box">
                    <div class="num"><%= totalArea %></div>
                    <div class="label">Total Area (sq ft)</div>
                </div>
                <div class="stat-box">
                    <div class="num"><%= freeSpace %></div>
                    <div class="label">Free Space (sq ft)</div>
                </div>
                <div class="stat-box">
                    <div class="num"><%= walkablePercent %>%</div>
                    <div class="label">Walkable Area</div>
                </div>
            </div>
        </div>

        <div class="section">
            <div class="section-title">2D Room Layout Diagram</div>
            <div class="canvas-wrap">
                <canvas id="roomCanvas" width="600" height="450"></canvas>
            </div>
        </div>

        <div class="section">
            <div class="section-title">Furniture Placement &amp; Budget</div>
            <div id="furnitureContainer"></div>
        </div>

        <div class="section">
            <div class="section-title">Design Style Details</div>
            <div class="detail-row">
                <span class="detail-icon">📋</span>
                <div>
                    <div class="detail-title">About the Design</div>
                    <div class="detail-text"><%= description %></div>
                </div>
            </div>
            <div class="detail-row">
                <span class="detail-icon">🎨</span>
                <div>
                    <div class="detail-title">Suggested Colors</div>
                    <div class="detail-text"><%= rang %></div>
                </div>
            </div>
            <div class="detail-row">
                <span class="detail-icon">💡</span>
                <div>
                    <div class="detail-title">Expert Tip</div>
                    <div class="detail-text"><%= suggestion %></div>
                </div>
            </div>
        </div>

    </div>

    <!-- Room Suggestions Section -->
    <div class="section">
        <div class="section-title">Essential Items for Your Room</div>

        <div style="margin-bottom:20px;">
            <div style="font-weight:bold; color:#5a3e28; margin-bottom:10px; font-size:14px;">
                ✅ Must-Have Items
            </div>
            <div id="zarooriList"></div>
        </div>

        <div style="margin-bottom:20px;">
            <div style="font-weight:bold; color:#7a5c40; margin-bottom:10px; font-size:14px;">
                ➕ Optional Items
            </div>
            <div id="optionalList"></div>
        </div>

        <div style="margin-bottom:20px;">
            <div style="font-weight:bold; color:#1a73e8; margin-bottom:10px; font-size:14px;">
                💡 Design Tips
            </div>
            <div id="designTipsList"></div>
        </div>

        <div>
            <div style="font-weight:bold; color:#e65100; margin-bottom:10px; font-size:14px;">
                🏠 Vastu Tips
            </div>
            <div id="vastuTipsList"></div>
        </div>
    </div>

    <div class="cta-box">
        <h3>Want to Build Your Design in Reality?</h3>
        <p>RK Group team will visit your home for a FREE consultation and estimate.</p>
        <a href="<%= request.getContextPath() %>/index.jsp" class="cta-btn">Book Free Visit</a>
    </div>
</div>

<script>
var furnitureData  = <%= furnitureList %>;
var budgetData     = <%= budgetBreakdown %>;
var placementData  = <%= placement %>;
var roomL = <%= roomLength %>;
var roomW = <%= roomWidth %>;

function drawFurnitureList() {
    var container = document.getElementById('furnitureContainer');
    var html = '';
    for (var i = 0; i < furnitureData.length; i++) {
        var name     = furnitureData[i];
        var pos      = placementData[name] || '';
        var price    = budgetData[name] || '';
        var priceStr = price ? 'Rs. ' + price.toLocaleString('en-IN') : '';
        html += '<div class="furniture-item">' +
                  '<div>' +
                    '<div class="furniture-name">' + (i+1) + '. ' + name + '</div>' +
                    '<div class="furniture-pos">📍 ' + pos + '</div>' +
                  '</div>' +
                  '<div class="furniture-price">' + priceStr + '</div>' +
                '</div>';
    }
    if (budgetData['Total']) {
        html += '<div class="budget-total">' +
                  '<span>Estimated Total</span>' +
                  '<span>Rs. ' + budgetData['Total'].toLocaleString('en-IN') + '</span>' +
                '</div>';
    }
    container.innerHTML = html;
}

function draw2DLayout() {
    var canvas = document.getElementById('roomCanvas');
    var ctx    = canvas.getContext('2d');
    var cw = canvas.width;
    var ch = canvas.height;
    var padding = 50;
    var scale = Math.min((cw - padding*2) / roomL, (ch - padding*2) / roomW);
    var roomPxW = roomL * scale;
    var roomPxH = roomW * scale;
    var startX  = (cw - roomPxW) / 2;
    var startY  = (ch - roomPxH) / 2;

    ctx.fillStyle = '#faf7f4';
    ctx.fillRect(0, 0, cw, ch);
    ctx.fillStyle = '#f0e8e0';
    ctx.fillRect(startX, startY, roomPxW, roomPxH);
    ctx.strokeStyle = '#5a3e28';
    ctx.lineWidth = 3;
    ctx.strokeRect(startX, startY, roomPxW, roomPxH);

    ctx.strokeStyle = '#e8e0d8';
    ctx.lineWidth = 0.5;
    for (var x = startX + scale; x < startX + roomPxW; x += scale) {
        ctx.beginPath(); ctx.moveTo(x, startY); ctx.lineTo(x, startY + roomPxH); ctx.stroke();
    }
    for (var y = startY + scale; y < startY + roomPxH; y += scale) {
        ctx.beginPath(); ctx.moveTo(startX, y); ctx.lineTo(startX + roomPxW, y); ctx.stroke();
    }

    var colors = ['#a8d8ea','#aa96da','#fcbad3','#ffffd2','#b8e0d2','#d6eadf'];
    var boxes  = getFurnitureBoxes(roomL, roomW, scale, startX, startY);
    for (var i = 0; i < boxes.length; i++) {
        var fb = boxes[i];
        ctx.fillStyle   = colors[i % colors.length];
        ctx.globalAlpha = 0.8;
        ctx.fillRect(fb.x, fb.y, fb.w, fb.h);
        ctx.globalAlpha = 1;
        ctx.strokeStyle = '#666';
        ctx.lineWidth   = 1;
        ctx.strokeRect(fb.x, fb.y, fb.w, fb.h);
        ctx.fillStyle  = '#333';
        ctx.font       = 'bold 10px Arial';
        ctx.textAlign  = 'center';
        ctx.fillText(fb.label, fb.x + fb.w/2, fb.y + fb.h/2 + 4);
    }

    ctx.strokeStyle = '#e65100';
    ctx.lineWidth   = 4;
    ctx.beginPath();
    ctx.moveTo(startX + roomPxW * 0.1,  startY + roomPxH);
    ctx.lineTo(startX + roomPxW * 0.25, startY + roomPxH);
    ctx.stroke();
    ctx.fillStyle  = '#e65100';
    ctx.font       = 'bold 11px Arial';
    ctx.textAlign  = 'center';
    ctx.fillText('DOOR', startX + roomPxW * 0.175, startY + roomPxH + 18);

    ctx.strokeStyle = '#1a73e8';
    ctx.lineWidth   = 4;
    ctx.beginPath();
    ctx.moveTo(startX + roomPxW * 0.6, startY);
    ctx.lineTo(startX + roomPxW * 0.8, startY);
    ctx.stroke();
    ctx.fillStyle  = '#1a73e8';
    ctx.font       = 'bold 11px Arial';
    ctx.textAlign  = 'center';
    ctx.fillText('WINDOW', startX + roomPxW * 0.7, startY - 8);

    ctx.fillStyle  = '#5a3e28';
    ctx.font       = 'bold 12px Arial';
    ctx.textAlign  = 'center';
    ctx.fillText(roomL + " ft", startX + roomPxW/2, startY + roomPxH + 35);
    ctx.save();
    ctx.translate(startX - 15, startY + roomPxH/2);
    ctx.rotate(-Math.PI/2);
    ctx.fillText(roomW + " ft", 0, 0);
    ctx.restore();
}

function getFurnitureBoxes(rl, rw, scale, sx, sy) {
    var boxes = [];
    var data  = furnitureData;

    if (data.indexOf('Single Bed') >= 0 || data.indexOf('Double Bed') >= 0 || data.indexOf('King Size Bed') >= 0) {
        boxes.push({ x: sx+scale*0.5, y: sy+scale*0.5, w: scale*6, h: scale*5, label:'BED' });
        boxes.push({ x: sx+scale*0.5, y: sy+scale*6,   w: scale*3, h: scale*2, label:'WARDROBE' });
        if (data.indexOf('Dressing Table') >= 0)
            boxes.push({ x: sx+rl*scale-scale*3.5, y: sy+scale*0.5, w: scale*3, h: scale*1.5, label:'DRESSING' });
        if (data.indexOf('Study Table') >= 0)
            boxes.push({ x: sx+rl*scale-scale*3.5, y: sy+scale*0.5, w: scale*3, h: scale*2, label:'STUDY TABLE' });
        if (data.indexOf('Sofa Chair') >= 0)
            boxes.push({ x: sx+rl*scale-scale*3, y: sy+rw*scale-scale*3.5, w: scale*3, h: scale*3, label:'SOFA CHAIR' });

    } else if (data.indexOf('3 Seater Sofa') >= 0 || data.indexOf('L-Shape Sofa') >= 0 || data.indexOf('Sectional Sofa') >= 0) {
        boxes.push({ x: sx+scale*0.5, y: sy+rw*scale-scale*3, w: scale*6, h: scale*2.5, label:'SOFA' });
        boxes.push({ x: sx+scale*2,   y: sy+rw*scale-scale*5, w: scale*3, h: scale*2,   label:'CENTER TABLE' });
        boxes.push({ x: sx+scale*0.5, y: sy+scale*0.5,        w: scale*5, h: scale*1.5, label:'TV UNIT' });
        if (data.indexOf('Display Cabinet') >= 0)
            boxes.push({ x: sx+rl*scale-scale*3.5, y: sy+scale*0.5, w: scale*3, h: scale*2, label:'CABINET' });

    } else {
        boxes.push({ x: sx+scale*0.5, y: sy+scale*0.5, w: scale*(rl-1), h: scale*2,     label:'PLATFORM' });
        boxes.push({ x: sx+scale*0.5, y: sy+scale*3,   w: scale*2,       h: scale*(rw-4), label:'CABINETS' });
        if (data.indexOf('Island Kitchen') >= 0)
            boxes.push({ x: sx+rl*scale/2-scale*2.5, y: sy+rw*scale/2-scale*1.5, w: scale*5, h: scale*3, label:'ISLAND' });
    }
    return boxes;
}

var roomSuggestions = <%= roomSuggestions %>;

function drawRoomSuggestions() {
    var zaroori = roomSuggestions['zaroori_cheezein'] || [];
    var zHtml = '';
    for (var i = 0; i < zaroori.length; i++) {
        zHtml += '<div style="padding:6px 0; border-bottom:1px solid #f5f0eb; font-size:13px; color:#333;">' +
                 '✔ ' + zaroori[i] + '</div>';
    }
    document.getElementById('zarooriList').innerHTML = zHtml;

    var optional = roomSuggestions['optional_cheezein'] || [];
    var oHtml = '';
    for (var i = 0; i < optional.length; i++) {
        oHtml += '<div style="padding:6px 0; border-bottom:1px solid #f5f0eb; font-size:13px; color:#555;">' +
                 '◦ ' + optional[i] + '</div>';
    }
    document.getElementById('optionalList').innerHTML = oHtml;

    var tips = roomSuggestions['design_tips'] || [];
    var tHtml = '';
    for (var i = 0; i < tips.length; i++) {
        tHtml += '<div style="padding:6px 0; border-bottom:1px solid #f5f0eb; font-size:13px; color:#333;">' +
                 (i+1) + '. ' + tips[i] + '</div>';
    }
    document.getElementById('designTipsList').innerHTML = tHtml;

    var vastu = roomSuggestions['vastu_tips'] || [];
    var vHtml = '';
    for (var i = 0; i < vastu.length; i++) {
        vHtml += '<div style="padding:6px 0; border-bottom:1px solid #f5f0eb; font-size:13px; color:#333;">' +
                 '🔸 ' + vastu[i] + '</div>';
    }
    document.getElementById('vastuTipsList').innerHTML = vHtml;
}

window.onload = function() {
    drawFurnitureList();
    draw2DLayout();
    drawRoomSuggestions();
};
</script>
</body>
</html>
