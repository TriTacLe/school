---
type: area
course: STA2020S
institution: UCT
semester: 2026-S2
project: uct
---
## STA2020S Applied Statistics
UCT, Department of Statistical Sciences. Applied methods in R: regression, ANOVA, nonparametric tests, time series. Lectures Mon to Thu 15:00, JD LT 1. Full outline: [[materials/reference/course-outline-2026.pdf|course outline]].
## Schedule and notes
| Week | Dates | Topic | Note |
| ---- | ----- | ----- | ---- |
| 1 | 27-31 Jul | Simple linear regression | [[week-01-simple-linear-regression]] |
| 2 | 3-7 Aug | Multiple regression | [[week-02-multiple-regression]] |
| 3 | 11-14 Aug | Model building, logistic regression | [[week-03-model-building-logistic-regression]] |
| 4 | 17-21 Aug | Experimental design, CRD (one-way ANOVA) | [[week-04-experimental-design-crd]] |
| 5 | 24-28 Aug | CRD and RCBD | [[week-05-rcbd]] |
| 6 | 31 Aug-4 Sep | Factorial experiments | [[week-06-factorial-experiments]] |
| - | 7-11 Sep | Vacation week | |
| 7 | 14-18 Sep | Nonparametrics: Wilcoxon, Mann-Whitney, Kruskal-Wallis | [[week-07-nonparametric-tests-1]] |
| 8 | 21-25 Sep | Nonparametrics: Friedman, Spearman | [[week-08-nonparametric-tests-2]] |
| 9 | 28 Sep-2 Oct | TS intro, moving average, decomposition, forecaster's toolbox | [[week-09-time-series-decomposition]] |
| 10 | 5-9 Oct | Exponential smoothing, ACF and PACF | [[week-10-exponential-smoothing-acf]] |
| 11 | 12-16 Oct | ARIMA modelling | [[week-11-12-arima]] |
| 12 | 19-23 Oct | ARIMA modelling | [[week-11-12-arima]] |
| 13 | 26-27 Oct | Revision | |
## Assessments
- **CT1, Mon 17 Aug**: all regression content, R coding for weeks 1-2.
- **CT2, Mon 28 Sep**: ANOVA + first week of nonparametrics, R coding for weeks 4-7.
- **CT3, Thu 22 Oct**: nonparametrics + time series up to exponential smoothing, R coding weeks 7-10.
- **CT4, Tue 27 Oct**: make-up only, all content weeks 1-12. Only under specific conditions (see outline section 4.1.3).
- **Exam**: after 4 Nov.
- Final mark = 0.4 x class record (CT1-3 equal weight + up to 5% lecture attendance bonus) + 0.6 x exam.
- DP: class record >= 35%, weekly R labs compulsory (max 2 missed), >= 70% lecture attendance.
- Weekly quizzes optional but class tests resemble them. Tutorials optional, memos Friday 17:00.
## Folder map
- `notes/` — one note per week, exam-ready summaries. Start here.
- `materials/lectures/` — annotated lecture slides and topic summaries.
- `materials/reference/` — [[materials/reference/formulae-sta2020-2025.pdf|formula sheet]], [[materials/reference/statistical-tables.pdf|tables]], [[materials/reference/course-mindmap.pdf|course mindmap]], RStudio cheat sheet, R FAQ, course outline.
- `materials/textbook/` — IntroStat (background from STA1000).
- `practice/` — practice sets and labs.
- `past-papers/` — class test memos and past exam. `sta2020s` = this course; `sta2020f` = first-semester twin, same syllabus.
- `data/` — CSV datasets for R labs and examples.
- `r/` — RStudio project and scripts. Open `r/STA2020S.Rproj` in RStudio; everything saved there lands in the vault. See [[r-workflow]].
## Study workflow
1. Before lecture: skim the week's note skeleton, know what's coming.
2. During/after lecture: fill the skeleton, link the slide PDF.
3. Lab: work inside `r/STA2020S.Rproj`, load data with `sta_data("file.csv")`, save plots with `sta_save_plot("name")`, embed them in notes.
4. Before each CT: redo past papers in `past-papers/`, check against the [[materials/reference/formulae-sta2020-2025.pdf|formula sheet]] (allowed sheet in assessments is provided, know what is on it).
## Contacts
- Convenor (ANOVA, NP): Ané Cloete, ane.cloete@uct.ac.za, room 5.67 PD Hahn
- Regression: Delene van Wyk-de Ridder, delene.vanwyk@uct.ac.za, room 5.41
- Time series: Allan Clark, allan.clark@uct.ac.za, room 5.50
- Admin: Tandiswa Ntshongwana, tandiswa.ntshongwana@uct.ac.za
- Head tutor: Undjee Kangueehi, KNGUND001@myuct.ac.za
