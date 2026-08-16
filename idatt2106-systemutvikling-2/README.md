---
type: area
status: evergreen
created: 2026-04-17
modified: 2026-04-17
tags: []
---

| Class Name                                                     | Type           | Depends On                                       |     |
| -------------------------------------------------------------- | -------------- | ------------------------------------------------ | --- |
| `AchievementResponseDto`                                       | ==DTO==        | —                                                |     |
| `TaskRequestDto` + `TaskResponseDto`                           | ==DTO==        | —                                                |     |
| `TaskBestScoreResponseDto`                                     | ==DTO==        | —                                                |     |
| `UserAchievementResponseDto`                                   | ==DTO==        | —                                                |     |
| `NotebookEntryRequestDto` + `NotebookEntryResponseDto`         | ==DTO==        | —                                                |     |
| `MysterySubmissionRequestDto` + `MysterySubmissionResponseDto` | ==DTO==        | —                                                |     |
| `NotificationResponseDto`                                      | ==DTO==        | —                                                |     |
| `TaskAttemptRequestDto` + `TaskAttemptResponseDto`             | ==DTO==        | —                                                |     |
| `AchievementMapper`                                            | ==Mapper==     | `Achievement` + `AchievementResponseDto`         |     |
| `TaskMapper`                                                   | ==Mapper==     | `Task` + `TaskRequestDto` + `TaskResponseDto`    |     |
| `TaskBestScoreMapper`                                          | ==Mapper==     | `TaskBestScore` + `TaskBestScoreResponseDto`     |     |
| `UserAchievementMapper`                                        | ==Mapper==     | `UserAchievement` + `UserAchievementResponseDto` |     |
| `NotebookEntryMapper`                                          | ==Mapper==     | `NotebookEntry` + Notebook DTOs                  |     |
| `MysterySubmissionMapper`                                      | ==Mapper==     | `MysterySubmission` + Mystery DTOs               |     |
| `NotificationMapper`                                           | ==Mapper==     | `Notification` + `NotificationResponseDto`       |     |
| `TaskAttemptMapper`                                            | ==Mapper==     | `TaskAttempt` + Attempt DTOs                     |     |
| `AchievementService`                                           | ==Service==    | `AchievementRepository` + `AchievementMapper`    |     |
| `TaskService`                                                  | ==Service==    | `TaskRepository` + `UserService` + `TaskMapper`  |     |
| `AchievementController`                                        | ==Controller== | `AchievementService`                             |     |
| `TaskController`                                               | ==Controller== | `TaskService`                                    |     |

**Blocked by Nora (ClassroomService)**

| Class Name | Type | Blocked By |
|------------|------|------------|
| `TaskAttemptService` | ==Service== | `ClassroomService`, `TaskService` |
| `NotebookService` | ==Service== | `ClassroomService`, `UserService` |
| `MysteryService` | ==Service== | `ClassroomService`, `UserService`, `AchievementService` |
| `NotificationService` | ==Service== | `ClassroomService`, `UserService` |
| `TaskAttemptController` | ==Controller== | `TaskAttemptService` |
| `NotebookController` | ==Controller== | `NotebookService` |
| `MysteryController` | ==Controller== | `MysteryService` |

**Must do**
  - Return DTOs from controllers, never JPA entities
  - Use `ApiResponse<T>` as the response body in every controller
  - Add `@PreAuthorize` on every endpoint that modifies data
  - Add `@Valid` on all request DTOs in controllers
  - Add `@Enumerated(EnumType.STRING)` on all ENUM fields
  - Write unit tests (JUnit 5 + Mockito) for all service logic before pushing
  - Write integration tests (Testcontainers + MySQL) for anything touching triggers
  - Call `sp_submit_attempt` via `JdbcTemplate` - only entry point for registering attempts
  - Read back state after calling `sp_submit_attempt` - never calculate it yourself
  - Use `FetchType.LAZY` on all `@ManyToOne` and `@OneToMany` relations
  - Base URL always `localhost:8080/api/v1/`

  **Must not do**
  - Never call `.save()` on `TaskBestScore` - trigger managed, read-only
  - Never re-implement trigger logic in Java (`trg_attempt_sync`, `trg_mystery_approved`,`trg_classroom_auto_instructor`)
  - Never award achievements manually in service code - `trg_mystery_approved` handles it
  - Never create notifications manually - `trg_mystery_approved` handles it
  - Never touch `security/` - owned by Nora
  - Never use wildcard imports (`import lombok.*`)
  - Never return raw stack traces - `GlobalExceptionHandler` handles all exceptions


## See also
- [[idatt2106-moc]]
