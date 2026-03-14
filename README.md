# VernonCorp Python Development Standard

Skill Claude Code untuk standarisasi development Python di VernonCorp.

---

## Cara Penggunaan

Tambahkan skill ini ke project Python kamu:

```bash
# Salin folder .claude ke root project
cp -r ".claude" "/path/to/your-python-project/"
```

Kemudian mulai dengan perintah:

```
inisiasi project
```

---

## Perintah yang Tersedia

| Perintah | Deskripsi |
|----------|-----------|
| `inisiasi project` | Setup struktur requirements dan project standar VernonCorp Python |
| `buatkan versi baru [patch\|minor\|major]` | Buat direktori versi berikutnya |
| `update system ke versi vX.Y.Z` | Implementasi requirements versi tersebut ke codebase |
| `dry-run versi vX.Y.Z` | Preview perubahan tanpa mengeksekusi |
| `rollback ke versi vX.Y.Z` | Rollback implementasi ke versi sebelumnya |
| `status versi` | Tampilkan versi saat ini dan versi yang tersedia |
| `audit kode` | Scan kualitas kode: ruff, mypy, bandit, coverage, dead code |
| `audit requirement vX.Y.Z` | Cek konsistensi antara .md, .yaml, dan kode — report gap/mismatch |
| `jalankan test [vX.Y.Z]` | Jalankan pytest dengan coverage report |
| `generate dokumentasi` | Auto-generate API docs dari docstrings dan type hints |
| `setup environment [dev\|staging\|prod]` | Konfigurasi .env, config files, dan environment settings |
| `setup ci/cd [github\|gitlab]` | Generate pipeline config: lint, type check, security scan, test, build |
| `setup pre-commit` | Install dan konfigurasi pre-commit hooks: ruff, mypy, bandit, secrets scan |
| `migrasi database [upgrade\|downgrade\|status]` | Kelola Alembic migration |
| `seed database [dev\|test]` | Generate dan jalankan seed data untuk environment tertentu |
| `refaktor modul [nama]` | Analisa dan refaktor modul: pecah class besar, extract service, perbaiki coupling |
| `profil kode [target]` | Profiling performa: cProfile/py-spy, memory profiling, async bottleneck detection |
| `buat release vX.Y.Z` | Tag release, generate release notes dari CHANGELOG, validasi semua gate |
| `setup docker` | Generate Dockerfile multi-stage, docker-compose dev/prod, dan .dockerignore |

---

## Alur Kerja

```
inisiasi project
      │
      ▼
buatkan versi baru minor        ← v1.0.0 sudah dibuat saat inisiasi
      │
      ▼
Tulis requirements di docs/requirements/vX.Y.Z/
  ├── modules/          ← deskripsi modul, class, fungsi
  ├── business-rules/   ← aturan bisnis dan logic
  ├── security/         ← kebijakan keamanan dan akses
  ├── validations/      ← aturan validasi input/data
  ├── api/              ← deskripsi endpoint (jika ada)
  ├── events/           ← domain events dan handlers
  ├── background-jobs/  ← background tasks (jika ada)
  └── migrations/       ← perubahan schema database
      │
      ▼
dry-run versi vX.Y.Z            ← preview perubahan
      │
      ▼
update system ke versi vX.Y.Z   ← implementasi ke kode
      │
      ▼
jalankan test vX.Y.Z            ← validasi semua test pass
      │
      ▼
audit kode                      ← ruff, mypy, bandit, coverage
      │
      ▼
buat release vX.Y.Z             ← tag + release notes
```

---

## Versioning

Format: `vMAJOR.MINOR.PATCH`

| Tipe | Kapan |
|------|-------|
| `PATCH` | Bugfix, penyesuaian kecil, tidak ada API baru |
| `MINOR` | Fitur baru, modul baru, endpoint baru (non-breaking) |
| `MAJOR` | Breaking changes — hapus/rename public API, ubah schema |

> AI **tidak bisa** dikecualikan dari aturan bump type — jika ada breaking change, wajib MAJOR.

---

## Struktur Project yang Dihasilkan

```
project/
├── src/{project_name}/
│   ├── domain/          ← entities, value objects, domain events
│   ├── application/     ← use cases, services, command/query handlers
│   ├── infrastructure/  ← db, cache, external APIs, message queues
│   ├── api/             ← routers, schemas (jika ada framework)
│   ├── workers/         ← background jobs (jika ada queue)
│   ├── exceptions.py    ← base exception hierarchy
│   ├── config.py        ← centralized config via env vars
│   └── logging_config.py← structlog setup
├── tests/
│   ├── conftest.py
│   ├── integration/
│   └── v{X}_{Y}_{Z}/
├── docs/
│   ├── requirements/
│   │   ├── .project_name
│   │   ├── .package_manager
│   │   ├── .current_version
│   │   ├── .version_history
│   │   ├── CHANGELOG.md
│   │   └── vX.Y.Z/
│   └── audit/
├── pyproject.toml
├── .pre-commit-config.yaml
└── .env.example
```

---

## Tech Stack yang Didukung

| Kategori | Pilihan |
|----------|---------|
| **Framework** | FastAPI, Django, Flask, atau tanpa framework |
| **Package Manager** | `pip`, `poetry`, `uv` |
| **Database** | PostgreSQL, MySQL, SQLite, atau tanpa database |
| **ORM** | SQLAlchemy + Alembic |
| **Background Jobs** | Celery, arq, rq |
| **Linting** | ruff (formatter + linter) |
| **Type Check** | mypy strict mode |
| **Security Scan** | bandit, detect-secrets |
| **Testing** | pytest, Hypothesis (property-based) |
| **Logging** | structlog |
| **Container** | Docker multi-stage, docker-compose |
| **CI/CD** | GitHub Actions, GitLab CI |

---

## Persona AI

AI yang menggunakan skill ini berperan sebagai **Expert Software Engineer**, **Senior Python Developer**, dan **System Analyst** dengan pengalaman **20+ tahun**, menguasai:

- Clean Architecture & Domain-Driven Design
- Async/await, GIL, CPython internals
- SOLID, DRY, KISS, YAGNI design principles
- Security-aware development (OWASP Top 10)
- Performance profiling & optimization
- Testing mastery (pytest, mutation testing)
- Structured observability (structlog, correlation ID)

---

## Pre-Flight Checks Otomatis

Sebelum setiap perintah, AI akan otomatis:

1. Cek skill repo up-to-date
2. Cek project requirements up-to-date
3. Cek uncommitted changes
4. Cek aktif branch (peringatan jika di `main`/`master`)
5. Baca `.project_name` dan `.package_manager`
6. Cek layer boundaries dengan `import-linter`
7. Scan secrets dengan `detect-secrets`/`trufflehog`
8. **Regenerate YAML dari .md** (selalu sinkron)

---

## File Structure Skill

```
.claude/
└── skills/
    └── vernon-python/
        └── SKILL.md     ← definisi lengkap skill ini
```

---

*VernonCorp Python Development Standard — dibuat untuk konsistensi, kualitas, dan keamanan kode Python di seluruh project VernonCorp.*
