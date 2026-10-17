import './style.css';

const isEn = document.documentElement.lang === 'en';

// ─── Sponsor Tier Translations for EN ───

const tierEnMap = {
  'Gyémánt': 'Diamond',
  'Arany': 'Gold',
  'Ezüst': 'Silver',
  'Bronz': 'Bronze',
  'Partner': 'Partner',
};

// ─── Mobile Menu Toggle ───
const hamburgerBtn = document.getElementById('hamburger-btn');
const closeBtn = document.getElementById('mobile-close-btn');
const mobileMenu = document.getElementById('mobile-menu');
const mobileLinks = mobileMenu?.querySelectorAll('a');

function openMenu() {
  mobileMenu?.classList.add('active');
  document.body.style.overflow = 'hidden';
}

function closeMenu() {
  mobileMenu?.classList.remove('active');
  document.body.style.overflow = '';
}

hamburgerBtn?.addEventListener('click', openMenu);
closeBtn?.addEventListener('click', closeMenu);
mobileLinks?.forEach((link) => link.addEventListener('click', closeMenu));

// ─── Navbar & Back-to-Top Scroll Effect ───
const navbar = document.getElementById('navbar');
const backToTopBtn = document.getElementById('back-to-top');

function handleScroll() {
  const currentScroll = window.scrollY;

  // Navbar background
  if (currentScroll > 80) {
    navbar?.classList.add('bg-erm-dark/95', 'backdrop-blur-xl', 'shadow-lg', 'shadow-black/20');
    navbar?.classList.remove('bg-transparent');
  } else {
    navbar?.classList.remove('bg-erm-dark/95', 'backdrop-blur-xl', 'shadow-lg', 'shadow-black/20');
    navbar?.classList.add('bg-transparent');
  }

  // Back to top button visibility
  if (currentScroll > 400) {
    backToTopBtn?.classList.add('visible');
  } else {
    backToTopBtn?.classList.remove('visible');
  }
}

window.addEventListener('scroll', handleScroll, { passive: true });
handleScroll();

backToTopBtn?.addEventListener('click', () => {
  window.scrollTo({
    top: 0,
    behavior: 'smooth',
  });
});

// ─── Intersection Observer for Reveal Animations ───
const revealObserver = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        revealObserver.unobserve(entry.target);
      }
    });
  },
  { threshold: 0.1, rootMargin: '0px 0px -40px 0px' }
);

document.querySelectorAll('.reveal, .reveal-stagger').forEach((el) => {
  revealObserver.observe(el);
});

// ─── Animated Counter (Telemetry Numbers) ───
function animateCounter(el) {
  const target = parseFloat(el.dataset.target);
  const suffix = el.dataset.suffix || '';
  const duration = 2000;
  const startTime = performance.now();
  const isFloat = String(target).includes('.');

  function update(currentTime) {
    const elapsed = currentTime - startTime;
    const progress = Math.min(elapsed / duration, 1);
    const eased = 1 - Math.pow(1 - progress, 3);
    const current = eased * target;

    el.textContent = (isFloat ? current.toFixed(1) : Math.floor(current)) + suffix;

    if (progress < 1) {
      requestAnimationFrame(update);
    }
  }

  requestAnimationFrame(update);
}

const counterObserver = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        animateCounter(entry.target);
        counterObserver.unobserve(entry.target);
      }
    });
  },
  { threshold: 0.5 }
);

document.querySelectorAll('[data-target]').forEach((el) => {
  counterObserver.observe(el);
});

// ─── Parallax Floating Elements ───
function handleParallax() {
  const scrollY = window.scrollY;
  const parallaxEls = document.querySelectorAll('[data-parallax]');

  parallaxEls.forEach((el) => {
    const speed = parseFloat(el.dataset.parallax) || 0.3;
    el.style.transform = `translateY(${scrollY * speed}px)`;
  });
}

window.addEventListener('scroll', handleParallax, { passive: true });

