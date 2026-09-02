# EduPath (Spring Boot + JSP)

Career guidance platform for students — aptitude testing, stream/course recommendations, and college search.

## Quick start (IntelliJ — recommended)

1. **Run → Edit Configurations**
2. Main class: `com.edupath.EdupathApplication`
3. **Active profiles:** `dev` (H2 in-memory — no MySQL needed)
4. Run ▶

Browser: http://localhost:8080

> Ready run config: `EdupathApplication` (profile: dev)

### Demo accounts

| Role | Email | Password |
|------|-------|----------|
| Student | `student@edupath.in` | `Student@123` |
| Admin | `admin@edupath.in` | `Admin@123` |

Select the matching role (Student / Admin) on the login page before signing in.

### Port 8080 already in use?

```powershell
netstat -ano | findstr ":8080"
taskkill /PID <PID_NUMBER> /F
```

## Maven CLI

If Maven is installed:

```bash
mvn spring-boot:run -Dspring-boot.run.profiles=dev
mvn test
```

## MySQL / XAMPP (optional)

1. Start MySQL from XAMPP
2. Set profile to `mysql` in run configuration
3. Edit `application-mysql.properties` (default password is empty for XAMPP)

```properties
spring.datasource.password=
```

Schema is auto-created by Hibernate (`ddl-auto=update`). Reference SQL: `db/schema.sql`

## URLs

| URL | Page |
|-----|------|
| `/` | Home |
| `/signup` | Register |
| `/login` | Login |
| `/dashboard` | Student dashboard |
| `/admin` | Admin panel (college management) |
| `/colleges` | College search |
| `/aptitude-test` | Aptitude test (login required) |
| `/aptitude-result` | Test results (stream or Class 12 courses) |

Legacy `.jsp` URLs redirect automatically.

## API

- `GET /api/colleges` — college list (public, filters supported)
- `POST /api/colleges/save` — save/unsave college (login required)
- `POST /api/aptitude/submit` — submit aptitude JSON (login required)

## Python recommendation engine

File: `src/main/resources/python/recommend.py`

Optional — if Python is not installed, Java fallback is used.

```bash
python src/main/resources/python/recommend.py 8 7 2 1 6 3 1
```

Config (`application.properties`):

```properties
edupath.python.enabled=true
edupath.python.command=python
```

On Windows, if `python` fails, try: `edupath.python.command=py`

## Security

- Spring Security protects authenticated routes
- Passwords stored with BCrypt
- Session-based login (30 min timeout)

## Tests

```bash
mvn test
```

Includes context load, login flow, and API auth smoke tests.
