/* ===== Bản anime: nền thành phố lúc hoàng hôn + hoa anh đào rơi ===== */
(() => {
  const DPR = Math.min(devicePixelRatio || 1, 2);
  const sky = document.getElementById("sky"), sk = document.getElementById("sakura");
  const sx = sky.getContext("2d"), px = sk.getContext("2d");
  let W = 0, H = 0;

  // vẽ một lần: mặt trời, mây hồng, hai lớp nhà cao tầng có cửa sổ sáng
  function drawSky() {
    sx.setTransform(DPR, 0, 0, DPR, 0, 0);
    sx.clearRect(0, 0, W, H);
    let seed = 7; const rnd = () => (seed = (seed * 16807) % 2147483647) / 2147483647;
    // mặt trời to, mờ
    const sunY = H * .86, sunR = Math.min(W, H) * .22;
    const g = sx.createRadialGradient(W * .5, sunY, 0, W * .5, sunY, sunR * 2.2);
    g.addColorStop(0, "rgba(255,236,200,.85)"); g.addColorStop(.35, "rgba(255,170,160,.35)"); g.addColorStop(1, "rgba(255,140,160,0)");
    sx.fillStyle = g; sx.fillRect(0, 0, W, H);
    // mây dải ngang
    for (let i = 0; i < 7; i++) {
      const y = H * (.58 + rnd() * .22), x = rnd() * W, w = W * (.35 + rnd() * .5), h = 10 + rnd() * 18;
      sx.fillStyle = `rgba(255,${190 + rnd() * 40 | 0},${200 + rnd() * 30 | 0},${.18 + rnd() * .2})`;
      sx.beginPath(); sx.ellipse(x, y, w / 2, h, 0, 0, 7); sx.fill();
    }
    // nhà: lớp xa nhạt, lớp gần đậm
    const layer = (base, hMax, col, win) => {
      let x = -10;
      while (x < W + 10) {
        const w = 18 + rnd() * 46, h = H * (.04 + rnd() * hMax);
        sx.fillStyle = col; sx.fillRect(x, H - base - h, w, h + base);
        if (rnd() < .25) sx.fillRect(x + w / 2 - 1, H - base - h - 14, 2, 14); // ăng-ten
        if (win) for (let yy = H - base - h + 6; yy < H - 6; yy += 9)
          for (let xx = x + 4; xx < x + w - 5; xx += 7)
            if (rnd() < .22) { sx.fillStyle = rnd() < .5 ? "rgba(255,214,150,.85)" : "rgba(255,170,210,.7)"; sx.fillRect(xx, yy, 3, 4); sx.fillStyle = col; }
        x += w + rnd() * 4;
      }
    };
    layer(0, .13, "#7a3a86", false);
    layer(0, .08, "#2a1446", true);
  }

  // cánh hoa
  const N = innerWidth < 600 ? 28 : 42, P = [];
  const mk = (top) => ({ x: Math.random() * W, y: top ? -20 - Math.random() * H * .3 : Math.random() * H,
    s: 6 + Math.random() * 8, vy: 22 + Math.random() * 30, vx: 8 + Math.random() * 16,
    a: Math.random() * 6.28, va: (Math.random() - .5) * 2, f: Math.random() * 6.28, vf: 1.5 + Math.random() * 2.5,
    sw: Math.random() * 6.28, o: .55 + Math.random() * .4 });
  function petal(p) {
    px.save(); px.translate(p.x + Math.sin(p.sw) * 18, p.y); px.rotate(p.a); px.scale(Math.cos(p.f), 1);
    px.globalAlpha = p.o;
    const s = p.s, g = px.createLinearGradient(0, -s, 0, s);
    g.addColorStop(0, "#fff0f6"); g.addColorStop(1, "#ff9fc6");
    px.fillStyle = g; px.beginPath();
    px.moveTo(0, s); px.bezierCurveTo(s * 1.1, s * .2, s * .7, -s * .9, s * .18, -s); // khía chữ V ở đầu cánh
    px.lineTo(0, -s * .7); px.lineTo(-s * .18, -s);
    px.bezierCurveTo(-s * .7, -s * .9, -s * 1.1, s * .2, 0, s); px.fill();
    px.restore();
  }
  let last = performance.now();
  function tick(t) {
    const dt = Math.min((t - last) / 1000, .05); last = t;
    px.setTransform(DPR, 0, 0, DPR, 0, 0); px.clearRect(0, 0, W, H);
    for (const p of P) {
      p.y += p.vy * dt; p.x += p.vx * dt; p.a += p.va * dt; p.f += p.vf * dt; p.sw += dt * .9;
      if (p.y > H + 20 || p.x > W + 40) Object.assign(p, mk(true), { x: Math.random() * W * 1.2 - W * .3 });
      petal(p);
    }
    requestAnimationFrame(tick);
  }
  function size() {
    W = innerWidth; H = innerHeight;
    for (const c of [sky, sk]) { c.width = W * DPR; c.height = H * DPR; }
    drawSky();
  }
  size(); addEventListener("resize", size);
  for (let i = 0; i < N; i++) P.push(mk(false));
  if (!matchMedia("(prefers-reduced-motion: reduce)").matches) requestAnimationFrame(tick);
})();
