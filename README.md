# VernonCorp Python Development Standard

Skill Claude Code untuk standarisasi development Python di VernonCorp.

---

## GitHub Repository

**Repo:** https://github.com/erickmo/Claude-Skill-Python

```bash
git clone https://github.com/erickmo/Claude-Skill-Python.git
```

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

### Versi & Development
| Perintah | Deskripsi |
|----------|-----------|
| `inisiasi project` | Setup struktur requirements dan project standar VernonCorp Python |
| `buatkan versi baru [patch\|minor\|major]` | Buat direktori versi berikutnya |
| `update system ke versi vX.Y.Z` | Implementasi requirements versi tersebut ke codebase |
| `dry-run versi vX.Y.Z` | Preview perubahan tanpa mengeksekusi |
| `rollback ke versi vX.Y.Z` | Rollback implementasi ke versi sebelumnya |
| `status versi` | Tampilkan versi saat ini dan versi yang tersedia |

### Audit & Kualitas
| Perintah | Deskripsi |
|----------|-----------|
| `audit kode` | Scan kualitas kode: ruff, mypy, bandit, coverage, dead code |
| `audit requirement vX.Y.Z` | Cek konsistensi antara .md, .yaml, dan kode — report gap/mismatch |
| `jalankan test [vX.Y.Z]` | Jalankan pytest dengan coverage report untuk versi tertentu atau semua |
| `profil kode [target]` | Profiling performa: cProfile/py-spy, memory profiling, async bottleneck detection |
| `refaktor modul [nama]` | Analisa dan refaktor modul: pecah class besar, extract service, perbaiki coupling |

### Database
| Perintah | Deskripsi |
|----------|-----------|
| `migrasi database [upgrade\|downgrade\|status]` | Kelola Alembic migration: generate, apply, revert, atau tampilkan status |
| `seed database [dev\|test]` | Generate dan jalankan seed data untuk environment tertentu |

### Dokumentasi & Release
| Perintah | Deskripsi |
|----------|-----------|
| `generate dokumentasi` | Auto-generate API docs dari docstrings dan type hints |
| `buat release vX.Y.Z` | Tag release, generate release notes dari CHANGELOG, validasi semua gate |

### AI & LLM
| Perintah | Deskripsi |
|----------|-----------|
| `setup ai [anthropic\|openai\|gemini\|langchain\|all]` | Setup AI provider: install SDK, konfigurasi credentials, buat base client dengan retry/fallback |
| `generate ai service [nama]` | Generate AI service layer: prompt template, client wrapper, response parser, error handling |
| `generate rag pipeline [nama]` | Generate full RAG pipeline: document loader, chunker, embedder, vector store, retriever, generator |
| `setup vector db [chroma\|qdrant\|pgvector]` | Setup dan konfigurasi vector database dengan schema dan koneksi standar |
| `audit prompt [path]` | Audit prompt templates: injection risk, PII exposure, token efficiency, hallucination triggers |
| `evaluate llm [target]` | Evaluasi output LLM: akurasi, konsistensi, latency, cost per request, fallback coverage |

### Google API
| Perintah | Deskripsi |
|----------|-----------|
| `setup google api [gmail\|drive\|calendar\|sheets\|maps\|firebase\|vertex]` | Setup Google API client: credentials, OAuth/Service Account, quota handling, wrapper service |
| `generate google service [api]` | Generate service layer untuk Google API tertentu dengan clean interface dan error handling |

### Konfigurasi & Infrastructure
| Perintah | Deskripsi |
|----------|-----------|
| `setup environment [dev\|staging\|prod]` | Konfigurasi .env, config files, dan environment-specific settings |
| `setup ci/cd [github\|gitlab]` | Generate pipeline config: lint, type check, security scan, test, build |
| `setup pre-commit` | Install dan konfigurasi pre-commit hooks: ruff, mypy, bandit, secrets scan |
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
  ├── background-jobs/  ← background tasks (jika ada queue)
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
| **Testing** | pytest, Hypothesis (property-based), mutmut (mutation testing) |
| **Logging** | structlog (structured, correlation ID, business event markers) |
| **Container** | Docker multi-stage, docker-compose |
| **CI/CD** | GitHub Actions, GitLab CI |
| **AI/LLM** | Anthropic SDK, OpenAI SDK, Google Gemini, LangChain, LlamaIndex |
| **Vector DB** | Chroma, Qdrant, pgvector |
| **Google APIs** | Gmail, Drive, Calendar, Sheets, Maps, Firebase, Vertex AI |

---

## Persona AI

AI yang menggunakan skill ini berperan sebagai **Expert Software Engineer**, **Senior Python Developer**, dan **System Analyst** dengan pengalaman **20+ tahun**, menguasai:

- Clean Architecture & Domain-Driven Design (aggregate, entity, value object, repository)
- Async/await, GIL, CPython internals
- SOLID, DRY, KISS, YAGNI design principles
- Type safety (mypy strict), exception hierarchy design
- Security-aware development (OWASP Top 10, bandit, detect-secrets)
- Performance profiling (cProfile, py-spy, memory optimization)
- Testing mastery (pytest, mutation testing, property-based testing)
- Structured observability (structlog, correlation ID)
- Layer boundary enforcement (import-linter)
- **AI/LLM engineering** — Anthropic SDK, OpenAI SDK, Google Gemini/Vertex AI, LangChain, RAG pipeline, prompt engineering, LLM evaluation, cost tracking
- **Google Cloud & Google APIs** — Service Account, OAuth 2.0, Gmail, Drive, Calendar, Sheets, Maps, Firebase, Vertex AI, quota management

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
8. **Regenerate YAML dari .md** (selalu sinkron — tidak boleh skip)

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
