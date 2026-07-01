<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>NEXUS-7 // MAP HACK + AIMBOT + SKIN INJECTOR [UNDETECTED]</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&family=Orbitron:wght@700;900&display=swap');

  :root{
    --bg:#050807;
    --panel:#0a1310;
    --line:#173025;
    --acid:#39ff6a;
    --acid-dim:#1e8f3f;
    --red:#ff2d47;
    --amber:#ffb400;
    --text:#c8ffd8;
  }
  *{box-sizing:border-box;}
  body{
    margin:0;
    background:
      radial-gradient(ellipse at 50% -10%, #0e1a14 0%, var(--bg) 60%);
    color:var(--text);
    font-family:'Share Tech Mono', monospace;
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:24px;
    overflow-x:hidden;
  }
  body::before{
    content:"";
    position:fixed;inset:0;
    background:repeating-linear-gradient(0deg, rgba(57,255,106,0.035) 0px, rgba(57,255,106,0.035) 1px, transparent 1px, transparent 3px);
    pointer-events:none;
    z-index:5;
  }

  .frame{
    width:100%;
    max-width:640px;
    border:1px solid var(--line);
    background:linear-gradient(180deg, var(--panel), #060d0a);
    box-shadow:0 0 0 1px #000, 0 0 40px rgba(57,255,106,0.08), inset 0 0 60px rgba(0,0,0,0.6);
    position:relative;
  }
  .frame::after{
    content:"";
    position:absolute; inset:-1px;
    border:1px solid transparent;
    box-shadow:0 0 18px var(--acid-dim);
    opacity:.35;
    pointer-events:none;
  }

  .titlebar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:10px 14px;
    background:linear-gradient(90deg,#0d1a13,#081209);
    border-bottom:1px solid var(--line);
    font-family:'Orbitron',sans-serif;
    font-weight:900;
    font-size:13px;
    letter-spacing:2px;
  }
  .titlebar .logo{color:var(--acid); text-shadow:0 0 8px var(--acid);}
  .titlebar .dots span{
    display:inline-block; width:9px;height:9px;border-radius:50%;margin-left:6px;
    background:#173025; border:1px solid var(--acid-dim);
  }

  .body{padding:22px 22px 26px;}

  .status-row{
    display:flex; gap:10px; flex-wrap:wrap;
    font-size:11px; margin-bottom:18px; letter-spacing:1px;
  }
  .pill{
    border:1px solid var(--acid-dim);
    padding:4px 10px;
    color:var(--acid);
    background:rgba(57,255,106,0.05);
  }
  .pill.red{ border-color:var(--red); color:var(--red); background:rgba(255,45,71,0.06);}

  h1{
    font-family:'Orbitron',sans-serif;
    font-size:22px;
    margin:0 0 4px;
    letter-spacing:3px;
    color:#eafff0;
  }
  h1 span{color:var(--acid); text-shadow:0 0 10px var(--acid);}
  .sub{ font-size:12px; color:var(--acid-dim); margin-bottom:20px;}

  .toggles{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:10px 18px;
    margin-bottom:20px;
  }
  .toggle{
    display:flex; justify-content:space-between; align-items:center;
    border:1px solid var(--line);
    padding:9px 12px;
    font-size:12px;
    background:rgba(255,255,255,0.015);
  }
  .switch{
    width:36px;height:18px;
    background:#0d1a13;
    border:1px solid var(--acid-dim);
    position:relative;
    cursor:pointer;
  }
  .switch::after{
    content:"";
    position:absolute; top:2px; left:2px;
    width:12px;height:12px;
    background:var(--acid-dim);
    transition:.15s;
  }
  .switch.on{ border-color:var(--acid); box-shadow:0 0 8px var(--acid-dim);}
  .switch.on::after{ left:18px; background:var(--acid); box-shadow:0 0 6px var(--acid);}

  .slider-row{ margin-bottom:20px; }
  .slider-row label{ font-size:12px; display:flex; justify-content:space-between; margin-bottom:6px; color:var(--amber);}
  input[type=range]{
    width:100%;
    accent-color:var(--acid);
    background:transparent;
  }

  .console{
    background:#000;
    border:1px solid var(--line);
    height:110px;
    overflow:hidden;
    font-size:11px;
    padding:8px 10px;
    margin-bottom:22px;
    color:var(--acid-dim);
    line-height:1.6;
    position:relative;
  }
  .console .cursor{ color:var(--acid);}

  .inject-btn{
    width:100%;
    padding:16px;
    font-family:'Orbitron',sans-serif;
    font-weight:900;
    font-size:16px;
    letter-spacing:3px;
    background:linear-gradient(180deg, #1e8f3f, #0c4020);
    color:#eafff0;
    border:1px solid var(--acid);
    cursor:pointer;
    box-shadow:0 0 20px rgba(57,255,106,0.25), inset 0 0 20px rgba(0,0,0,0.3);
    transition:transform .08s ease;
  }
  .inject-btn:hover{ filter:brightness(1.15); }
  .inject-btn:active{ transform:scale(0.98); }

  .footer-note{
    text-align:center;
    font-size:10px;
    color:#2f5c40;
    margin-top:14px;
    letter-spacing:1px;
  }

  /* overlay */
  .overlay{
    position:fixed; inset:0;
    background:#000;
    display:none;
    align-items:center;
    justify-content:center;
    flex-direction:column;
    z-index:50;
    text-align:center;
    padding:20px;
  }
  .overlay.show{ display:flex; }
  .overlay h2{
    font-family:'Orbitron',sans-serif;
    color:var(--red);
    text-shadow:0 0 14px var(--red);
    letter-spacing:4px;
    font-size:clamp(20px,5vw,34px);
    margin-bottom:18px;
    animation:flicker 1.4s infinite;
  }
  @keyframes flicker{
    0%,100%{opacity:1;} 50%{opacity:.7;}
  }
  .overlay iframe{
    width:min(90vw,720px);
    aspect-ratio:16/9;
    border:2px solid var(--red);
    box-shadow:0 0 40px var(--red);
  }
  .overlay p{
    margin-top:16px;
    color:var(--acid);
    font-size:13px;
    max-width:560px;
  }

  /* flashbang */
  .flashbang{
    position:fixed; inset:0;
    background:#fff;
    z-index:100;
    display:none;
    pointer-events:none;
  }
  .flashbang.show{ display:block; animation:flashpop 0.9s ease-out forwards; }
  @keyframes flashpop{
    0%{opacity:0;}
    5%{opacity:1;}
    60%{opacity:1;}
    100%{opacity:0;}
  }

  /* authorize key screen */
  .authbox{
    width:100%; max-width:640px;
    display:none;
  }
  .authbox.show{ display:block; }
  .authbox input[type=text]{
    width:100%;
    background:#000;
    border:1px solid var(--acid-dim);
    color:var(--acid);
    font-family:'Share Tech Mono',monospace;
    font-size:14px;
    padding:12px;
    letter-spacing:2px;
    margin-bottom:14px;
  }
  .authbox input[type=text]:focus{ outline:none; border-color:var(--acid); box-shadow:0 0 10px var(--acid-dim);}
  .auth-btn{
    width:100%;
    padding:14px;
    font-family:'Orbitron',sans-serif;
    font-weight:900;
    letter-spacing:3px;
    background:linear-gradient(180deg,#8f1e2f,#400c14);
    color:#ffeaea;
    border:1px solid var(--red);
    cursor:pointer;
    box-shadow:0 0 16px rgba(255,45,71,0.25);
  }
  .auth-btn:hover{ filter:brightness(1.15); }
  .auth-err{ color:var(--red); font-size:11px; margin-top:8px; min-height:14px; }

  .progress-wrap{
    display:none;
    width:100%; max-width:640px;
  }
  .progress-wrap.show{ display:block; }
  .progress-label{
    display:flex; justify-content:space-between;
    font-size:12px; margin-bottom:8px; color:var(--amber);
  }
  .progress-track{
    width:100%; height:22px;
    background:#000;
    border:1px solid var(--acid-dim);
    overflow:hidden;
    position:relative;
  }
  .progress-fill{
    height:100%; width:0%;
    background:repeating-linear-gradient(90deg, var(--acid) 0px, var(--acid) 8px, var(--acid-dim) 8px, var(--acid-dim) 14px);
    box-shadow:0 0 12px var(--acid);
    transition:width .12s linear;
  }
  .progress-pct{
    text-align:center;
    font-family:'Orbitron',sans-serif;
    font-size:28px;
    margin-top:10px;
    color:var(--acid);
    text-shadow:0 0 10px var(--acid);
  }

  .success-box{
    display:none;
    text-align:center;
  }
  .success-box.show{ display:block; }
  .success-box h2{
    font-family:'Orbitron',sans-serif;
    color:var(--acid);
    text-shadow:0 0 14px var(--acid);
    letter-spacing:3px;
    font-size:clamp(18px,4.5vw,28px);
    margin-bottom:10px;
  }
  .success-box .link-btn{
    display:inline-block;
    margin-top:16px;
    padding:14px 28px;
    background:linear-gradient(180deg,#1e8f3f,#0c4020);
    color:#eafff0;
    border:1px solid var(--acid);
    font-family:'Orbitron',sans-serif;
    font-weight:900;
    letter-spacing:2px;
    text-decoration:none;
    box-shadow:0 0 20px rgba(57,255,106,0.3);
  }
</style>
</head>
<body>

  <div class="frame">
    <div class="titlebar">
      <div class="logo">NEXUS‑7</div>
      <div>LOADER v9.3.1 — UNDETECTED</div>
      <div class="dots"><span></span><span></span><span></span></div>
    </div>

    <div class="body">
      <div class="status-row">
        <div class="pill">● INJECTOR: READY</div>
        <div class="pill">● BYPASS: ACTIVE</div>
        <div class="pill red">● HWID SPOOF: STANDBY</div>
      </div>

      <h1>MAP HACK <span>+</span> AIMBOT <span>+</span> SKIN INJECTOR</h1>
      <div class="sub">// 100% undetected · works on every game · trust me bro</div>

      <div class="toggles">
        <div class="toggle">Wallhack / ESP <div class="switch on" onclick="this.classList.toggle('on')"></div></div>
        <div class="toggle">Aimbot <div class="switch on" onclick="this.classList.toggle('on')"></div></div>
        <div class="toggle">Full Map Reveal <div class="switch on" onclick="this.classList.toggle('on')"></div></div>
        <div class="toggle">Rare Skin Unlocker <div class="switch on" onclick="this.classList.toggle('on')"></div></div>
        <div class="toggle">Speed Hack <div class="switch" onclick="this.classList.toggle('on')"></div></div>
        <div class="toggle">Anti‑Ban Shield <div class="switch on" onclick="this.classList.toggle('on')"></div></div>
      </div>

      <div class="slider-row">
        <label><span>AIM SMOOTHNESS</span><span id="smoothVal">42</span></label>
        <input type="range" min="0" max="100" value="42" oninput="document.getElementById('smoothVal').innerText=this.value">
      </div>
      <div class="slider-row">
        <label><span>ESP RENDER DISTANCE</span><span id="espVal">78</span></label>
        <input type="range" min="0" max="100" value="78" oninput="document.getElementById('espVal').innerText=this.value">
      </div>

      <div class="console" id="console"><span class="cursor">&gt;_</span></div>

      <button class="inject-btn" id="injectBtn" onclick="showAuth()">▶ INJECT NOW</button>
      <div class="footer-note">DISCLAIMER: THIS TOOL DOES EXACTLY WHAT IT LOOKS LIKE IT SHOULDN'T</div>

      <!-- authorize key step -->
      <div class="authbox" id="authbox">
        <label style="font-size:12px;color:var(--amber);display:block;margin-bottom:8px;">ENTER AUTHORIZATION KEY TO CONTINUE INJECTION</label>
        <input type="text" id="authInput" placeholder="XXXX-XXXX-XXXX-XXXX" value="NEXUS-7734-INJ-0001">
        <button class="auth-btn" onclick="runInject()">AUTHORIZE &amp; INJECT</button>
        <div class="auth-err" id="authErr"></div>
      </div>

      <!-- progress bar step -->
      <div class="progress-wrap" id="progressWrap">
        <div class="progress-label"><span>INJECTING PAYLOAD...</span><span id="progressStatus">initializing</span></div>
        <div class="progress-track"><div class="progress-fill" id="progressFill"></div></div>
        <div class="progress-pct" id="progressPct">0%</div>
      </div>
    </div>
  </div>

  <div class="flashbang" id="flashbang"></div>

  <div class="overlay" id="overlay">
    <div class="success-box" id="successBox">
      <h2>✔ ACCESS GRANTED — YOU HAVE ACCESS ON LINK</h2>
      <p style="color:var(--acid);font-size:13px;">Authorization confirmed. Injection complete. Click below to claim your reward.</p>
      <a class="link-btn" id="rewardLink" href="#" target="_blank" rel="noopener">OPEN LINK</a>
    </div>
  </div>

<script>
/* ============================================================
   EDIT THIS LINE to set where "OPEN LINK" sends people.
   ============================================================ */
const CUSTOM_LINK = "https://www.youtube.com/watch?v=dQw4w9WgXcQ";

const lines = [
  "connecting to game process...",
  "bypassing anti-cheat kernel driver...",
  "spoofing HWID...",
  "loading skin database (14,822 items)...",
  "injecting aimbot.dll into memory...",
  "patching map reveal shader...",
  "handshake with C2 server established...",
  "finalizing undetection layer...",
];

function showAuth(){
  document.getElementById('injectBtn').style.display = "none";
  document.getElementById('authbox').classList.add('show');
}

function runInject(){
  const key = document.getElementById('authInput').value.trim();
  const err = document.getElementById('authErr');
  if(key.length < 4){
    err.textContent = "INVALID KEY — enter any key to continue.";
    return;
  }
  err.textContent = "";
  document.getElementById('authbox').classList.remove('show');
  document.getElementById('progressWrap').classList.add('show');
  runConsole();
  runProgress();
}

function runConsole(){
  const consoleEl = document.getElementById('console');
  consoleEl.innerHTML = "";
  let i = 0;
  const interval = setInterval(() => {
    if(i < lines.length){
      const p = document.createElement('div');
      p.textContent = "[OK] " + lines[i];
      consoleEl.appendChild(p);
      consoleEl.scrollTop = consoleEl.scrollHeight;
      i++;
    } else {
      clearInterval(interval);
    }
  }, 320);
}

function runProgress(){
  const fill = document.getElementById('progressFill');
  const pct = document.getElementById('progressPct');
  const status = document.getElementById('progressStatus');
  const statusLabels = ["initializing","bypassing anti-cheat","spoofing HWID","injecting payload","patching memory","finalizing"];
  let p = 0;
  const interval = setInterval(() => {
    p += Math.floor(Math.random()*4) + 2; // random 2-100 step
    if(p >= 100){
      p = 100;
      clearInterval(interval);
      fill.style.width = "100%";
      pct.textContent = "100%";
      status.textContent = "complete";
      setTimeout(triggerFlashbang, 400);
      return;
    }
    fill.style.width = p + "%";
    pct.textContent = p + "%";
    status.textContent = statusLabels[Math.floor((p/100)*statusLabels.length)];
  }, 140);
}

function triggerFlashbang(){
  const flash = document.getElementById('flashbang');
  flash.classList.add('show');
  setTimeout(() => {
    flash.classList.remove('show');
    showSuccess();
  }, 850);
}

function showSuccess(){
  document.getElementById('rewardLink').href = CUSTOM_LINK;
  document.getElementById('overlay').classList.add('show');
  document.getElementById('successBox').classList.add('show');
}
</script>
</body>
</html>
