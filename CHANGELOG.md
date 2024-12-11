# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2024-12-12

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`spark_board_backend` - `v0.0.4`](#spark_board_backend---v004)
 - [`spark_board_frontend` - `v0.0.2`](#spark_board_frontend---v002)

---

#### `spark_board_backend` - `v0.0.4`

 - **REFACTOR**: move `db.ts` to `db` folder.
 - **FIX**: task deletion (#24).
 - **FEAT**: update patch api response for task.
 - **FEAT**: api for assign/unassign task.
 - **FEAT**: add assignee field in tasks get api.
 - **FEAT**: CRUD api for `staff` (#21).
 - **FEAT**: update task status (#19).
 - **DOCS**: update db schema.
 - **DOCS**: update swagger docs.
 - **DOCS**: update postman collection.
 - **DOCS**: create `commands.md` for keep useful commands.

#### `spark_board_frontend` - `v0.0.2`

 - **FIX**: add label to `TaskStatus` enum (#20).
 - **FEAT**: assign staff to a task.
 - **FEAT**: staff list, update & delete (#22).
 - **FEAT**: update task status (#19).


## 2024-12-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`spark_board_backend` - `v0.0.3`](#spark_board_backend---v003)
 - [`spark_board_frontend` - `v0.0.1`](#spark_board_frontend---v001)

---

#### `spark_board_backend` - `v0.0.3`

 - **FIX**: enable cors.
 - **FEAT**: add `status` column in task table & apis.
 - **DOCS**: update postman collection and swagger docs (#18).
 - **DOCS**: add readme files.

#### `spark_board_frontend` - `v0.0.1`

 - **REFACTOR**: smooth scrolling on mouse wheel (#15).
 - **REFACTOR**: use slivers for tasks view (#14).
 - **FEAT**: delete task (#17).
 - **FEAT**: create new task.
 - **FEAT**: tasks get api integration.
 - **FEAT**: collapsible sidebar (#13).
 - **FEAT**: base ui for task view (#12).
 - **FEAT**: create project bar with project switcher (#11).
 - **FEAT**: shell route base.
 - **FEAT**: login ui and api integration - base (#9).
 - **DOCS**: add readme files.


## 2024-11-22

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`spark_board_backend` - `v0.0.2`](#spark_board_backend---v002)

---

#### `spark_board_backend` - `v0.0.2`

 - **REFACTOR**: global error handing (#7).
 - **FEAT**: get, post & delete apis for tasks (#8).
 - **FEAT**: `delete` api for project.
 - **FEAT**: `get` and `post` apis for projects (#5).
 - **DOCS**: update swagger docs and postman collection.
 - **DOCS**: update swagger implementation (#6).


## 2024-11-19

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`spark_board_backend` - `v0.0.1`](#spark_board_backend---v001)

---

#### `spark_board_backend` - `v0.0.1`

 - **FEAT**: implement jwt and `authGuard` middleware (#4).
 - **FEAT**(backend): user signup and login - base (#1).

