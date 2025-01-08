-- create user
INSERT INTO
	public.users (email, password, name)
VALUES
	(
		'albin@mail.com',
		'$2b$10$qGCEO5reymraou6BQF6UBO.nxLSEUYmTIcLmt0QtCY9Y29qpFQyk2',
		'Albin'
	);



-- create project
INSERT INTO
	public.projects (owner_id, name, description)
VALUES
	(
		(
			SELECT
				user_id
			FROM
				users
		),
		'Project 1',
		'Desc'
	);



-- create staff
INSERT INTO
	public.staff (name, email)
VALUES
	('Albin', 'albin@mail.com'),
	('Alex', 'alex@mail.com');



-- create task
INSERT INTO
	public.tasks (project_id, name)
VALUES
	(
		(
			SELECT
				project_id
			FROM
				projects
		),
		'Task 1'
	);



-- assign task
INSERT INTO
	public.task_assignee (task_id, staff_id)
VALUES
	(
		(
			SELECT
				task_id
			FROM
				tasks
		),
		(
			SELECT
				staff_id
			FROM
				staff
			LIMIT
				1
		)
	);
