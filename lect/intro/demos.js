// Live demos for the emergence slides. Each demo runs only while its slide is shown.
(function () {
  const demos = {};

  // Keep keyboard navigation working after a control has been clicked.
  function releaseFocus(el) { el.addEventListener('change', () => el.blur()); el.addEventListener('click', () => el.blur()); }

  function animated(step) {
    let raf = null;
    const loop = () => { step(); raf = requestAnimationFrame(loop); };
    return {
      start() { if (raf === null) raf = requestAnimationFrame(loop); },
      stop() { if (raf !== null) cancelAnimationFrame(raf); raf = null; }
    };
  }

  // Map a pointer event to canvas pixel coordinates (slides are CSS-scaled by reveal.js).
  function canvasPoint(canvas, e) {
    const r = canvas.getBoundingClientRect();
    return [(e.clientX - r.left) * canvas.width / r.width, (e.clientY - r.top) * canvas.height / r.height];
  }

  // ---------------------------------------------------------------- Game of Life (Conway 1970)
  // Gosper glider gun, emits a glider every 30 generations.
  const GLIDER_GUN = [[24,0],[22,1],[24,1],[12,2],[13,2],[20,2],[21,2],[34,2],[35,2],[11,3],[15,3],[20,3],[21,3],[34,3],[35,3],
    [0,4],[1,4],[10,4],[16,4],[20,4],[21,4],[0,5],[1,5],[10,5],[14,5],[16,5],[17,5],[22,5],[24,5],[10,6],[16,6],[24,6],[11,7],[15,7],[12,8],[13,8]];

  function gameOfLife(section) {
    const canvas = section.querySelector('canvas');
    const ctx = canvas.getContext('2d');
    const COLS = 86, ROWS = 52, CELL = canvas.width / COLS;
    // A hidden margin with a cleared outer ring lets gliders leave the field instead of wrapping around.
    const M = 6, C = COLS + 2 * M, R = ROWS + 2 * M, FRAMES_PER_GENERATION = 6;
    let a = new Uint8Array(C * R), b = new Uint8Array(C * R), running = true, frame = 0;

    function generation() {
      for (let y = 1; y < R - 1; y++)
        for (let x = 1; x < C - 1; x++) {
          const i = y * C + x;
          const n = a[i - C - 1] + a[i - C] + a[i - C + 1] + a[i - 1] + a[i + 1] + a[i + C - 1] + a[i + C] + a[i + C + 1];
          b[i] = (n === 3 || (n === 2 && a[i])) ? 1 : 0;
        }
      for (let x = 0; x < C; x++) { b[x] = 0; b[(R - 1) * C + x] = 0; }
      for (let y = 0; y < R; y++) { b[y * C] = 0; b[y * C + C - 1] = 0; }
      [a, b] = [b, a];
    }

    function draw() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      ctx.fillStyle = '#1954a6';
      for (let y = 0; y < ROWS; y++)
        for (let x = 0; x < COLS; x++)
          if (a[(y + M) * C + x + M]) ctx.fillRect(x * CELL + 1, y * CELL + 1, CELL - 2, CELL - 2);
    }

    const clear = () => a.fill(0);
    function random() { clear(); for (let y = 0; y < ROWS; y++) for (let x = 0; x < COLS; x++) a[(y + M) * C + x + M] = Math.random() < 0.3 ? 1 : 0; }
    function gun() { clear(); for (const [x, y] of GLIDER_GUN) a[(y + 4 + M) * C + x + 4 + M] = 1; }

    const actions = { random, gun, clear, step: generation };
    section.querySelectorAll('[data-action]').forEach(btn => {
      releaseFocus(btn);
      btn.addEventListener('click', () => { actions[btn.dataset.action](); draw(); });
    });
    const play = section.querySelector('[data-action-toggle="run"]');
    releaseFocus(play);
    play.addEventListener('click', () => { running = !running; play.classList.toggle('on', running); play.textContent = running ? 'Pause' : 'Play'; });

    let painting = false;
    const paint = e => {
      const [px, py] = canvasPoint(canvas, e), x = px / CELL | 0, y = py / CELL | 0;
      if (x >= 0 && x < COLS && y >= 0 && y < ROWS) { a[(y + M) * C + x + M] = 1; draw(); }
    };
    canvas.addEventListener('pointerdown', e => { painting = true; paint(e); });
    canvas.addEventListener('pointermove', e => { if (painting) paint(e); });
    window.addEventListener('pointerup', () => { painting = false; });

    random(); draw();
    return animated(() => { if (running && ++frame % FRAMES_PER_GENERATION === 0) { generation(); draw(); } });
  }

  // ---------------------------------------------------------------- Flocking (Reynolds 1987)
  function flocking(section) {
    const canvas = section.querySelector('canvas');
    const ctx = canvas.getContext('2d');
    const scale = 2, W = canvas.width / scale, H = canvas.height / scale;
    const N = 160, R = 55, RS = 24, MAX_SPEED = 3, MIN_SPEED = 1.2, MAX_FORCE = 0.05;
    const rules = { sep: true, ali: true, coh: true };
    const x = new Float32Array(N), y = new Float32Array(N), vx = new Float32Array(N), vy = new Float32Array(N);

    function scatter() {
      for (let i = 0; i < N; i++) {
        x[i] = Math.random() * W; y[i] = Math.random() * H;
        const a = Math.random() * 2 * Math.PI, s = MIN_SPEED + Math.random() * (MAX_SPEED - MIN_SPEED);
        vx[i] = s * Math.cos(a); vy[i] = s * Math.sin(a);
      }
    }

    // Steering force towards a desired direction at full speed, capped at MAX_FORCE.
    function steer(dx, dy, i) {
      const m = Math.hypot(dx, dy);
      if (m === 0) return [0, 0];
      let fx = dx / m * MAX_SPEED - vx[i], fy = dy / m * MAX_SPEED - vy[i];
      const f = Math.hypot(fx, fy);
      if (f > MAX_FORCE) { fx *= MAX_FORCE / f; fy *= MAX_FORCE / f; }
      return [fx, fy];
    }

    function update() {
      const ax = new Float32Array(N), ay = new Float32Array(N);
      for (let i = 0; i < N; i++) {
        let n = 0, cx = 0, cy = 0, avx = 0, avy = 0, sx = 0, sy = 0;
        for (let j = 0; j < N; j++) {
          if (i === j) continue;
          const dx = x[j] - x[i], dy = y[j] - y[i], d2 = dx * dx + dy * dy;
          if (d2 > R * R) continue;
          n++; cx += dx; cy += dy; avx += vx[j]; avy += vy[j];
          if (d2 < RS * RS && d2 > 0) { sx -= dx / d2; sy -= dy / d2; }
        }
        if (n > 0) {
          if (rules.sep) { const f = steer(sx, sy, i); ax[i] += 1.6 * f[0]; ay[i] += 1.6 * f[1]; }
          if (rules.ali) { const f = steer(avx, avy, i); ax[i] += f[0]; ay[i] += f[1]; }
          if (rules.coh) { const f = steer(cx, cy, i); ax[i] += f[0]; ay[i] += f[1]; }
        }
        ax[i] += (Math.random() - 0.5) * 0.03; ay[i] += (Math.random() - 0.5) * 0.03;
      }
      for (let i = 0; i < N; i++) {
        vx[i] += ax[i]; vy[i] += ay[i];
        const s = Math.hypot(vx[i], vy[i]);
        const t = Math.min(MAX_SPEED, Math.max(MIN_SPEED, s)) / (s || 1);
        vx[i] *= t; vy[i] *= t;
        x[i] = (x[i] + vx[i] + W) % W; y[i] = (y[i] + vy[i] + H) % H;
      }
    }

    function draw() {
      ctx.setTransform(scale, 0, 0, scale, 0, 0);
      ctx.clearRect(0, 0, W, H);
      ctx.fillStyle = '#1954a6';
      for (let i = 0; i < N; i++) {
        const a = Math.atan2(vy[i], vx[i]), c = Math.cos(a), s = Math.sin(a);
        ctx.beginPath();
        ctx.moveTo(x[i] + 9 * c, y[i] + 9 * s);
        ctx.lineTo(x[i] - 5 * c - 4 * s, y[i] - 5 * s + 4 * c);
        ctx.lineTo(x[i] - 5 * c + 4 * s, y[i] - 5 * s - 4 * c);
        ctx.closePath();
        ctx.fill();
      }
    }

    section.querySelectorAll('[data-rule]').forEach(b => {
      releaseFocus(b);
      b.addEventListener('click', () => { rules[b.dataset.rule] = !rules[b.dataset.rule]; b.classList.toggle('on', rules[b.dataset.rule]); });
    });
    section.querySelectorAll('[data-action="scatter"]').forEach(b => { releaseFocus(b); b.addEventListener('click', () => { scatter(); draw(); }); });

    scatter(); draw();
    return animated(() => { update(); draw(); });
  }

  // ---------------------------------------------------------------- Repressilator (Elowitz & Leibler 2000)
  const SVG = 'http://www.w3.org/2000/svg';
  function el(parent, tag, attrs, text) {
    const e = document.createElementNS(SVG, tag);
    for (const k in attrs) e.setAttribute(k, attrs[k]);
    if (text !== undefined) e.textContent = text;
    parent.appendChild(e);
    return e;
  }

  // Dimensionless model: m' = -m + alpha / (1 + p_rep^n) + alpha0, p' = -beta (p - m)
  function simulate(nGenes, T) {
    const alpha = 216, alpha0 = 0.216, beta = 5, n = 2, dt = 0.01;
    const f = y => {
      const out = new Array(2 * nGenes);
      for (let i = 0; i < nGenes; i++) {
        const rep = y[nGenes + (i + nGenes - 1) % nGenes];
        out[i] = -y[i] + alpha / (1 + rep ** n) + alpha0;
        out[nGenes + i] = -beta * (y[nGenes + i] - y[i]);
      }
      return out;
    };
    let y = nGenes === 1 ? [0, 3] : [0, 0, 0, 1, 0, 3];
    const series = Array.from({ length: nGenes }, () => []);
    for (let s = 0, steps = Math.round(T / dt); s <= steps; s++) {
      if (s % 10 === 0) for (let i = 0; i < nGenes; i++) series[i].push([s * dt, y[nGenes + i]]);
      const k1 = f(y), k2 = f(y.map((v, i) => v + dt / 2 * k1[i])), k3 = f(y.map((v, i) => v + dt / 2 * k2[i])), k4 = f(y.map((v, i) => v + dt * k3[i]));
      y = y.map((v, i) => v + dt / 6 * (k1[i] + 2 * k2[i] + 2 * k3[i] + k4[i]));
    }
    return series;
  }

  function chart(svg, series, colors) {
    const W = 760, H = 230, L = 40, B = 34, T = 60, YMAX = 65;
    svg.setAttribute('viewBox', `0 0 ${W} ${H}`);
    const sx = t => L + (W - L - 10) * t / T, sy = p => H - B - (H - B - 10) * Math.min(p, YMAX) / YMAX;
    el(svg, 'line', { x1: L, y1: H - B, x2: W - 10, y2: H - B, class: 'axis' });
    el(svg, 'line', { x1: L, y1: 10, x2: L, y2: H - B, class: 'axis' });
    el(svg, 'text', { x: W - 10, y: H - 8, 'text-anchor': 'end', class: 'axis-label' }, 'time');
    el(svg, 'text', { x: L - 12, y: (H - B) / 2, 'text-anchor': 'middle', class: 'axis-label', transform: `rotate(-90 ${L - 12} ${(H - B) / 2})` }, 'protein');
    series.forEach((s, i) => el(svg, 'polyline', { points: s.map(([t, p]) => `${sx(t).toFixed(1)},${sy(p).toFixed(1)}`).join(' '), stroke: colors[i], class: 'trace' }));
  }

  function repressilator(section) {
    chart(section.querySelector('#rep-one'), simulate(1, 60), ['#52514e']);
    chart(section.querySelector('#rep-ring'), simulate(3, 60), ['#2a78d6', '#eb6834', '#1baf7a']);
  }

  // ---------------------------------------------------------------- Wiring
  const lifeSection = document.getElementById('life');
  if (lifeSection) demos.life = gameOfLife(lifeSection);
  const flockSection = document.getElementById('flocking');
  if (flockSection) demos.flocking = flocking(flockSection);
  const repSection = document.getElementById('repressilator');
  if (repSection) repressilator(repSection);

  function sync() {
    const current = Reveal.getCurrentSlide();
    for (const id in demos) (current && current.id === id) ? demos[id].start() : demos[id].stop();
  }
  Reveal.on('slidechanged', sync);
  if (Reveal.isReady()) sync(); else Reveal.on('ready', sync);
})();
