# Django Boilerplate

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.0-4baaaa.svg)](code_of_conduct.md)
[![License: MIT](https://img.shields.io/github/license/vintasoftware/django-react-boilerplate.svg)](LICENSE.txt)

## About

A [Django](https://www.djangoproject.com/) project boilerplate/template with a multitude of state-of-the-art libraries and tools:

-   [Poetry](https://python-poetry.org/), for managing the environment and its dependencies
-   [Celery](https://docs.celeryq.dev/en/stable/), for background worker tasks
-   [WhiteNoise](https://whitenoise.readthedocs.io/en/stable/) with [brotlipy](https://github.com/python-hyper/brotlicffi), for efficient static files serving
-   [ruff](https://github.com/astral-sh/ruff) with [pre-commit](https://pre-commit.com/) for automated quality assurance

For continuous integration, a [Github Action](https://github.com/features/actions) configuration `.github/workflows/main.yml` is included.

Also, includes a Render.com `render.yaml` and a working Django `production.py` settings, enabling easy deployments with ['Deploy to Render' button](https://render.com/docs/deploy-to-render). The `render.yaml` includes the following:

-   PostgreSQL, for DB
-   Redis, for Celery

## Features Catalogue

### Backend

-   `django` for building backend logic using Python
-   `djangorestframework` for building a REST API on top of Django
-   `drf-spectacular` for generating an OpenAPI schema for the Django REST API
-   `django-guid` for adding a unique correlation ID to log messages from Django requests
-   `psycopg` for using PostgreSQL database
-   `sentry-sdk` for error monitoring
-   `python-decouple` for reading environment variables on settings files
-   `celery` for background worker tasks
-   `django-csp` for setting the draft security HTTP header Content-Security-Policy
-   `django-permissions-policy` for setting the draft security HTTP header Permissions-Policy
-   `django-defender` for blocking brute force attacks against login
-   `whitenoise` and `brotlipy` for serving static assets

## Share your project!

Several people have leveraged our boilerplate to start spinoffs or to boost their efforts in the challenging pursuit of securing funding. Starting with a solid foundation allows you to create more resilient products and focus on what really matters: discovering and delivering value to your customers. If you are one of those people, we're eager to help you even more! We can spread the word about your project across our social media platforms, giving you access to a broader audience.

Send us an email at contact@vintasoftware.com telling us a bit more about how our boilerplate helped you boost your project.

## Project bootstrap [![main](https://github.com/vintasoftware/django-react-boilerplate/actions/workflows/main.yml/badge.svg)](https://github.com/vintasoftware/django-react-boilerplate/actions/workflows/main.yml) [![Known Vulnerabilities](https://snyk.io/test/github/vintasoftware/django-react-boilerplate/badge.svg)](https://snyk.io/test/github/vintasoftware/django-react-boilerplate)

-   [ ] Make sure you have Python 3.12 installed
-   [ ] Install Django with `pip install django`, to have the `django-admin` command available
-   [ ] Open the command line and go to the directory you want to start your project in
-   [ ] Start your project using (replace `project_name` with your project name and remove the curly braces):
    ```
    django-admin startproject {{project_name}} --extension py,json,yml,yaml,toml --name Dockerfile,README.md,.env.example,.gitignore,Makefile,.npmrc --template=https://github.com/vintasoftware/django-react-boilerplate/archive/refs/heads/main.zip
    ```
    Alternatively, you may start the project in the current directory by placing a `.` right after the project name, using the following command:
    ```
    django-admin startproject {{project_name}} . --extension py,json,yml,yaml,toml --name Dockerfile,README.md,.env.example,.gitignore,Makefile,.npmrc --template=https://github.com/vintasoftware/django-react-boilerplate/archive/refs/heads/main.zip
    ```
In the next steps, always remember to replace {{project_name}} with your project's name (in case it isn't yet):
-   [ ] Above: don't forget the `--extension` and `--name` params!
-   [ ] Go into project's root directory: `cd {{project_name}}`
-   [ ] Change the first line of README to the name of the project
-   [ ] Add an email address to the `ADMINS` settings variable in `{{project_name}}/backend/{{project_name}}/settings/base.py`
-   [ ] Change the `SERVER_EMAIL` to the email address used to send e-mails in `{{project_name}}/backend/{{project_name}}/settings/production.py`

After completing ALL of the above, remove this `Project bootstrap` section from the project README. Then follow `Running` below.

## Running

### Tools

-   Setup [editorconfig](http://editorconfig.org/) and [ruff](https://github.com/astral-sh/ruff) in the text editor you will use to develop.

### Setup

-   Do the following:
    -   Create a git-untracked `local.py` settings file:
        `cp {{project_name}}/settings/local.py.example {{project_name}}/settings/local.py`
    -   Create a git-untracked `.env` file:
        `cp .env.example .env`

### If you are using Docker:

-   Open the `.env` file on a text editor and uncomment the line `DATABASE_URL=postgres://{{project_name}}:password@db:5432/{{project_name}}`
-   Open a new command line window and go to the project's directory
-   Run the initial setup:
    `make docker_setup`
-   Create the migrations for `users` app:
    `make docker_makemigrations`
-   Run the migrations:
    `make docker_migrate`
-   Run the project:
    `make docker_up`
-   Access `http://localhost:8000` on your browser and the project should be running there
-   To access the logs for each service, run:
    `make docker_logs <service name>` (either `backend`, `db`, etc)
-   To stop the project, run:
    `make docker_down`

#### Adding new dependencies

-   Open a new command line window and go to the project's directory
-   To add a new dependency, run `docker compose run --rm backend bash` to open an interactive shell and then run `poetry add {dependency}` to add the dependency. If the dependency should be only available for development, append `-G dev` to the command.
-   After updating dependencies, run `make docker_update_dependencies` to update the containers with the new dependencies

### If you are not using Docker:

#### Setup the app

-   Open the `.env` file on a text editor and do one of the following:
    -   If you wish to use SQLite locally, uncomment the line `DATABASE_URL=sqlite:///db.sqlite3`
    -   If you wish to use PostgreSQL locally, uncomment and edit the line `DATABASE_URL=postgres://{{project_name}}:password@db:5432/{{project_name}}` in order to make it correctly point to your database URL
        -   The url format is the following: `postgres://USER:PASSWORD@HOST:PORT/NAME`
    -   If you wish to use another database engine locally, add a new `DATABASE_URL` setting for the database you wish to use
        -   Please refer to [dj-database-url](https://github.com/jazzband/dj-database-url#url-schema) on how to configure `DATABASE_URL` for commonly used engines
-   Open a new command line window and go to the project's directory
-   Run `poetry install`

#### Run the app

-   Create the migrations for `users` app:
    `poetry run python manage.py makemigrations`
-   Run the migrations:
    `poetry run python manage.py migrate`
-   Generate the OpenAPI schema:
    `poetry run python manage.py spectacular --color --file schema.yml`
-   Run the project:
    `poetry run python manage.py runserver`

#### Setup Celery

-   `poetry run celery --app={{project_name}} worker --loglevel=info`

#### Setup Redis

-   Ensure that Redis is already installed on your system. Once confirmed, run `redis-server --port 6379` to start the Redis server.
-   If you wish to use Redis for Celery, you need to set the `CELERY_BROKER_URL` environment variable in the `.env` file to `redis://localhost:6379/0`.

#### Mailhog

-   For development, we use Mailhog to test our e-mail workflows, since it allows us to inspect the messages to validate they're correctly built
    -   Docker users already have it setup and running once they start the project
    -   For non-Docker users, please have a look [here](https://github.com/mailhog/MailHog#installation) for instructions on how to setup Mailhog on specific environments
        > The project expects Mailhog SMTP server to be running on port 1025, you may alter that by changing `EMAIL_PORT` on settings

### Testing

`make test`

Will run django tests using `--keepdb` and `--parallel`. You may pass a path to the desired test module in the make command. E.g.:

`make test someapp.tests.test_views`

### Adding new pypi libs

To add a new dependency, run `poetry add {dependency}`. If the dependency should be only available for development, append `-G dev` to the command.

### API Schema

We use the [`DRF-Spectacular`](https://drf-spectacular.readthedocs.io/en/latest/readme.html) tool to generate an OpenAPI schema from our Django Rest Framework API. The OpenAPI schema serves as the backbone for creating comprehensive API documentation.

The API documentation pages are accessible at `http://localhost:8000/api/schema/swagger-ui/` or `http://localhost:8000/api/schema/redoc/`.

> [!IMPORTANT]
> Anytime a view is created, updated, or removed, the schema must be updated to reflect the changes.
>
> To update the schema, run:
> - If you are using Docker: `make docker_update_schema`
> - If you are not using Docker: `poetry run python manage.py spectacular --color --file schema.yml`

## Github Actions

To enable Continuous Integration through Github Actions, we provide a `proj_main.yml` file. To connect it to Github you need to rename it to `main.yml` and move it to the `.github/workflows/` directory.

You can do it with the following commands:

```bash
mkdir -p .github/workflows
mv proj_main.yml .github/workflows/main.yml
```

## Production Deployment

### Setup

This project comes with an `render.yaml` file, which can be used to create an app on Render.com from a GitHub repository.

Before deploying, please make sure you've generated an up-to-date `poetry.lock` file containing the Python dependencies.

After setting up the project, you can init a repository and push it on GitHub. If your repository is public, you can use the following button:

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

If you are in a private repository, access the following link replacing `$YOUR_REPOSITORY_URL$` with your repository link.

-   `https://render.com/deploy?repo=$YOUR_REPOSITORY_URL$`

Keep reading to learn how to configure the prompted environment variables.

#### `ALLOWED_HOSTS`

Chances are your project name isn't unique in Render, and you'll get a randomized suffix as your full app URL like: `https://{{project_name}}-a1b2.onrender.com`.

But this will only happen after the first deploy, so you are not able to properly fill `ALLOWED_HOSTS` yet. Simply set it to `*` then fix it later to something like `{{project_name}}-a1b2.onrender.com` and your domain name like `example.org`.

#### `ENABLE_DJANGO_COLLECTSTATIC`

Default is 1, meaning the build script will run collectstatic during deploys.

#### `AUTO_MIGRATE`

Default is 1, meaning the build script will run migrate during deploys.

#### `SECRET_KEY`

Django requires a SECRET_KEY that is at least 50 characters long and with enough randomness. Render's `generateValue: true` produces a shorter value (about 44 characters) that does not meet Django's security check, so it fails with `security.W009`.

The correct approach is to declare the variable with `sync: false`. That way, the `SECRET_KEY` is not stored in the repository, and the first time the Blueprint is created, Render will prompt you to provide the secret value manually.

You can generate a new key by running the following command on your local machine:

```bash
python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

### Build script

By default, the project will always run the `render_build.sh` script during deployments. This script does the following:

1.  Install Python dependencies
2.  Run Django checks
3.  Run `collectstatic`
4.  Run Django migrations

### Celery

As there aren't free plans for Workers in Render.com, the configuration for Celery workers/beat will be commented by default in the `render.yaml`. This means celery won't be available by default.

Uncommenting the worker configuration lines on `render.yaml` will imply in costs.

### SendGrid

To enable sending emails from your application you'll need to have a valid SendGrid account and also a valid verified sender identity. After finishing the validation process you'll be able to generate the API credentials and define the `SENDGRID_USERNAME` and `SENDGRID_PASSWORD` environment variables on Render.com.

These variables are required for your application to work on Render.com since it's pre-configured to automatically email admins when the application is unable to handle errors gracefully.

### Media storage

Media files integration with S3 or similar is not supported yet. Please feel free to contribute!

### Sentry

[Sentry](https://sentry.io) is already set up on the project. For production, add `SENTRY_DSN` environment variable on Render.com, with your Sentry DSN as the value.

## Linting

-   At pre-commit time (see below)
-   Manually with `poetry run ruff` on project root.
-   During development with an editor compatible with ruff.

## Pre-commit hooks

### If you are using Docker:

-   On project root, run `make docker_precommit_setup` to enable the hook into your git repo, the file `pre-commit-docker.sh` will be copied to `.git/hooks/pre-commit`. The hook will run automatically for each commit **inside the backend container**.

### If you are not using Docker:

-   On project root, run `poetry run pre-commit install` to enable the hook into your git repo. The hook will run automatically for each commit.

## Opinionated Settings

Some settings defaults were decided based on Vinta's experiences. Here's the rationale behind them:

### `DATABASES["default"]["ATOMIC_REQUESTS"] = True`

- Using atomic requests in production prevents several database consistency issues. Check [Django docs for more details](https://docs.djangoproject.com/en/5.0/topics/db/transactions/#tying-transactions-to-http-requests).

- **Important:** When you are queueing a new Celery task directly from a Django view, particularly with little or no delay/ETA, it is essential to use `transaction.on_commit(lambda: my_task.delay())`. This ensures that the task is only queued after the associated database transaction has been successfully committed.

### `CELERY_TASK_ACKS_LATE = True`

- We believe Celery tasks should be idempotent. So for us it's safe to set `CELERY_TASK_ACKS_LATE = True` to ensure tasks will be re-queued after a worker failure. Check Celery docs on ["Should I use retry or acks_late?"](https://docs.celeryq.dev/en/stable/faq.html#faq-acks-late-vs-retry) for more info.

### Django-CSP

Django-CSP helps implementing Content Security Policy (CSP) in Django projects to mitigate cross-site scripting (XSS) attacks by declaring which dynamic resources are allowed to load.

In this project, we have defined several CSP settings that define the sources from which different types of resources can be loaded. If you need to load external images, fonts, or other resources, you will need to add the sources to the corresponding CSP settings.

Please note that you should only add trusted sources to these settings to maintain the security of your site. For more details, please refer to the [Django-CSP documentation](https://django-csp.readthedocs.io/en/latest/).

## Contributing

If you wish to contribute to this project, please first discuss the change you wish to make via an [issue](https://github.com/vintasoftware/django-react-boilerplate/issues).

## Commercial Support

[![alt text](https://avatars2.githubusercontent.com/u/5529080?s=80&v=4 "Vinta Logo")](https://www.vinta.com.br/)

This project is maintained by [Vinta Software](https://www.vinta.com.br/) and is used in products of Vinta's clients. We are always looking for exciting work! If you need any commercial support, feel free to get in touch: contact@vinta.com.br