// ─── Particle Canvas (Hero Section) ───
const canvas = document.getElementById('particle-canvas');
if (canvas) {
  const ctx = canvas.getContext('2d');
  let particles = [];
  let animationId;

  function resizeCanvas() {
    const hero = canvas.parentElement;
    canvas.width = hero.offsetWidth;
    canvas.height = hero.offsetHeight;
  }

  function createParticles() {
    particles = [];
    const count = Math.floor((canvas.width * canvas.height) / 18000);
    for (let i = 0; i < count; i++) {
      particles.push({
        x: Math.random() * canvas.width,
        y: Math.random() * canvas.height,
        radius: Math.random() * 1.5 + 0.3,
        vx: (Math.random() - 0.5) * 0.4,
        vy: (Math.random() - 0.5) * 0.3 - 0.1,
        alpha: Math.random() * 0.5 + 0.1,
      });
    }
  }

  function drawParticles() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    particles.forEach((p) => {
      ctx.beginPath();
      ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2);
      ctx.fillStyle = `rgba(41, 170, 225, ${p.alpha})`;
      ctx.fill();

      p.x += p.vx;
      p.y += p.vy;

      if (p.x < 0) p.x = canvas.width;
      if (p.x > canvas.width) p.x = 0;
      if (p.y < 0) p.y = canvas.height;
      if (p.y > canvas.height) p.y = 0;
    });

    for (let i = 0; i < particles.length; i++) {
      for (let j = i + 1; j < particles.length; j++) {
        const dx = particles[i].x - particles[j].x;
        const dy = particles[i].y - particles[j].y;
        const dist = Math.sqrt(dx * dx + dy * dy);
        if (dist < 120) {
          ctx.beginPath();
          ctx.moveTo(particles[i].x, particles[i].y);
          ctx.lineTo(particles[j].x, particles[j].y);
          ctx.strokeStyle = `rgba(41, 170, 225, ${0.06 * (1 - dist / 120)})`;
          ctx.lineWidth = 0.5;
          ctx.stroke();
        }
      }
    }

    animationId = requestAnimationFrame(drawParticles);
  }

  resizeCanvas();
  createParticles();
  drawParticles();

  window.addEventListener('resize', () => {
    resizeCanvas();
    createParticles();
  });

  const heroObserver = new IntersectionObserver(
    ([entry]) => {
      if (entry.isIntersecting) {
        if (!animationId) drawParticles();
      } else {
        cancelAnimationFrame(animationId);
        animationId = null;
      }
    },
    { threshold: 0 }
  );
  heroObserver.observe(canvas.parentElement);
}

// ─── Smooth Scroll for anchor links ───
document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
  anchor.addEventListener('click', (e) => {
    const href = anchor.getAttribute('href');
    if (!href || href === '#') return;
    const target = document.querySelector(href);
    if (target) {
      e.preventDefault();
      closeMenu();
      target.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
  });
});

// ─── Accordion (For both Az FS-ről and GYIK / FAQ) ───
document.querySelectorAll('.accordion-item').forEach((item) => {
  const header = item.querySelector('.accordion-header');
  header?.addEventListener('click', () => {
    const isActive = item.classList.contains('active');

    item.parentElement?.querySelectorAll('.accordion-item').forEach((sibling) => {
      sibling.classList.remove('active');
    });

    if (!isActive) {
      item.classList.add('active');
    }
  });
});

