# collabs

Repositorio de investigación académica en ciencias sociales. Alberga proyectos de colaboración multi-institucional que abordan fenómenos sociales, económicos y organizacionales desde diversas aproximaciones metodológicas: cuantitativa, cualitativa y mixta.

Organizado por fecha (`YYYY-MM-DD/project-name/`), cada proyecto es independiente: con sus propios datos, instrumentos, análisis y documentos. El repositorio provee la infraestructura compartida (scripts, convenciones, flujo de trabajo) y un entorno Python gestionado con `uv` para reproducibilidad.

---

## Proyectos

### 26-05-31 — gamez

| | |
|---|---|
| **Título** | Educación financiera en adolescentes — Autlán de Navarro |
| **Autores** | Luis Carlos Gamez Adame (director); sustentante de tesis de maestría |
| **Tema** | Nivel de educación financiera en estudiantes de secundaria y bachillerato |
| **Metodología** | Descriptivo-comparativo, cuantitativo, no experimental, transversal. Cuestionario con 14 ítems Likert + 4 demográficos aplicado a 656 adolescentes. Pruebas: frecuencias, alfa de Cronbach, chi-cuadrado, Friedman, Mann-Whitney U. |
| **Estado** | Completado |

### 26-06-09 — aaron

| | |
|---|---|
| **Título** | Gobierno corporativo y permanencia de las PYMES en Autlán de Navarro |
| **Autores** | José Raúl Avalos Gutiérrez, Aaron Cobian Puebla |
| **Tema** | Incidencia del gobierno corporativo en la permanencia en el mercado de las PYMES |
| **Metodología** | Cuantitativo, transversal, encuesta. Instrumento con 43 ítems Likert en 10 dimensiones, aplicado a 136 directivos. Pruebas: frecuencias, moda, alfa de Cronbach, W de Kendall, chi-cuadrado, prueba de hipótesis para una muestra. |
| **Estado** | Completado |

### 26-06-09 — luz

| | |
|---|---|
| **Título** | Factores asociados al fortalecimiento del capital social en SOCAPs |
| **Autores** | — |
| **Tema** | Evaluación de satisfacción, cualidades de productos, recompensas y obra social como factores asociados al capital social en cooperativas de ahorro y préstamo |
| **Metodología** | Descriptivo-correlacional, cuantitativo, no experimental, transversal. Cuestionario con 18 ítems Likert en 5 dimensiones, aplicado a 15 directivos. Pruebas: frecuencias, alfa de Cronbach, t para una muestra, W de Kendall, Spearman. |
| **Estado** | Completado |

---

## Infraestructura compartida

| Archivo | Propósito |
|---|---|
| `AGENTS.md` | Convenciones del repositorio, flujo de trabajo, principios de rigor científico |
| `src/crear_referencia.py` | Genera `reference.docx` (Times New Roman 12, interlineado 1.5, márgenes 3 cm, tamaño carta) para conversiones pandoc |
| `src/formatear_tablas.py` | Aplica estilo booktabs a tablas en archivos .docx generados por pandoc |
| `sync.sh` | Sincronización bidireccional entre Linux (`/home/.../collabs`) y Windows (`/mnt/d/collabs`) para trabajo con SPSS |
| `template/` | Estructura de directorios estándar para nuevos proyectos |
| `pyproject.toml` + `uv.lock` | Entorno Python gestionado con `uv` (pandas, scipy, pingouin, matplotlib, seaborn) |

---

## Colaboraciones futuras

Este repositorio está concebido como un espacio abierto a nuevas colaboraciones. Algunas líneas posibles:

- **Investigación mixta**: complementar encuestas con entrevistas semiestructuradas, grupos focales o análisis de contenido.
- **Estudios longitudinales**: seguimiento de cohortes para capturar cambios temporales en las variables de interés.
- **Diseños experimentales y cuasi-experimentales**: evaluación de intervenciones en contextos educativos, organizacionales o comunitarios.
- **Temas interdisciplinarios**: ciencias sociales, administración, educación, economía, salud pública, desarrollo regional.
- **Colaboración multi-institucional**: estudiantes de posgrado, directores de tesis, coautores externos, cuerpos académicos.
- **Análisis nativo en Python**: migración progresiva desde SPSS hacia scripts Python reproducibles, aprovechando el entorno `uv` ya configurado.
- **Publicación en acceso abierto**: preparación de manuscritos para revistas indexadas, congresos y repositorios institucionales.

---

## Cómo iniciar un nuevo proyecto

```bash
cp -r template/ YYYY-MM-DD/nuevo-proyecto/
cd YYYY-MM-DD/nuevo-proyecto/
# Editar README.md con la descripción del estudio
```

Consultar `AGENTS.md` para convenciones completas: estructura, editorial, flujo de trabajo y principios de rigor científico.