// ─── Interactive Carousel for FS Info ───
function initFsCarousel() {
  const carousel = document.getElementById('fs-carousel');
  const track = document.getElementById('fs-carousel-track');
  const prevBtn = document.getElementById('fs-carousel-prev');
  const nextBtn = document.getElementById('fs-carousel-next');
  const dotsContainer = document.getElementById('fs-carousel-dots');
  const counterEl = document.getElementById('fs-carousel-counter');

  if (!carousel || !track) return;

  const slides = track.querySelectorAll('.carousel-slide');
  const totalSlides = slides.length;
  if (totalSlides === 0) return;

  let currentIndex = 0;
  let autoplayTimer = null;

  if (dotsContainer) {
    dotsContainer.innerHTML = Array.from({ length: totalSlides })
      .map(
        (_, i) => `
        <button class="carousel-dot cursor-pointer transition-all duration-300 ${
          i === 0
            ? 'w-8 h-2 bg-erm-blue shadow-[0_0_10px_rgba(41,170,225,0.7)]'
            : 'w-2 h-2 bg-white/20 hover:bg-white/40'
        } -skew-x-12" data-index="${i}" aria-label="Slide ${i + 1}"></button>
      `
      )
      .join('');

    dotsContainer.querySelectorAll('.carousel-dot').forEach((dot) => {
      dot.addEventListener('click', () => {
        const index = parseInt(dot.dataset.index, 10);
        goToSlide(index);
        restartAutoplay();
      });
    });
  }

  function updateDots() {
    if (!dotsContainer) return;
    const dots = dotsContainer.querySelectorAll('.carousel-dot');
    dots.forEach((dot, idx) => {
      if (idx === currentIndex) {
        dot.className =
          'carousel-dot cursor-pointer transition-all duration-300 w-8 h-2 bg-erm-blue shadow-[0_0_10px_rgba(41,170,225,0.7)] -skew-x-12';
      } else {
        dot.className =
          'carousel-dot cursor-pointer transition-all duration-300 w-2 h-2 bg-white/20 hover:bg-white/40 -skew-x-12';
      }
    });
  }

  function goToSlide(index) {
    currentIndex = (index + totalSlides) % totalSlides;
    track.style.transform = `translateX(-${currentIndex * 100}%)`;

    if (counterEl) {
      counterEl.textContent = `0${currentIndex + 1} / 0${totalSlides}`;
    }

    updateDots();
  }

  function nextSlide() {
    goToSlide(currentIndex + 1);
  }

  function prevSlide() {
    goToSlide(currentIndex - 1);
  }

  prevBtn?.addEventListener('click', () => {
    prevSlide();
    restartAutoplay();
  });

  nextBtn?.addEventListener('click', () => {
    nextSlide();
    restartAutoplay();
  });

  function startAutoplay() {
    stopAutoplay();
    autoplayTimer = setInterval(nextSlide, 4500);
  }

  function stopAutoplay() {
    if (autoplayTimer) {
      clearInterval(autoplayTimer);
      autoplayTimer = null;
    }
  }

  function restartAutoplay() {
    stopAutoplay();
    startAutoplay();
  }

  carousel.addEventListener('mouseenter', stopAutoplay);
  carousel.addEventListener('mouseleave', startAutoplay);

  let startX = 0;
  let endX = 0;

  carousel.addEventListener(
    'touchstart',
    (e) => {
      startX = e.touches[0].clientX;
      stopAutoplay();
    },
    { passive: true }
  );

  carousel.addEventListener(
    'touchend',
    (e) => {
      endX = e.changedTouches[0].clientX;
      const diff = startX - endX;
      if (Math.abs(diff) > 40) {
        if (diff > 0) {
          nextSlide();
        } else {
          prevSlide();
        }
      }
      startAutoplay();
    },
    { passive: true }
  );

  goToSlide(0);
  startAutoplay();
}

// ─── CSV Parser Helper ───
function parseCSVLine(line) {
  const result = [];
  let current = '';
  let inQuotes = false;
  for (let i = 0; i < line.length; i++) {
    const char = line[i];
    if (char === '"') {
      inQuotes = !inQuotes;
    } else if (char === ',' && !inQuotes) {
      result.push(current.trim());
      current = '';
    } else {
      current += char;
    }
  }
  result.push(current.trim());
  return result;
}

// ─── Team Section: Load from CSV ───
const DEPARTMENT_GROUPS = [
  { hu: 'Mind', en: 'All', id: 'all' },
  { hu: 'Management', en: 'Management', id: 'Management' },
  { hu: 'Elektronikai egység', en: 'Electronics Unit', id: 'Elektronikai egység' },
  { hu: 'Gépész egység', en: 'Mechanical Unit', id: 'Gépész egység' },
  { hu: 'IT egység', en: 'IT Unit', id: 'IT egység' },
  { hu: 'HR és Jogi egység', en: 'HR & Legal Unit', id: 'HR és Jogi egység' },
  { hu: 'Marketing egység', en: 'Marketing Unit', id: 'Marketing egység' },
  { hu: 'Pénzügyi egység', en: 'Finance Unit', id: 'Pénzügyi egység' },
  { hu: 'Alumni tagjaink', en: 'Alumni Members', id: 'Alumni tagjaink' },
];

async function loadTeam() {
  const container = document.getElementById('team-grid');
  const filterContainer = document.getElementById('team-filters');
  if (!container) return;

  try {
    const response = await fetch('/data/team.csv');
    const text = await response.text();
    const rawLines = text.split(/\r?\n/).map((l) => l.trim()).filter(Boolean);
    if (rawLines.length === 0) return;

    const headers = parseCSVLine(rawLines[0]).map((h) => h.toLowerCase());
    const nameIdx = headers.indexOf('name');
    const roleHuIdx = headers.indexOf('role_hu') !== -1 ? headers.indexOf('role_hu') : headers.indexOf('role');
    const roleEnIdx = headers.indexOf('role_en');
    const deptHuIdx = headers.indexOf('department_hu') !== -1 ? headers.indexOf('department_hu') : headers.indexOf('department');
    const deptEnIdx = headers.indexOf('department_en');
    const imageIdx = headers.indexOf('image');

    const members = rawLines.slice(1).map((line) => {
      const values = parseCSVLine(line);
      const name = values[nameIdx !== -1 ? nameIdx : 0] || '';
      const roleHu = values[roleHuIdx !== -1 ? roleHuIdx : 1] || '';
      const roleEn = (roleEnIdx !== -1 && values[roleEnIdx]) ? values[roleEnIdx] : roleHu;
      const deptHu = values[deptHuIdx !== -1 ? deptHuIdx : 2] || '';
      const deptEn = (deptEnIdx !== -1 && values[deptEnIdx]) ? values[deptEnIdx] : deptHu;
      const image = values[imageIdx !== -1 ? imageIdx : 5] || values[3] || '';

      return {
        name,
        role_hu: roleHu,
        role_en: roleEn,
        department_hu: deptHu,
        department_en: deptEn,
        image,
      };
    });

    if (filterContainer) {
      // Find if any extra departments exist in CSV not in DEPARTMENT_GROUPS
      const definedHuDepts = new Set(DEPARTMENT_GROUPS.map((g) => g.hu.toLowerCase()));
      const extraDepts = [];
      members.forEach((m) => {
        if (m.department_hu && !definedHuDepts.has(m.department_hu.toLowerCase())) {
          definedHuDepts.add(m.department_hu.toLowerCase());
          extraDepts.push({
            hu: m.department_hu,
            en: m.department_en || m.department_hu,
            id: m.department_hu,
          });
        }
      });

      const allTabs = [...DEPARTMENT_GROUPS, ...extraDepts];

      filterContainer.innerHTML = allTabs
        .map((group, i) => {
          const displayLabel = isEn ? group.en : group.hu;
          return `
            <button class="dept-tab ${i === 0 ? 'active' : ''}" data-group-hu="${group.hu}" data-group-en="${group.en}" data-group-id="${group.id}">
              <span class="skew-x-6 block">${displayLabel}</span>
            </button>
          `;
        })
        .join('');

      filterContainer.querySelectorAll('.dept-tab').forEach((tab) => {
        tab.addEventListener('click', () => {
          filterContainer.querySelectorAll('.dept-tab').forEach((t) => t.classList.remove('active'));
          tab.classList.add('active');

          const groupId = tab.dataset.groupId;
          const groupHu = tab.dataset.groupHu.toLowerCase();
          const groupEn = tab.dataset.groupEn.toLowerCase();

          container.querySelectorAll('.team-card').forEach((card) => {
            const cardDeptHu = (card.dataset.deptHu || '').toLowerCase();
            const cardDeptEn = (card.dataset.deptEn || '').toLowerCase();

            if (groupId === 'all' || cardDeptHu === groupHu || cardDeptEn === groupEn) {
              card.style.display = '';
            } else {
              card.style.display = 'none';
            }
          });
        });
      });
    }

    container.innerHTML = members
      .map((member) => {
        const imgSrc = member.image
          ? `/img/team/${member.image}`
          : '/img/team/Blank.webp';
        const displayRole = isEn ? (member.role_en || member.role_hu) : member.role_hu;
        const displayDept = isEn ? (member.department_en || member.department_hu) : member.department_hu;

        return `
          <div class="team-card cursor-pointer" data-dept-hu="${member.department_hu}" data-dept-en="${member.department_en}">
            <img src="${imgSrc}" alt="${member.name}" loading="lazy" />
            <div class="p-4 bg-gradient-to-t from-erm-dark via-erm-gray/80 to-transparent">
              <h4 class="font-display font-bold text-base uppercase tracking-wide text-white mb-0.5 truncate">${member.name}</h4>
              <p class="font-display text-xs uppercase tracking-widest text-erm-blue mb-0.5 truncate">${displayRole}</p>
              <p class="text-[0.7rem] text-erm-text uppercase tracking-wider truncate">${displayDept}</p>
            </div>
          </div>
        `;
      })
      .join('');
  } catch (err) {
    console.error('Failed to load team data:', err);
    container.innerHTML =
      `<p class="text-erm-text col-span-full text-center py-12">${isEn ? 'Failed to load team data.' : 'A csapat adatok betöltése sikertelen.'}</p>`;
  }
}

// ─── Sponsors Section: Load from JSON ───
async function loadSponsors() {
  const container = document.getElementById('sponsors-container');
  if (!container) return;

  try {
    const response = await fetch('/data/sponsors.json');
    const data = await response.json();

    const tierConfig = {
      diamond: { logoSize: 'max-h-20 md:max-h-24', cardPad: 'p-6 md:p-8', cols: 'grid-cols-2 md:grid-cols-3 lg:grid-cols-5' },
      gold:    { logoSize: 'max-h-16 md:max-h-20', cardPad: 'p-5 md:p-6', cols: 'grid-cols-2 md:grid-cols-3 lg:grid-cols-5' },
      silver:  { logoSize: 'max-h-12 md:max-h-16', cardPad: 'p-4 md:p-5', cols: 'grid-cols-3 md:grid-cols-4 lg:grid-cols-6' },
      bronze:  { logoSize: 'max-h-10 md:max-h-14', cardPad: 'p-3 md:p-4', cols: 'grid-cols-3 md:grid-cols-4 lg:grid-cols-6' },
      partner: { logoSize: 'max-h-8 md:max-h-12',  cardPad: 'p-3',        cols: 'grid-cols-4 md:grid-cols-6 lg:grid-cols-8' },
    };

    const tierColors = {
      diamond: 'from-blue-300 to-blue-100',
      gold:    'from-yellow-400 to-yellow-200',
      silver:  'from-gray-300 to-gray-100',
      bronze:  'from-amber-600 to-amber-400',
      partner: 'from-erm-blue to-erm-blue-light',
    };

    container.innerHTML = data.tiers
      .map((tier) => {
        const config = tierConfig[tier.id] || tierConfig.partner;
        const tierName = isEn ? (tierEnMap[tier.name] || tier.name) : tier.name;

        return `
          <div class="mb-16 md:mb-20 reveal">
            <h4 class="sponsor-tier-title text-lg md:text-xl text-white mb-2">${tierName}</h4>
            <div class="w-20 h-[2px] bg-gradient-to-r ${tierColors[tier.id] || ''} mx-auto mb-8 opacity-60"></div>
            <div class="grid ${config.cols} gap-4">
              ${tier.sponsors
                .map(
                  (s) => `
                  <a href="${s.url}" target="_blank" rel="noopener noreferrer"
                     class="sponsor-logo-card tier-${tier.id} ${config.cardPad}"
                     title="${s.name}">
                    <img src="${s.logo}" alt="${s.name}" class="${config.logoSize} w-auto object-contain" loading="lazy" />
                  </a>`
                )
                .join('')}
            </div>
          </div>
        `;
      })
      .join('');

    container.querySelectorAll('.reveal').forEach((el) => {
      revealObserver.observe(el);
    });
  } catch (err) {
    console.error('Failed to load sponsors data:', err);
    container.innerHTML =
      `<p class="text-erm-text text-center py-12">${isEn ? 'Failed to load sponsors data.' : 'A szponzor adatok betöltése sikertelen.'}</p>`;
  }
}

// ─── 3D Model Viewer (Three.js + Draco) ───
let modelViewerStarted = false;

function init3DModelViewer() {
  const container = document.getElementById('model-canvas-container');
  if (!container || modelViewerStarted) return;
  modelViewerStarted = true;

  // Initialize viewer immediately so model is pre-buffered and ready
  loadAndMount3DModel(container);
}

async function loadAndMount3DModel(container) {
  const loadingOverlay = document.getElementById('model-loading-overlay');
  const progressBar = document.getElementById('model-progress-bar');
  const autorotateBtn = document.getElementById('model-autorotate-btn');
  const resetBtn = document.getElementById('model-reset-btn');

  let THREE, GLTFLoader, DRACOLoader, OrbitControls;
  try {
    const modules = await Promise.all([
      import('three'),
      import('three/examples/jsm/loaders/GLTFLoader.js'),
      import('three/examples/jsm/loaders/DRACOLoader.js'),
      import('three/examples/jsm/controls/OrbitControls.js'),
    ]);
    THREE = modules[0];
    GLTFLoader = modules[1].GLTFLoader;
    DRACOLoader = modules[2].DRACOLoader;
    OrbitControls = modules[3].OrbitControls;
  } catch (err) {
    console.error('Failed to load Three.js libraries:', err);
    if (loadingOverlay) {
      loadingOverlay.innerHTML = `<p class="text-rose-400 font-display text-sm uppercase">${isEn ? '3D Engine could not be loaded' : 'A 3D motor betöltése sikertelen'}</p>`;
    }
    return;
  }

  const getWidth = () => container.clientWidth || container.parentElement?.clientWidth || window.innerWidth || 800;
  const getHeight = () => container.clientHeight || container.parentElement?.clientHeight || 560;

  let width = getWidth();
  let height = getHeight();

  // Scene
  const scene = new THREE.Scene();

  // Camera
  const camera = new THREE.PerspectiveCamera(40, width / height, 0.1, 100);

  // Renderer
  const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true, powerPreference: 'high-performance' });
  renderer.setSize(width, height);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
  renderer.outputColorSpace = THREE.SRGBColorSpace;
  renderer.toneMapping = THREE.ACESFilmicToneMapping;
  renderer.toneMappingExposure = 1.15;
  renderer.shadowMap.enabled = true;
  renderer.shadowMap.type = THREE.PCFSoftShadowMap;
  container.appendChild(renderer.domElement);

  // Controls
  const controls = new OrbitControls(camera, renderer.domElement);
  controls.enableDamping = true;
  controls.dampingFactor = 0.05;
  controls.autoRotate = true;
  controls.autoRotateSpeed = 1.3;
  controls.maxPolarAngle = Math.PI / 2 + 0.04;
  controls.minDistance = 1.2;
  controls.maxDistance = 8.0;

  // Lighting
  const ambientLight = new THREE.AmbientLight(0xffffff, 1.4);
  scene.add(ambientLight);

  const mainLight = new THREE.DirectionalLight(0xffffff, 2.4);
  mainLight.position.set(5, 8, 5);
  scene.add(mainLight);

  const blueRimLight = new THREE.DirectionalLight(0x29aae1, 3.2);
  blueRimLight.position.set(-5, 4, -5);
  scene.add(blueRimLight);

  const fillLight = new THREE.DirectionalLight(0x60c5f1, 1.3);
  fillLight.position.set(0, -3, 3);
  scene.add(fillLight);

  // Grid Turntable Floor
  const gridHelper = new THREE.GridHelper(6, 24, 0x29aae1, 0x1f2833);
  gridHelper.position.y = -0.01;
  scene.add(gridHelper);

  // Circular Neon Turquoise Ring under the car
  const ringGeo = new THREE.RingGeometry(1.6, 1.63, 64);
  const ringMat = new THREE.MeshBasicMaterial({ color: 0x29aae1, side: THREE.DoubleSide, transparent: true, opacity: 0.65 });
  const ringMesh = new THREE.Mesh(ringGeo, ringMat);
  ringMesh.rotation.x = -Math.PI / 2;
  ringMesh.position.y = 0.005;
  scene.add(ringMesh);

  let initialCameraPosition = new THREE.Vector3();
  let initialTarget = new THREE.Vector3(0, 0, 0);

  // Configure DRACOLoader for Draco compressed mesh decoding
  const dracoLoader = new DRACOLoader();
  dracoLoader.setDecoderPath('/draco/');

  // Load GLTF / GLB Model with Draco
  const loader = new GLTFLoader();
  loader.setDRACOLoader(dracoLoader);

  loader.load(
    '/model/ERMe01-optimized.glb',
    (gltf) => {
      const model = gltf.scene;

      // Compute bounding box
      const box = new THREE.Box3().setFromObject(model);
      const size = box.getSize(new THREE.Vector3());
      const center = box.getCenter(new THREE.Vector3());

      // Center model
      model.position.x -= center.x;
      model.position.y -= box.min.y; // Sit cleanly on the turntable floor
      model.position.z -= center.z;

      // Adjust camera distance based on car size
      const maxDim = Math.max(size.x, size.y, size.z);
      const fov = camera.fov * (Math.PI / 180);
      let cameraDistance = Math.abs(maxDim / Math.sin(fov / 2)) * 0.72;
      cameraDistance = Math.max(cameraDistance, 2.5);

      camera.position.set(cameraDistance * 0.85, cameraDistance * 0.45, cameraDistance * 0.95);
      initialCameraPosition.copy(camera.position);

      controls.target.set(0, size.y * 0.35, 0);
      initialTarget.copy(controls.target);
      controls.update();

      scene.add(model);

      // Hide loading overlay
      if (loadingOverlay) {
        loadingOverlay.style.opacity = '0';
        setTimeout(() => {
          loadingOverlay.style.display = 'none';
        }, 500);
      }

      onResize();
    },
    (xhr) => {
      if (xhr.lengthComputable && progressBar) {
        const percent = Math.round((xhr.loaded / xhr.total) * 100);
        progressBar.style.width = `${percent}%`;
      }
    },
    (err) => {
      console.error('Error loading ERMe-01 3D model:', err);
      if (loadingOverlay) {
        loadingOverlay.innerHTML = `<p class="text-rose-400 font-display text-sm uppercase">${isEn ? 'Failed to load 3D model' : 'A 3D modell betöltése sikertelen'}</p>`;
      }
    }
  );

  // Controls buttons
  let isAutoRotating = true;
  autorotateBtn?.addEventListener('click', () => {
    isAutoRotating = !isAutoRotating;
    controls.autoRotate = isAutoRotating;
    autorotateBtn.classList.toggle('border-erm-blue', isAutoRotating);
    autorotateBtn.classList.toggle('text-erm-blue', isAutoRotating);
  });

  resetBtn?.addEventListener('click', () => {
    camera.position.copy(initialCameraPosition);
    controls.target.copy(initialTarget);
    controls.update();
  });

  // Resize handling
  function onResize() {
    if (!container) return;
    const w = getWidth();
    const h = getHeight();
    if (w > 0 && h > 0) {
      camera.aspect = w / h;
      camera.updateProjectionMatrix();
      renderer.setSize(w, h);
    }
  }

  window.addEventListener('resize', onResize);
  const resizeObserver = new ResizeObserver(() => onResize());
  resizeObserver.observe(container);

  // Animation Loop with Visibility Observer to save battery/GPU
  let animationId = null;

  function animate() {
    animationId = requestAnimationFrame(animate);
    controls.update();
    renderer.render(scene, camera);
  }

  // Start animation immediately
  animate();

  const renderObserver = new IntersectionObserver(
    ([entry]) => {
      if (entry.isIntersecting) {
        if (!animationId) animate();
      } else {
        if (animationId) {
          cancelAnimationFrame(animationId);
          animationId = null;
        }
      }
    },
    { threshold: 0.02 }
  );

  if (container.parentElement) {
    renderObserver.observe(container.parentElement);
  }
}

// ─── Sleek Page Preloader Controller ───
const preloaderEl = document.getElementById('page-preloader');
const pageStartTime = performance.now();
const minPreloaderDisplayMs = 500; // Ensures a sleek, premium experience without flashing

function dismissPreloader() {
  if (!preloaderEl || preloaderEl.classList.contains('loaded')) return;
  const elapsed = performance.now() - pageStartTime;
  const remainingTime = Math.max(0, minPreloaderDisplayMs - elapsed);

  setTimeout(() => {
    preloaderEl.classList.add('loaded');
    setTimeout(() => {
      if (preloaderEl.parentNode) {
        preloaderEl.parentNode.removeChild(preloaderEl);
      }
    }, 600);
  }, remainingTime);
}

// ─── Init ───
document.addEventListener('DOMContentLoaded', () => {
  initFsCarousel();
  init3DModelViewer();
  loadTeam();
  loadSponsors();
});

// Dismiss preloader once the full window (images, styles, fonts) is loaded
if (document.readyState === 'complete') {
  dismissPreloader();
} else {
  window.addEventListener('load', dismissPreloader);
}

// Safe failsafe dismiss in case a 3rd party asset stalls
setTimeout(dismissPreloader, 3000);